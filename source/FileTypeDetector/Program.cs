using System;
using System.IO;
using Microsoft.AspNetCore.StaticFiles;
using HeyRed.Mime;

namespace FileTypeDetector
{
    class Program
    {
        static int Main(string[] args)
        {
            if (args.Length < 1 || args.Length > 2)
            {
                Console.WriteLine("Usage: FileTypeDetector <path_to_file> [path_to_magic.mgc]");
                return 1;
            }

            string filePath = args[0];
            if (!File.Exists(filePath))
            {
                Console.Error.WriteLine($"File not found: {filePath}");
                return 1;
            }

            // 1) По расширению
            string extMime = GetMimeTypeByExtension(Path.GetExtension(filePath));

            // 2) По содержимому
            string customMagic = args.Length == 2 ? args[1] : null;
            string contentMime = GetMimeTypeByContent(filePath, customMagic);

            Console.WriteLine($"По расширению:  {extMime}");
            Console.WriteLine($"По содержимому: {contentMime}");
            return 0;
        }

        static string GetMimeTypeByExtension(string extension)
        {
            if (string.IsNullOrEmpty(extension))
                return "– нет расширения –";

            var provider = new FileExtensionContentTypeProvider();
            if (provider.TryGetContentType("file" + extension, out var mime))
                return mime;

            return $"application/{extension.TrimStart('.')} (неизвестное)";
        }

        static string GetMimeTypeByContent(string path, string magicDbPath)
        {
            var fi = new FileInfo(path);
            if (fi.Length == 0)
                return "Пустой файл";

            if (!string.IsNullOrEmpty(magicDbPath))
                MimeGuesser.MagicFilePath = magicDbPath;

            try
            {
                // GuessMimeType возвращает строку вида "image/png" или null
                var mime = MimeGuesser.GuessMimeType(path);
                return !string.IsNullOrEmpty(mime)
                    ? mime
                    : "Неизвестный формат содержимого";
            }
            catch (MagicException mex)
            {
                return $"Ошибка libmagic: {mex.Message}";
            }
        }
    }
}

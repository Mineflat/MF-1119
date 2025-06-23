#!/bin/bash

BASE_DIR="./test_data"
mkdir -p "$BASE_DIR"

# Вспомогательная функция для создания текстового файла
create_text_file() {
  echo "Example content for $1" > "$1"
}

# Вспомогательная функция для создания бинарного файла-заглушки
create_binary_file() {
  head -c 256 /dev/urandom > "$1"
}

# Вспомогательная функция для создания картинки-заглушки (JPEG)
create_image_file() {
  convert -size 100x100 xc:red "$1" 2>/dev/null || echo "FakeImage" > "$1"
}

# Создание директорий
mkdir -p "$BASE_DIR/text"
mkdir -p "$BASE_DIR/binary"
mkdir -p "$BASE_DIR/images"
mkdir -p "$BASE_DIR/combo"
mkdir -p "$BASE_DIR/office_new"
mkdir -p "$BASE_DIR/office_old"
mkdir -p "$BASE_DIR/office_new_pwd"
mkdir -p "$BASE_DIR/office_old_pwd"
mkdir -p "$BASE_DIR/archives"
mkdir -p "$BASE_DIR/archives_pwd"

# Текстовые файлы
for ext in sql txt eml; do
  create_text_file "$BASE_DIR/text/sample.$ext"
done

# Бинарные файлы
for ext in exe jar dll; do
  create_binary_file "$BASE_DIR/binary/sample.$ext"
done

# Картинки
for ext in jpg png tiff; do
  create_image_file "$BASE_DIR/images/sample.$ext"
done

# Комбинированные форматы
create_binary_file "$BASE_DIR/combo/sample.pdf"
create_binary_file "$BASE_DIR/combo/sample.mp4"

# Офисные новые
for ext in docx xlsx pptx; do
  create_binary_file "$BASE_DIR/office_new/sample.$ext"
done

# Офисные старые
for ext in doc xls; do
  create_binary_file "$BASE_DIR/office_old/sample.$ext"
done

# Офисные новые с паролем (заглушка)
for ext in docx xlsx pptx; do
  echo "Password inside document" > "$BASE_DIR/office_new_pwd/sample.$ext"
done

# Офисные старые с паролем (заглушка)
for ext in doc xls; do
  echo "Password inside document" > "$BASE_DIR/office_old_pwd/sample.$ext"
done

# Архивы без пароля
cd "$BASE_DIR"
echo "test" > file.txt
tar -cf archives/sample.tar file.txt
gzip -c file.txt > archives/sample.gz
tar -czf archives/sample.tar.gz file.txt
zip -q archives/sample.zip file.txt
rm file.txt

# Архивы с "паролем" (заглушки, если нет `zip -e` и т.д.)
echo "secret content" > secret.txt
zip -P "1234" archives_pwd/sample.zip secret.txt 2>/dev/null || echo "zip with password" > archives_pwd/sample.zip
tar -cf archives_pwd/sample.tar secret.txt
gzip -c secret.txt > archives_pwd/sample.gz
tar -czf archives_pwd/sample.tar.gz secret.txt
rm secret.txt

echo "Структура файлов создана в $BASE_DIR"

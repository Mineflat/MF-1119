#!/bin/bash
# Генерация 1
echo "Генерация 1:"
head -c101 /dev/urandom | tr -dc 'A-Z0-9' | fold -w4 | head -n4 | paste -sd-
# Генерация 2
echo "Генерация 2:"
head -c101 /dev/urandom | tr -dc 'A-Z0-9' | fold -w4 | head -n4 | paste -sd-
# Генерация 3
echo "Генерация 3:"
head -c101 /dev/urandom | tr -dc 'A-Z0-9' | fold -w4 | head -n4 | paste -sd-
# Генерация 4
echo "Генерация 4:"
head -c101 /dev/urandom | tr -dc 'A-Z0-9' | fold -w4 | head -n4 | paste -sd-
# Генерация 5
echo "Генерация 5:"
head -c101 /dev/urandom | tr -dc 'A-Z0-9' | fold -w4 | head -n4 | paste -sd-
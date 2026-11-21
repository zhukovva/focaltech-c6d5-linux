# Установка сканера FocalTech 2808:c6d5

Пакет проверен на TECNO MEGABOOK T14 Air AMD с Ubuntu 26.04 LTS x86‑64 и libfprint 1.95.1+tod1. После установки сработали регистрация пальцев в настройках Ubuntu, разблокировка экрана и подтверждение прав в терминале.

## Установка

- **Для установки** скачайте `libfprint-2-tod1-focaltech-c6d5_0.1.0-1_amd64.deb`. Драйвер находится внутри пакета, зависимости APT загрузит из репозиториев Ubuntu.
- **Для пересборки** нужны `src/` и файлы `build.sh`, `tools/fptest.c` и `LICENSE`. Это пригодится, если в другой версии Ubuntu изменится интерфейс libfprint TOD.

## Установка на чистую Ubuntu 26.04 LTS

1. Скопируйте пакет на новую систему, подключитесь к интернету и откройте терминал в папке с пакетом. Выполните команды.

   ```sh
   sudo apt update
   sudo apt install ./libfprint-2-tod1-focaltech-c6d5_0.1.0-1_amd64.deb fprintd libpam-fprintd
   sudo systemctl stop fprintd.service
   ```

   Служба `fprintd` запустится при следующем обращении и загрузит установленный плагин.

2. Откройте **Настройки → Система → Пользователи → Вход по отпечатку пальца** и зарегистрируйте нужные пальцы. Для этого драйвера нужно 40 принятых касаний на палец. Блокировка и последующая разблокировка экрана проверят, что отпечаток работает в графическом интерфейсе. [Справка Ubuntu](https://help.ubuntu.com/stable/ubuntu-help/session-fingerprint.html.en)

3. Если нужен отпечаток для `sudo`, выполните `sudo pam-auth-update`. Отметьте **Fingerprint authentication** и оставьте отмеченным **Unix authentication**, чтобы сохранить вход по паролю. Сохраните настройки. [Справка по pam-auth-update](https://manpages.ubuntu.com/manpages/noble/man8/pam-auth-update.8.html)

4. Проверьте, что `sudo` запрашивает отпечаток при новой аутентификации.

   ```sh
   sudo -k
   sudo -v
   ```

## Пересборка из исходников

Понадобятся GCC, G++, pkgconf и пакеты `libfprint-2-tod-dev`, `libfprint-2-dev`, `libgusb-dev`, `libopencv-calib3d-dev`. Команда сборки — `sh build.sh`.

Исходный проект — [libfprint-focaltech-c652](https://github.com/ryryry-3302/libfprint-focaltech-c652), коммит `146513d06a312ac095c16a682dc587a2ca75d372`, лицензия LGPL-2.1-or-later.

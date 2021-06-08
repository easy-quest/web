

![Обложка: Что такое Ansible и как его использовать](https://tproger.ru/s3/uploads/2019/07/iconfinder_Server_Configuration_2801005-cover-icon.png)

# Что такое Ansible и как его использовать

[Переводы](https://tproger.ru/category/translations/), 2 июля 2019 в 16:38 71 339



Что такое Ansible? Это ПО с открытым исходным кодом, которое автоматизирует поставку программного обеспечения, управление конфигурацией и развёртывание приложений. Ansible помогает DevOps-специалистам автоматизировать сложные задачи.

Примечание Вы читаете улучшенную версию некогда выпущенной нами статьи.

1. 1. 1. [Ключевые особенности программы Ansible](https://tproger.ru/translations/ansible-how-to-use/#part1)
      2. [Установка и запуск](https://tproger.ru/translations/ansible-how-to-use/#part2)
      3. [Структура Ansible](https://tproger.ru/translations/ansible-how-to-use/#part3)
      4. [Демо «Реальное приложение»](https://tproger.ru/translations/ansible-how-to-use/#part4)
      5. [Дополнительные материалы](https://tproger.ru/translations/ansible-how-to-use/#part5)

## Ключевые особенности программы Ansible

- **Безагентное**. В клиенте не установлено программное обеспечение или агент, который общается с сервером.
- **Идемпотентное**. Независимо от того, сколько раз вы вызываете операцию, результат будет одинаковым.
- **Простое и расширяемое**. Программа Ansible написанa на Python и использует YAML для написания команд. Оба языка считаются относительно простыми в изучении.

## Установка и запуск

```
# ubuntu
sudo apt-get install ansible
#mac-OS
brew install ansible
```

Инструкцию по установке на другие ОС можно найти [здесь](https://docs.ansible.com/ansible/latest/installation_guide/index.html).



## Структура Ansible

### Модули

Это небольшие программы, выполняющие определённую работу на сервере. Например, вместо запуска этой команды:

```
sudo apt-get install htop
```

Мы можем использовать модуль *apt* и установить *htop*:

```
- name: Install htop
apt: name=htop
```

Использование модуля даст вам возможность узнать, установлен он или нет.



### Плагины

Ansible поставляется с несколькими удобными плагинами, и вы можете легко написать свой собственный.

### Инвентаризация хостов

Чтобы предоставить перечень хостов, нам нужно обозначить список, находящийся в файле инвентаризации. Он напоминает содержание файла *hosts*.

В простейшем виде он может содержать одну строку:

```sh
35.178.45.231  ansible_ssh_user=ubuntu
```

### Playbooks

Ansible playbooks — это способ отправки команд на удалённые компьютеры с помощью скриптов. Вместо того, чтобы индивидуально использовать команды для удалённой настройки компьютеров из командной строки, вы можете настраивать целые сложные среды, передавая скрипт одной или нескольким системам.

### group_vars

Файл содержит набор переменных, например имя пользователя и пароль базы данных.

### Роли

Это способ сгруппировать несколько задач в один контейнер, чтобы эффективно автоматизировать работу с помощью понятной структуры каталогов.

### Обработчики

Представляют собой списки задач, которые на самом деле не отличаются от обычных задач, на которые ссылается глобально уникальное имя и которые оповещаются уведомителями. Если ничто не уведомляет обработчик, он не будет запускаться. Независимо от того, сколько задач уведомляет обработчик, он запускается только один раз, после того как все задачи завершены.

### Теги

Если у вас playbook с большим объёмом, может быть полезно иметь возможность запускать только определённую часть его конфигурации.

## Демо «Реальное приложение»

Цель этой демонстрации — установить приложение Laravel в VPS. Для этого используем [*Lightsail*](https://aws.amazon.com/ru/lightsail/)*.*

### Последовательность действий для создания и запуска Laravel APP:

1. 1. [Создайте экземпляр Ubuntu Lightsail](https://tproger.ru/translations/ansible-how-to-use/#1).
   2. [Установите зависимости Ansible на ваш VPS](https://tproger.ru/translations/ansible-how-to-use/#2).
   3. [Добавьте SSH-ключи в Git](https://tproger.ru/translations/ansible-how-to-use/#3).
   4. [Выполните сборку хостов и ansible.cfg](https://tproger.ru/translations/ansible-how-to-use/#4).
   5. [Определите роль в Ansible](https://tproger.ru/translations/ansible-how-to-use/#5).
   6. [Определите обработчик](https://tproger.ru/translations/ansible-how-to-use/#6).
   7. [Установите модули PHP](https://tproger.ru/translations/ansible-how-to-use/#7).
   8. [Установите Nginx](https://tproger.ru/translations/ansible-how-to-use/#8).
   9. [Добавьте default-конфигурацию Nginx](https://tproger.ru/translations/ansible-how-to-use/#9).
   10. [Добавьте переменные для управления учётными данными БД, хоста, URL-адресом источника GitHub и переменными *.env*](https://tproger.ru/translations/ansible-how-to-use/#10).
   11. [Используйте Ansible-Vault](https://tproger.ru/translations/ansible-how-to-use/#11).
   12. [Создайте базу данных MySql, имя пользователя и пароль](https://tproger.ru/translations/ansible-how-to-use/#12).
   13. [Клонируйте кодовую базу в ваш VPS](https://tproger.ru/translations/ansible-how-to-use/#13).
   14. [Сгенерируйте *.env*](https://tproger.ru/translations/ansible-how-to-use/#14).
   15. [Создайте playbook](https://tproger.ru/translations/ansible-how-to-use/#15).

Рассмотрим каждый пункт подробнее.

### Создание экземпляра Ubuntu Lightsail

Перейдите на панель управления Lightsail и нажмите «Создать экземпляр».

[![Панель управления Lightsail](https://tproger.ru/s3/uploads/2019/07/1_BJsuHjjOv8l-iWyK_HCimg1.jpg)](https://tproger.ru/s3/uploads/2019/07/1_BJsuHjjOv8l-iWyK_HCimg1.jpg)

Выберите свою любимую ОС.

[![Выбор ОС в панели управления Lightsail](https://tproger.ru/s3/uploads/2019/07/1_RyjXMXMvPNTju05QD8hK1Q1.jpg)](https://tproger.ru/s3/uploads/2019/07/1_RyjXMXMvPNTju05QD8hK1Q1.jpg)

Выберите «Добавить скрипт запуска», который запускается после создания вашего экземпляра. Не забудьте получить SSH-ключ.

[![Добавления скрипта запуска и SSH ключа](https://tproger.ru/s3/uploads/2019/07/1_szDeGFIuFnXMJAx9ri6ANg1.jpg)](https://tproger.ru/s3/uploads/2019/07/1_szDeGFIuFnXMJAx9ri6ANg1.jpg)

### Установка зависимостей Ansible на нашем VPS

Добавьте эти sh-команды для установки зависимостей:

```
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt-get update
sudo apt-get install -y python2.7 python3 python-pip
```

[![Скрипт установки зависимостей для программы Ansible](https://tproger.ru/s3/uploads/2019/07/1_mv8hONZPT7zZjG0-bJ2XGQ1.jpg)](https://tproger.ru/s3/uploads/2019/07/1_mv8hONZPT7zZjG0-bJ2XGQ1.jpg)[![Готовый экземпляр VPS](https://tproger.ru/s3/uploads/2019/07/1_SFEcu-pqfMrQSkBT0BKBEQ1.jpg)](https://tproger.ru/s3/uploads/2019/07/1_SFEcu-pqfMrQSkBT0BKBEQ1.jpg)

Теперь у нас есть готовый экземпляр, перейдём к построению Ansible Project.

### Добавление SSH-ключей в Git

Вы должны добавить свой сервер *id_rsa.pub* к своим ключам GitHub SSH, войдя в свой сервер.

```clike
# Подключитесь к вашему серверу через SSH и запустите
ssh-keygen
sudo chmod -R 644 .ssh/id_rsa
cat .ssh/id_rsa.pub

# Добавьте результат команды в аккаунт Git
# github settings=> SSH keys => Add new Key
# bitbucket settings=> ssh-keys => Add new Key
```

[Введение в Git: от установки до основных командtproger.ru](https://tproger.ru/translations/beginner-git-cheatsheet/)



### Сборка хостов и ansible.cfg

hosts.ini

```
[aws]
# Ваш IP сервера
127.0.0.39
```

ansible.cfg

```
[defaults]
hostfile = hosts.ini
# configure log dir
log_path= logs/ansible-log.log
```

### Определение роли в Ansible

Используем модуль Ping, чтобы убедиться, что хост работает, после чего нужно обновить все пакеты и установить два модуля: *git* и *htop*.

```clike
---
- ping: ~
###
- name: Update apt packages
  apt:
    update_cache: yes
##
- name: Install GIT VCS
  apt:
    name: git
    state: latest
##
- name: Install htop
  apt: name=htop
```

### Определение обработчика

```clike
---
- name: Restart PHP-FPM
  service:
    name: php{{php_version}}-fpm
    state: restarted
    ####
- name: Restart Nginx
  service:
    name: nginx
    state: restarted
```

### Установка модулей PHP

Чтобы вызвать обработчик, мы должны использовать *notify: Restart PHP-FPM*, имена обработчиков должны быть уникальными.

В этом руководстве мы определили *php* как тег, поэтому, например, если вы хотите запустить только эту задачу из своего playbook, вам необходимо выполнить её с  *—tags = ”php”*, которая будет исполнять только её.

```clike
---
- name: Install PHP {{php_version}} PPA Repo
  apt_repository:
    repo: 'ppa:ondrej/php'
  tags:
    - php
  ##
- name: Install PHP {{php_version}}
  apt: name=php{{php_version}} state=latest
  ##
- name: Install PHP packages
  become: true
  apt:
    name: "{{ item }}"
    state: latest
  with_items:
    - php{{php_version}}-curl
    - php{{php_version}}-fpm
    - php{{php_version}}-intl
    - php{{php_version}}-mysql
    - php{{php_version}}-xml
    - php{{php_version}}-mbstring
  notify: Restart PHP-FPM
  tags:
    - php
```

### Установка Nginx

```clike
- name: Install Nginx web server
  apt:
    name: nginx
    state: latest
  notify: Restart Nginx
  tags:
    - nginx

###
- name: Update nginx config files
  become: true
  template:
    src: templates/nginx.conf
    dest: "/etc/nginx/sites-available/default"
  tags:
    - nginx
  notify: Restart Nginx

###
- name: link nginx config
  become: true
  file:
    src: "/etc/nginx/sites-available/default"
    dest: "/etc/nginx/sites-enabled/default"
    state: link
  tags:
    - nginx
  notify: Restart Nginx
```

### Добавление default-конфигурации Nginx

```clike
server {
        listen 80 default_server;
        listen [::]:80 default_server ipv6only=on;
		server_name {{ server_name }};
        root  {{ app_work_dir }}public;

            location / {
        try_files $uri $uri/ /index.php?$args;
        index  index.php index.html index.htm;
    }

    if (!-d $request_filename) {
        rewrite ^/(.*)/$ /$1 permanent;
    }

    location = /favicon.ico {
        access_log     off;
        log_not_found  off;
    }

    location ~ \.php$ {
        try_files $uri $uri/ /index.php?$args;
        index index.php index.html index.htm;

        fastcgi_pass unix:/var/run/php/php{{php_version}}-fpm.sock;
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME  {{app_work_dir}}public$fastcgi_script_name;
        fastcgi_param  APPLICATION_ENV testing;
        fastcgi_param  PATH /usr/bin:/bin:/usr/sbin:/sbin;
        fastcgi_intercept_errors on;
        include        fastcgi_params;
    }
}
```

### vars.yml

```clike
---
##@ref https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html#variables-and-vaults
ansible_ssh_user: "ubuntu"
current_user: "ubuntu"
server_name: "app_name"

repo_git_url: "app_github_url"
ansible_ssh_private_key_file: "ssh_dir"
php_version: 7.2
app_work_dir: /var/www/app_name/

#mysql config
mysql_host: "mysql_host"
mysql_db: app_name
mysql_user: sql_user
mysql_pass: sql_pass

#other config
cache_driver: file
session_driver: file
app_env: production
app_debug: false
app_key: "your_app_key"
app_name: "app_name"
app_url: "your_app_url"
```

Примечание: Рекомендуется использовать ansible-vault для шифрования и дешифрования переменных.

### Как использовать Ansible-Vault

Создайте секретный файл хранилища, содержащий ключ шифрования, который шифрует ваши переменные.

```
touch .vault_pass.txt
echo 'YOUR_CONFIG_PASS' > .vault_pass.txt
```

Чтобы зашифровать переменные, используйте:

```
ansible-vault encrypt group_vars/vars.yml --vault-password-file .vault_pass.txt
```

Чтобы расшифровать переменные, используйте:

```
ansible-vault decrypt group_vars/vars.yml --vault-password-file .vault_pass.txt
```

### Создание базы данных MySql, имени пользователя и пароля

```clike
- mysql_user:
    name: "{{mysql_user}}"
    password: "{{mysql_pass}}"
    priv: '*.*:ALL'
    state: present
  tags:
     - mysql-db

     ##
- name:  Create APP DB database
  mysql_db: name="{{mysql_db}}" state=present login_user="{{mysql_user}}" login_password="{{mysql_pass}}"
```

`mysql_user` и `mysql_pass` определены внутри *vars.yml*.

### Клонирование кодовой базы

```clike
- name: update repo - pull the latest changes
  git:
    repo: "{{repo_git_url}}"
    dest: "{{app_work_dir}}"
    update: yes
    version: master
    accept_hostkey: yes
    key_file: /home/{{current_user}}/.ssh/id_rsa
  tags:
    - code-deploy
```

`repo_git_url` и `app_work_dir` определены внутри *vars.yml*.

### Генерирование *.env*

Ansible использует шаблонизатор Jinja2 для динамических выражений и доступа к переменным. Создадим файл *env.conf*.

```clike
APP_ENV={{app_env}}
APP_DEBUG={{app_debug}}
APP_KEY={{app_key}}
APP_URL={{app_url}}
APP_NAME={{app_name}}

DB_HOST={{mysql_host}}
DB_DATABASE={{mysql_db}}
DB_USERNAME={{mysql_user}}
DB_PASSWORD={{mysql_pass}}

CACHE_DRIVER={{cache_driver}}
SESSION_DRIVER={{session_driver}}
```

Определим `role`, чтобы переместить этот шаблон в директорию нашего приложения.

```clike
---
- name: Copy lara env file
  become: true
  template:
    src: templates/env.conf
    dest: "{{app_work_dir}}/.env"
  tags:
    - env-file
```

### Создание playbook

```clike
---
- hosts: aws
#common options between modules
  sudo: yes
  gather_facts: no

  vars_files:
    - ./group_vars/vars.yml
  roles:
    - misc
    - php
    - mysql
    - redis
    - nginx
    - bootstrap-app
    - code-deploy
    ###
  handlers:
    - include: handlers/main.yml
```

Как видно, мы определили *aws* как хост для этого playbook, и *sudo yes* даёт нам возможность выполнять команду как пользователю *sudo*. У нас есть *vars_files*, где мы храним наши *vars*. Мы установили *roles*, каждая *role* выполняет определённую задачу. И, наконец, у нас есть *handlers*, которые содержат все обработчики проекта.

### Запуск playbook

```
#ansible-playbook playbookName
ansible-playbook code-deploy.yml

# Запуск с конкретными тегами
ansible-playbook playbook.yml --tags="env-files,php"

# Если вы используете ansible-vault
ansible-playbook code-deploy.yml --vault-password-file  .vault_pass.txt
```

### Полная структура проекта

```
├── ansible.cfg
├── code-deploy.yml
├── files
│   └── dump.sql
├── group_vars
│   └── vars.yml
├── handlers
│   └── main.yml
├── hosts.ini
├── logs
│   └── ansible-log.log
├── roles
│   ├── bootstrap-app
│   │ └── tasks
│   │     └── main.yml
│   ├── code-deploy
│   │ ├── tasks
│   │ │   ├── config-files.yml
│   │ │   └── main.yml
│   │ └── templates
│   │     └── env.conf
│   ├── misc
│   │ └── tasks
│   │     └── main.yml
│   ├── mysql
│   │ └── tasks
│   │     ├── config.yml
│   │     └── main.yml
│   ├── nginx
│   │ ├── tasks
│   │ │   └── main.yml
│   │ └── templates
│   │     └── nginx.conf
│   ├── php
│   │ └── tasks
│   │     └── main.yml
│   └── redis
│       └── tasks
│           └── main.yml
├── scripts
│   ├── install_composer.sh
│   └── startup.sh
└── site.yml
```

## Дополнительные материалы для начинающих изучать Ansible

- [Репозиторий на GitHub](https://github.com/ahmedfaragmostafa/Ansible-in-action), который содержит полный исходный код.
- Этот [сайт](http://maqoola.co/) запущен и работает с использованием этой кодовой базы.
- [Советы по использованию Ansible playbooks](https://docs.ansible.com/ansible/latest/user_guide/playbooks.html).
- [Описание архитектуры программы Ansible](https://docs.ansible.com/ansible/latest/dev_guide/overview_architecture.html).
- Статья «[How to Use Ansible to Automate Initial Server Setup on Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-use-ansible-to-automate-initial-server-setup-on-ubuntu-18-04)».
- О других инструментах сисадмина и DevOps читайте в [нашей подборке](https://tproger.ru/digest/sysadmin-compilation/).

Вадим Сычёв

Перевод статьи [«Ansible In Action»](https://medium.com/@ahmadfarag/ansible-in-action-f2f17706931)

---
created: 2021-11-07T02:24:17 (UTC +03:00)
source: https://zen.yandex.ru/media/id/5cab3ea044061700afead675/kak-podkliuchit-postgresql-k-django-5eef306aaa52ca2c22f09a95
author: Ivan Yastrebov
---

---
![Как подключить PostgreSQL к Django](https://avatars.mds.yandex.net/get-zen_doc/3385233/pub_5eef306aaa52ca2c22f09a95_5eef3184e479666355016084/scale_1200)

### **Прелюдия**

Из коробки Django даёт возможность использовать SQLite, но мы то знаем, что лучше базы данных(далее БД) чем PostgreSQL не существует.

### **Подключение PostgreSQL к Django**

Открываем файл settings.py и находим дефолтные настройки БД:

```python
DATABASES = {  
'default': {  
'ENGINE': 'django.db.backends.sqlite3',  
'NAME': os.path.join(BASE\_DIR, 'db.sqlite3'),  
 }  
}
```
Закомментируем их, можете удалить если не нужны или поменять на следующие:

 ```python
 DATABASES = {  
 'default': {  
 'ENGINE': 'django.db.backends.postgresql\_psycopg2',  
 'NAME': 'dbname',  
 'USER': 'username',  
 'PASSWORD': 'userpass',  
 'HOST': '127.0.0.1',  
 'PORT': '5432'  
 }  
 }
 ```

Где:

-   **NAME** - имя базы данных.
-   **USER** - пользователь БД.
-   **PASSWORD** - пароль пользователя.
-   **HOST** - 127.0.0.1 или localhost.
-   **PORT** - 5432.

Далее нам понадобится установить модуль psycopg2 для работы с PostgreSQL, устанавливаем:

В Linux:

```shell
pip install psycopg2-binary
```

В Windows:

```shell
pip install psycopg2
```

Вот собственно и всё, осталось выполнить миграции.

```shell
python manage.py makemigration
```

```shell
python manage.py migrate
```

`######tags: [python,translate,trans]`

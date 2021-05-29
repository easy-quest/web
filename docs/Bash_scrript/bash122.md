# Positional Parameters 

**Позиционные параметры** - это переменные, которые содержат содержимое командной строки. Эти переменные от `$0` до `$9`. Сам скрипт хранится в `$0`, первый параметр в `$1`, второй в `$2`, и так далее.  Возьмите эту командную строку в качестве примера.

```sh
script.sh parameter1 parameter2 parameter3
```

Содержание выглядит следующим образом: `$0` является `script.sh`, `$1` является `parameter1`, `$2` является `parameter2`, а также `$3` является `parameter3`. 

Этот сценарий, `archive_user.sh`, принимает параметр, который является именем пользователя. 

```bash
#!/bin/bash 
echo "Executing script: $0" 
echo "Archiving user: $1" 
# Lock the account 
passwd –l $1 
# Create an archive of the home directory. 
tar cf /archives/${1}.tar.gz /home/${1}
```
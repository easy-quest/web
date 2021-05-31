# grep

> Find patterns in files using regular expressions.
> More information: <https://www.gnu.org/software/grep/manual/grep.html>.

- Вот как я обычно использую grep. -R рекурсивно переходить в подкаталоги, -n отображать номера строк совпадений, -i игнорировать регистр, -s подавлять сообщения «не существует» и «не может прочитать», -Я игнорирую двоичные файлы (технически обрабатываю их как не имеющие совпадений, важно для отображения инвертированных результатов с помощью -v) У меня также есть **alias grep** на `grep --color = auto`, но это вопрос форматирования, а не функции.
  

```bash
grep -RnisI <шаблон> *
```

```bash
grep -iRlwn "фраза" /директория/где/искать
```

- Поиск шаблона в файле:
  
```bash
grep "{{search_pattern}}" {{path/to/file}}
```

- Поиск точной строки (отключение регулярных выражений):

```bash
grep --fixed-strings "{{exact_string}}" {{path/to/file}}
```

- Искать шаблон во всех файлах рекурсивно в каталоге, показывая номера строк совпадений, игнорируя двоичные файлы:

```bash
grep --recursive --line-number --binary-files={{without-match}} "{{search_pattern}}" {{path/to/directory}}
```

- Используйте расширенные регулярные выражения (supports `?`, `+`, `{}`, `()` and `|`), in case-insensitive mode:

```bash
grep --extended-regexp --ignore-case "{{search_pattern}}" {{path/to/file
```

- Печать 3 строки контекста вокруг, до или после каждого матча:

```sh
grep --{{context|before-context|after-context}}={{3}} "{{search_pattern}}" {{path/to/file}}
```

- Имя печати файла и номер строки для каждого матча:

```sh
grep --with-filename --line-number "{{search_pattern}}" {{path/to/file}}
```

- Поиск линий, сопоставляющих шаблон, печать только соответствующего текста:

```sh
grep --only-matching "{{search_pattern}}" {{path/to/file}}
```

- Поиск Stdin для линий, которые не соответствуют шаблону:

```sh
cat {{path/to/file}} | grep --invert-match "{{search_pattern}}"
```

- Печать графического дерева каталогов из текущего каталога 

```sh
ls -R | grep ": $" | sed -e 's /: $ //' -e 's / [^ -] [^ \ /] * \ // - / g' -e 's / ^ / /' -e 's / - / | / '
```

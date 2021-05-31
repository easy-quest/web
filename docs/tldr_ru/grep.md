# grep

> Find patterns in files using regular expressions.
> More information: <https://www.gnu.org/software/grep/manual/grep.html>.

<<<<<<< HEAD

```bash
=======
- Вот как я обычно использую grep. -R рекурсивно переходить в подкаталоги, -n отображать номера строк совпадений, -i игнорировать регистр, -s подавлять сообщения «не существует» и «не может прочитать», -Я игнорирую двоичные файлы (технически обрабатываю их как не имеющие совпадений, важно для отображения инвертированных результатов с помощью -v) У меня также есть **alias grep** на `grep --color = auto`, но это вопрос форматирования, а не функции.
```
grep -RnisI <шаблон> *
```
```
>>>>>>> 0ac51ded4b0795d7a538ac3c3baad2864ad02342
grep -iRlwn "фраза" /директория/где/искать
```


- Поиск шаблона в файле:

```
grep "{{search_pattern}}" {{path/to/file}}
``` 

- Поиск точной строки (отключение регулярных выражений):

```
grep --fixed-strings "{{exact_string}}" {{path/to/file}}
```

- Искать шаблон во всех файлах рекурсивно в каталоге, показывая номера строк совпадений, игнорируя двоичные файлы:

`grep --recursive --line-number --binary-files={{without-match}} "{{search_pattern}}" {{path/to/directory}}`

- Use extended regular expressions (supports `?`, `+`, `{}`, `()` and `|`), in case-insensitive mode:

`grep --extended-regexp --ignore-case "{{search_pattern}}" {{path/to/file}}`

- Print 3 lines of context around, before, or after each match:

`grep --{{context|before-context|after-context}}={{3}} "{{search_pattern}}" {{path/to/file}}`

- Print file name and line number for each match:

`grep --with-filename --line-number "{{search_pattern}}" {{path/to/file}}`

- Search for lines matching a pattern, printing only the matched text:

`grep --only-matching "{{search_pattern}}" {{path/to/file}}`

- Search stdin for lines that do not match a pattern:

`cat {{path/to/file}} | grep --invert-match "{{search_pattern}}"`

- Печать графического дерева каталогов из текущего каталога 

```
ls -R | grep ": $" | sed -e 's /: $ //' -e 's / [^ -] [^ \ /] * \ // - / g' -e 's / ^ / /' -e 's / - / | / '
```

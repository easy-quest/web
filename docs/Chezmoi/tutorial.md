---
created: 2021-11-08T18:30:41 (UTC +03:00)
source: https://www.chezmoi.io/docs/how-to/
author: Ivan Yastrebov
---
___

## Выполняйте ежедневные операции[#](https://www.chezmoi.io/docs/how-to/#perform-daily-operations)

___

### Используйте размещенное репозиторий для управления файлами точек на нескольких компьютерах[#](https://www.chezmoi.io/docs/how-to/#use-a-hosted-repo-to-manage-your-dotfiles-across-multiple-machines)

chezmoi полагается на вашу систему управления версиями и размещенное репозиторий для совместного использования изменений на нескольких компьютерах. Вы должны создать репо в репозитории исходного кода по вашему выбору (например[, Bitbucket](https://bitbucket.org/), [GitHub](https://github.com/)или [GitLab](https://gitlab.com/), многие люди называют их репо `dotfiles`) и поместить репо в исходный каталог здесь. Например:

```
chezmoi cd
git remote add origin https://github.com/${USER}/dotfiles.git
git push -u origin main
exit
```

На другой машине вы можете проверить это репо:

```
$ chezmoi init https://github.com/username/dotfiles.git
```

Затем вы можете увидеть, что будет изменено:

```
$ chezmoi diff
```

Если вы довольны изменениями, то примените их:

```
$ chezmoi apply
```

Вышеуказанные команды можно объединить в одну команду ввода, проверки и применения:

```
$ chezmoi init --apply --verbose https://github.com/username/dotfiles.git
```

___

### Используйте частное репо для хранения ваших dot-файлов [#](https://www.chezmoi.io/docs/how-to/#use-a-private-repo-to-store-your-dotfiles)

chezmoi поддерживает хранение ваших dot-файлов как в общедоступных, так и в частных репозиториях.

chezmoi разработан таким образом, чтобы ваше репозиторий dotfiles мог быть общедоступным, позволяя вам легко хранить свои секреты либо в диспетчере паролей, либо в зашифрованных файлах, либо в личных файлах конфигурации. Ваше репо dotfiles по-прежнему может быть закрытым, если вы решите.

Если вы используете частное репо для своих файлов точек, то вам, как правило, потребуется вводить свои учетные данные (например, имя пользователя и пароль) каждый раз, когда вы взаимодействуете с репо, например, при внесении изменений. сам chezmoi не хранит никаких учетных данных, но вместо этого полагается на локальную конфигурацию git для этих операций.

При использовании частного РЕПО на GitHub при запросе пароля вам потребуется ввести [личный токен доступа к GitHub](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token). Для получения дополнительной информации об этих изменениях прочитайте [сообщение в блоге GitHub о требованиях к аутентификации по токенам для операций Git](https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/)

___

### Извлеките последние изменения из своего репо и примените их[#](https://www.chezmoi.io/docs/how-to/#pull-the-latest-changes-from-your-repo-and-apply-them)

Вы можете извлечь изменения из своего репозитория и применить их в одной команде:

```
$ chezmoi update
```

Это выполняется `git pull --rebase`в вашем исходном каталоге, а затем `chezmoi apply`.

___

### Извлеките последние изменения из своего репо и посмотрите, что изменится, фактически не применяя изменения[#](https://www.chezmoi.io/docs/how-to/#pull-the-latest-changes-from-your-repo-and-see-what-would-change-without-actually-applying-the-changes)

Бежать:

```
$ chezmoi git pull -- --rebase && chezmoi diff
```

Это выполняется `git pull --rebase`в исходном каталоге, а `chezmoi diff`затем показывает разницу между целевым состоянием, вычисленным из исходного каталога, и фактическим состоянием.

Если вы довольны изменениями, то можете запустить

```
$ chezmoi apply
```

чтобы применить их.

___

### Автоматическая фиксация и внесение изменений в ваше репо[#](https://www.chezmoi.io/docs/how-to/#automatically-commit-and-push-changes-to-your-repo)

chezmoi может автоматически фиксировать и отправлять изменения в исходный каталог в ваше хранилище. По умолчанию эта функция отключена. Чтобы включить его, добавьте в свой конфигурационный файл следующее:

```
[git]
    autoCommit = true
    autoPush = true
```

Всякий раз, когда в ваш исходный каталог вносятся изменения, chezmoi фиксирует изменения с помощью автоматически сгенерированного сообщения о фиксации (если `autoCommit`это правда) и отправляет их в ваше хранилище (если `autoPush`это правда). `autoPush`подразумевает `autoCommit`, т. е. если `autoPush`это правда, то chezmoi автоматически зафиксирует ваши изменения. Если вы установите только значение `autoCommit`true, то изменения будут зафиксированы, но не будут перенесены.

Будьте осторожны при использовании `autoPush`. Если ваше репо dotfiles является общедоступным и вы случайно добавили секрет в виде обычного текста, этот секрет будет передан в ваше публичное репо.

___

### Установите chezmoi и ваши файлы dot на новую машину с помощью одной команды[#](https://www.chezmoi.io/docs/how-to/#install-chezmoi-and-your-dotfiles-on-a-new-machine-with-a-single-command)

сценарий установки chezmoi может выполняться `chezmoi init`для вас, передавая дополнительные аргументы в недавно установленный двоичный файл chezmoi. Если ваше репо dotfiles `github.com/<github-username>/dotfiles`затем устанавливает chezmoi, запуск `chezmoi init`и запуск `chezmoi apply`можно выполнить в одной строке оболочки:

```
$ sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply <github-username>
```

Если у вашего репозитория dotfiles другое имя `dotfiles`или если вы размещаете свои dotfiles в другой службе , обратитесь к [справочному руководству `chezmoi init`](https://www.chezmoi.io/docs/reference/#init-repo).

Для настройки временных сред (например, недолговечных контейнеров Linux) вы можете установить chezmoi, установить свои файлы точек, а затем удалить все следы chezmoi, включая исходный каталог и каталог конфигурации chezmoi, с помощью одной команды:

```
$ sh -c "$(curl -fsLS git.io/chezmoi)" -- init --one-shot <github-username>
```

___

## Управление различными типами файлов [#](https://www.chezmoi.io/docs/how-to/#manage-different-types-of-file)

___

### Попросите chezmoi создать каталог, но игнорируйте его содержимое[#](https://www.chezmoi.io/docs/how-to/#have-chezmoi-create-a-directory-but-ignore-its-contents)

Если вы хотите, чтобы chezmoi создал каталог, но проигнорировал его содержимое , скажем`~/src`, сначала запустите:

```
$ mkdir -p $(chezmoi source-path)/src
```

Это создает каталог в исходном состоянии, что означает, что chezmoi создаст его (если он еще не существует) при запуске `chezmoi apply`.

Однако, поскольку это пустой каталог, он будет проигнорирован git. Итак, создайте файл в каталоге в исходном состоянии, который будет виден git (чтобы git не игнорировал каталог), но игнорировался chezmoi (чтобы chezmoi не включал его в целевое состояние):

```
$ touch $(chezmoi source-path)/src/.keep
```

chezmoi автоматически создает `.keep`файлы, когда вы добавляете пустой каталог с `chezmoi add`.

___

### Убедитесь, что цель удалена[#](https://www.chezmoi.io/docs/how-to/#ensure-that-a-target-is-removed)

Создайте файл с именем `.chezmoiremove`в исходном каталоге, содержащий список шаблонов файлов для удаления. chezmoi удалит все, что в целевом каталоге соответствует шаблону. Поскольку эта команда потенциально опасна, вам следует заранее запустить chezmoi в подробном режиме сухого запуска, чтобы посмотреть, что будет удалено:

```
$ chezmoi apply --dry-run --verbose
```

`.chezmoiremove` интерпретируется как шаблон, поэтому вы можете удалять разные файлы на разных компьютерах. Отрицательные совпадения (шаблоны с префиксом a `!`) или цели, перечисленные в`.chezmoiignore`, никогда не будут удалены.

___

### Управление частью, но не всем файлом[#](https://www.chezmoi.io/docs/how-to/#manage-part-but-not-all-of-a-file)

по умолчанию chezmoi управляет целыми файлами, но есть два способа управлять только частями файла.

Во-первых, `modify_`скрипт получает текущее содержимое файла на стандартный ввод, а chezmoi считывает целевое содержимое файла из стандартного вывода скрипта. Это можно использовать для изменения частей файла, например, с помощью `sed`. Обратите внимание, что если файл не существует, то стандартный ввод в `modify_`сценарий будет пустым, и сценарий несет ответственность за запись полного файла в стандартный вывод.

Во-вторых, если изменяется только небольшая часть файла, рассмотрите возможность использования шаблона для повторного создания полного содержимого файла из текущего состояния. Например, конфигурации Kubernetes включают текущий контекст, который можно заменить:

```
current-context: {{ output "kubectl" "config" "current-context" | trim }}
```

___

### Управление разрешениями файла, но не его содержимым [#](https://www.chezmoi.io/docs/how-to/#manage-a-files-permissions-but-not-its-contents)

`create_`атрибуты chezmoi позволяют вам указать chezmoi на создание файла, если он еще не существует. однако chezmoi будет применять любые изменения разрешений из атрибутов`executable_`,`private_`, и.`readonly_` Это можно использовать для управления разрешениями файла без изменения его содержимого.

Например, если вы хотите убедиться, что `~/.kube/config`у вас всегда есть разрешения 600, то, если вы создадите пустой файл с именем `dot_kube/private_dot_config`в исходном состоянии, chezmoi обеспечит`~/.kube/config`, чтобы при запуске разрешения были равны 0600`chezmoi apply`, не изменяя его содержимое.

У этого подхода есть недостаток в том, что chezmoi создаст файл, если он еще не существует. Если вы хотите `chezmoi apply`установить права доступа к файлу только в том случае, если он уже существует, и не создавать файл в противном случае, вы можете использовать `run_`сценарий. Например, создайте файл в исходном состоянии под названием `run_set_kube_config_permissions.sh`содержащий:

```
#!/bin/sh

FILE="$HOME/.kube/config"
if [ -f "$FILE" ]; then
    if [ "$(stat -c %a "$FILE")" != "600" ] ; then
        chmod 600 "$FILE"
    fi
fi
```

___

chezmoi может получить ваши открытые SSH-ключи с GitHub, что может быть полезно для заполнения вашего `~/.ssh/authorized_keys`. Введите следующее в свой `~/.local/share/chezmoi/dot_ssh/authorized_keys.tmpl`, где `username`ваше имя пользователя на GitHub:

```
{{ range (gitHubKeys "username") -}}
{{   .Key }}
{{ end -}}
```

___

## Интегрируйте chezmoi с вашим редактором [#](https://www.chezmoi.io/docs/how-to/#integrate-chezmoi-with-your-editor)

___

### Используйте предпочитаемый вами редактор с `chezmoi edit`и`chezmoi edit-config` [#](https://www.chezmoi.io/docs/how-to/#use-your-preferred-editor-with-chezmoi-edit-and-chezmoi-edit-config)

По умолчанию chezmoi будет использовать предпочтительный редактор, определенный `$VISUAL``$EDITOR`переменными среды или, возвращаясь к редактору по умолчанию в зависимости от вашей операционной системы (`vi` в UNIX-подобных операционных системах, `notepad.exe`в Windows).

Вы можете настроить chezmoi на использование предпочтительного редактора, либо установив переменную `$EDITOR`среды, либо установив `edit.command`переменную в файле конфигурации.

Команда редактора должна вернуться только после того, как вы закончите редактирование файлов. chezmoi выдаст предупреждение, если ваша команда редактора вернется слишком быстро.

В конкретном случае использования [VSCode](https://code.visualstudio.com/) или [Codium](https://vscodium.com/) в качестве редактора вы должны передать `--wait`флаг, например, в конфигурации оболочки:

```
$ export EDITOR="code --wait"
```

Или в файле конфигурации chezmoi:

```
[edit]
    command = "code"
    args = ["--wait"]
```

___

### Настройте VIM для запуска `chezmoi apply`при каждом сохранении точечного файла [#](https://www.chezmoi.io/docs/how-to/#configure-vim-to-run-chezmoi-apply-whenever-you-save-a-dotfile)

Поместите следующее в свой`.vimrc`:

```
autocmd BufWritePost ~/.local/share/chezmoi/* ! chezmoi apply --source-path "%"
```

___

## Включите точечные файлы из других источников [#](https://www.chezmoi.io/docs/how-to/#include-dotfiles-from-elsewhere)

___

### Включите подкаталог из другого репозитория, например Oh My Zsh[#](https://www.chezmoi.io/docs/how-to/#include-a-subdirectory-from-another-repository-like-oh-my-zsh)

Чтобы включить подкаталог из другого репозитория, например [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh), вы не можете использовать подмодули git, потому что chezmoi использует свой собственный формат для исходного состояния, а Oh My Zsh не распространяется в этом формате. Вместо этого вы можете использовать`.chezmoiexternal.<format>`, чтобы указать chezmoi импортировать файлы точек из внешнего источника.

Например, чтобы импортировать Oh My [Zsh, плагин подсветки синтаксиса](https://github.com/zsh-users/zsh-syntax-highlighting)zsh и [powerlevel10k](https://github.com/romkatv/powerlevel10k), поместите следующее в`~/.local/share/chezmoi/.chezmoiexternal.toml`:

```
[".oh-my-zsh"]
    type = "archive"
    url = "https://github.com/ohmyzsh/ohmyzsh/archive/master.tar.gz"
    exact = true
    stripComponents = 1
    refreshPeriod = "168h"
[".oh-my-zsh/custom/plugins/zsh-syntax-highlighting"]
    type = "archive"
    url = "https://github.com/zsh-users/zsh-syntax-highlighting/archive/master.tar.gz"
    exact = true
    stripComponents = 1
    refreshPeriod = "168h"
[".oh-my-zsh/custom/themes/powerlevel10k"]
    type = "archive"
    url = "https://github.com/romkatv/powerlevel10k/archive/v1.15.0.tar.gz"
    exact = true
    stripComponents = 1
```

Чтобы применить изменения, выполните:

```
$ chezmoi apply
```

chezmoi загрузит архивы и распакует их, как если бы они были частью исходного состояния. chezmoi кэширует загруженные архивы локально, чтобы избежать их повторной загрузки каждый раз, когда вы выполняете команду chezmoi, и будет загружать их не чаще, чем каждый `refreshPeriod`раз (по умолчанию никогда).

В приведенном выше примере `refreshPeriod`установлено значение `168h`(одна неделя) для `.oh-my-zsh`и `.oh-my-zsh/custom/plugins/zsh-syntax-highlighting`потому, что URL-адрес указывает на тарболы `master`ветви, которые меняются со временем. Период обновления не задан`.oh-my-zsh/custom/themes/powerlevel10k`, поскольку URL-адрес указывает на файл с тегами версии, который со временем не меняется. Чтобы повысить версию powerlevel10k, измените версию в URL-адресе.

Чтобы принудительно обновить загруженные архивы, используйте `--refresh-externals`флаг, чтобы`chezmoi apply`:

```
$ chezmoi --refresh-externals apply
```

`--refresh-externals` может быть сокращено до`-R`:

```
$ chezmoi -R apply
```

При использовании Oh My Zsh убедитесь, что вы отключили автоматическое обновление, установив `DISABLE_AUTO_UPDATE="true"`в.`~/.zshrc` Автоматическое обновление приведет `~/.oh-my-zsh`к тому, что каталог не будет синхронизирован с исходным состоянием chezmoi. Чтобы обновить Oh My Zsh и его плагины, обновите загруженные архивы.

___

### Включите один файл из другого репозитория[#](https://www.chezmoi.io/docs/how-to/#include-a-single-file-from-another-repository)

Включение отдельных файлов использует тот же механизм, что и включение подкаталога выше, за исключением внешнего типа `file`вместо `archive`. Например, чтобы включить [`plug.vim`](https://github.com/junegunn/vim-plug/blob/master/plug.vim)из [`github.com/junegunn/vim-plug`](https://github.com/junegunn/vim-plug)в`~/.vim/autoload/plug.vim`, поместите следующее в`~/.local/share/chezmoi/.chezmoiexternals.toml`:

```
[".vim/autoload/plug.vim"]
    type = "file"
    url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    refreshPeriod = "168h"
```

___

### Обрабатывайте файлы конфигурации, которые были изменены извне [#](https://www.chezmoi.io/docs/how-to/#handle-configuration-files-which-are-externally-modified)

Некоторые программы изменяют свои файлы конфигурации. При следующем запуске `chezmoi apply`любые изменения , внесенные программой, будут утеряны.

Вы можете отслеживать изменения в этих файлах, заменив их символической ссылкой на файл в исходном каталоге, который находится под контролем версий. Вот рабочий пример для VSCode `settings.json`в Linux:

Скопируйте файл конфигурации в свой исходный каталог:

```
$ cp ~/.config/Code/User/settings.json $(chezmoi source-path)
```

Скажите чезмои, чтобы он проигнорировал этот файл:

```
$ echo settings.json >> $(chezmoi source-path)/.chezmoiignore
```

Скажите chezmoi, что `~/.config/Code/User/settings.json`это должна быть символическая ссылка на файл в вашем исходном каталоге:

```
$ mkdir -p $(chezmoi source-path)/private_dot_config/private_Code/User
$ echo -n "{{ .chezmoi.sourceDir }}/settings.json" > $(chezmoi source-path)/private_dot_config/private_Code/User/symlink_settings.json.tmpl
```

Префикс `private_`используется, потому `~/.config``~/.config/Code` что каталоги и по умолчанию являются закрытыми.

Примените изменения:

```
$ chezmoi apply -v
```

Теперь, когда программа изменяет свой файл конфигурации, вместо этого она изменит файл в исходном состоянии.

___

### Импорт архивов[#](https://www.chezmoi.io/docs/how-to/#import-archives)

Иногда бывает полезно импортировать целые архивы конфигурации в исходное состояние. `import`Команда делает это. Например, для импорта последней версии [`github.com/ohmyzsh/ohmyzsh`](https://github.com/ohmyzsh/ohmyzsh)для `~/.oh-my-zsh`запуска:

```
$ curl -s -L -o ${TMPDIR}/oh-my-zsh-master.tar.gz https://github.com/ohmyzsh/ohmyzsh/archive/master.tar.gz
$ mkdir -p $(chezmoi source-path)/dot_oh-my-zsh
$ chezmoi import --strip-components 1 --destination ~/.oh-my-zsh ${TMPDIR}/oh-my-zsh-master.tar.gz
```

Обратите внимание, что это обновляет только исходное состояние. Вам нужно будет бежать

```
$ chezmoi apply
```

чтобы обновить каталог назначения.

___

## Управление различиями между машинами[#](https://www.chezmoi.io/docs/how-to/#manage-machine-to-machine-differences)

___

### Используйте шаблоны[#](https://www.chezmoi.io/docs/how-to/#use-templates)

Основная цель chezmoi-управлять файлами конфигурации на нескольких компьютерах, например, на вашем персональном ноутбуке macOS, рабочем рабочем столе Ubuntu и рабочем ноутбуке Linux. Вы захотите сохранить большую часть конфигурации одинаковой для них, но также вам потребуются конфигурации для конкретных компьютеров для адресов электронной почты, учетных данных и т. Д. chezmoi обеспечивает эту функциональность, используя [`text/template`](https://pkg.go.dev/text/template)для исходного состояния, где это необходимо.

Например, ваш дом `~/.gitconfig`на вашем персональном компьютере может выглядеть так:

```
[user]
    email = "me@home.org"
```

В то время как на работе это может быть:

```
[user]
    email = "firstname.lastname@company.com"
```

Чтобы справиться с этим, на каждой машине создайте файл конфигурации под названием `~/.config/chezmoi/chezmoi.toml` определение переменных, которые могут варьироваться от машины к машине. Например, для вашей домашней машины:

```
[data]
    email = "me@home.org"
```

Обратите внимание, что все имена переменных будут преобразованы в нижний регистр. Это связано с особенностью библиотеки, используемой chezmoi.

Если вы собираетесь хранить личные данные (например , токены доступа)`~/.config/chezmoi/chezmoi.toml`, убедитесь, что у них есть разрешения `0600`.

Если вы предпочитаете, вы можете использовать любой формат, поддерживаемый [Viper](https://github.com/spf13/viper), для вашего файла конфигурации. Это включает в себя JSON, YAML и TOML. Имена переменных должны начинаться с буквы и сопровождаться нулем или более букв или цифр.

Затем добавьте `~/.gitconfig`в chezmoi, используя `--autotemplate`флаг, чтобы превратить его в шаблон и автоматически определять переменные из `data`раздела вашего `~/.config/chezmoi/chezmoi.toml`файла:

```
$ chezmoi add --autotemplate ~/.gitconfig
```

Затем вы можете открыть шаблон (который будет сохранен в файле `~/.local/share/chezmoi/dot_gitconfig.tmpl`):

```
$ chezmoi edit ~/.gitconfig
```

Файл должен выглядеть примерно так:

```
[user]
    email = {{ .email | quote }}
```

Чтобы отключить автоматическое определение переменных, используйте опцию `--template`или `-T` `chezmoi add`вместо `--autotemplate`.

Шаблоны часто используются для фиксации различий, характерных для конкретной машины. Например, в вашем `~/.local/share/chezmoi/dot_bashrc.tmpl`случае вы могли бы:

```
# common config
export EDITOR=vi

# machine-specific configuration
{{- if eq .chezmoi.hostname "work-laptop" }}
# this will only be included in ~/.bashrc on work-laptop
{{- end }}
```

Для получения полного списка переменных выполните:

```
$ chezmoi data
```

Для более продвинутого использования вы можете использовать всю мощь [`text/template`](https://pkg.go.dev/text/template)языка. chezmoi включает в себя все текстовые функции [sprig](http://masterminds.github.io/sprig/) и собственные [функции для взаимодействия с менеджерами паролей](https://www.chezmoi.io/docs/reference/#template-functions).

Шаблоны могут быть выполнены непосредственно из командной строки, без необходимости создания файла на диске`execute-template`, например, с помощью команды:

```
$ chezmoi execute-template "{{ .chezmoi.os }}/{{ .chezmoi.arch }}"
```

Это полезно при разработке или отладке шаблонов.

Некоторые менеджеры паролей позволяют хранить полные файлы. Файлы могут быть извлечены с помощью функций шаблона chezmoi. Например, если у вас есть файл, хранящийся в 1Password с идентификатором UUID`uuid`, вы можете получить его с помощью шаблона:

```
{{- onepasswordDocument "uuid" -}}
```

Буквы `-`s в скобках удаляют любые пробелы до или после выражения шаблона, что полезно, если ваш редактор добавил какие-либо новые строки.

Если после выполнения шаблона содержимое файла окажется пустым, целевой файл будет удален. Это может быть использовано для обеспечения того, чтобы файлы присутствовали только на определенных машинах. Если вы все равно хотите создать пустой файл, вам нужно будет указать ему `empty_`префикс.

___

### Игнорируйте файлы или каталог на разных машинах[#](https://www.chezmoi.io/docs/how-to/#ignore-files-or-a-directory-on-different-machines)

Для более детального управления файлами и целыми каталогами, управляемыми на разных компьютерах, или для полного исключения определенных файлов, вы можете создавать `.chezmoiignore`файлы в исходном каталоге. Они определяют список шаблонов, которые chezmoi следует игнорировать, и интерпретируются как шаблоны. Пример `.chezmoiignore`файла может выглядеть следующим образом:

```
README.md
{{- if ne .chezmoi.hostname "work-laptop" }}
.work # only manage .work on work-laptop
{{- end }}
```

Использование `ne`(не равнозначное) является преднамеренным. Чего мы хотим добиться, так это “ устанавливать только `.work`при наличии имени хоста`work-laptop`”, но chezmoi устанавливает все по умолчанию, поэтому мы должны изменить логику и вместо этого написать “игнорировать`.work` если только имя хоста `work-laptop`не ”.

Шаблоны можно исключить , добавив к ним префикс a`!`, например:

```
f*
!foo
```

будет игнорировать все файлы, начинающиеся с `f`"кроме`foo`".

___

### Используйте совершенно разные файлы точек на разных машинах[#](https://www.chezmoi.io/docs/how-to/#use-completely-different-dotfiles-on-different-machines)

функциональность шаблона chezmoi позволяет изменять содержимое файла на основе любой переменной. Например, если вы хотите `~/.bashrc`отличаться в Linux и macOS, вы должны создать файл в исходном состоянии, называемый `dot_bashrc.tmpl`содержащим:

```
{{ if eq .chezmoi.os "darwin" -}}
# macOS .bashrc contents
{{ else if eq .chezmoi.os "linux" -}}
# Linux .bashrc contents
{{ end -}}
```

Однако, если различия между двумя версиями настолько велики, что вы предпочли бы использовать полностью отдельные файлы в исходном состоянии, вы можете добиться этого с помощью шаблона символической ссылки. Создайте следующие файлы:

`symlink_dot_bashrc.tmpl`:

```
.bashrc_{{ .chezmoi.os }}
```

`dot_bashrc_darwin`:

```
  # macOS .bashrc contents
```

`dot_bashrc_linux`:

```
# Linux .bashrc contents
```

`.chezmoiignore`

```
{{ if ne .chezmoi.os "darwin" }}
.bashrc_darwin
{{ end }}
{{ if ne .chezmoi.os "linux" }}
.bashrc_linux
{{ end }}
```

Это создаст `~/.bashrc`символическую ссылку на `.bashrc_darwin`вкл `darwin`и `.bashrc_linux`вкл `linux`. `.chezmoiignore`Конфигурация гарантирует, что `.bashrc_os`в каждой операционной системе будет установлен только файл, специфичный для конкретной операционной системы.

#### Без использования символических ссылок[#](https://www.chezmoi.io/docs/how-to/#without-using-symlinks)

То же самое можно сделать с помощью функции включения.

`dot_bashrc.tmpl`

```
{{ if eq .chezmoi.os "darwin" }}
{{   include ".bashrc_darwin" }}
{{ end }}
{{ if eq .chezmoi.os "linux" }}
{{   include ".bashrc_linux" }}
{{ end }}
```

___

### Автоматически создайте файл конфигурации на новой машине [#](https://www.chezmoi.io/docs/how-to/#create-a-config-file-on-a-new-machine-automatically)

`chezmoi init` также можно автоматически создать файл конфигурации, если он еще не существует. Если ваше репозиторий содержит файл с именем`.chezmoi.<format>.tmpl`, где *формат* является одним из поддерживаемых форматов файлов конфигурации (например`json`,`toml`, или`yaml`), то `chezmoi init`будет выполнен этот шаблон для создания исходного файла конфигурации.

В частности, если у вас есть `.chezmoi.toml.tmpl`что-то похожее на это:

```
{{- $email := promptString "email" -}}
[data]
    email = {{ $email | quote }}
```

Затем `chezmoi init`создадим инициал`chezmoi.toml`, используя этот шаблон. `promptString` это специальная функция, которая запрашивает у пользователя (вас) значение.

Чтобы протестировать этот шаблон, используйте `chezmoi execute-template`с флагами `--init`и`--promptString`, например:

```
$ chezmoi execute-template --init --promptString email=me@home.org < ~/.local/share/chezmoi/.chezmoi.toml.tmpl
```

___

### Заново создайте свой конфигурационный файл [#](https://www.chezmoi.io/docs/how-to/#re-create-your-config-file)

Если вы измените шаблон файла конфигурации, chezmoi предупредит вас, если ваш текущий файл конфигурации не был создан на основе этого шаблона. Вы можете повторно сгенерировать свой конфигурационный файл, запустив:

```
$ chezmoi init
```

Если вы используете какие`prompt*`\-либо функции шаблона в шаблоне файла конфигурации , вам будет предложено повторить запрос. Однако этого можно избежать с помощью следующего примера логики шаблона:

```
{{- $email := "" -}}
{{- if (hasKey . "email") -}}
{{-   $email = .email -}}
{{- else -}}
{{-   $email = promptString "email" -}}
{{- end -}}

[data]
    email = {{ $email | quote }}
```

Это приведет к тому, что chezmoi сначала попытается повторно использовать существующую `$email`переменную и `promptString`вернется к ней, только если она не установлена.

___

### Обрабатывайте разные расположения файлов в разных системах с одинаковым содержимым[#](https://www.chezmoi.io/docs/how-to/#handle-different-file-locations-on-different-systems-with-the-same-contents)

Если вы хотите иметь одинаковое содержимое файла в разных местах в разных системах, но поддерживать только один файл в исходном состоянии, вы можете использовать общий шаблон.

Создайте общий файл в `.chezmoitemplates`каталоге в исходном состоянии. Например, создать `.chezmoitemplates/file.conf`. Содержимое этого файла доступно в шаблонах с `template *name* .`функцией, где *name*\-это имя файла (`.` передает текущие данные в код шаблона `file.conf`; см. [https://pkg.go.dev/text/template#hdr-Actions](https://pkg.go.dev/text/template#hdr-Actions) для получения более подробной информации).

Затем создайте файлы для каждой системы, например `Library/Application Support/App/file.conf.tmpl`для macOS и `dot_config/app/file.conf.tmpl`Linux. Оба файла шаблона должны содержать `{{- template "file.conf" . -}}`.

Наконец, попросите chezmoi игнорировать файлы там, где они не нужны, добавив строки в свой `.chezmoiignore`файл, например:

```
{{ if ne .chezmoi.os "darwin" }}
Library/Application Support/App/file.conf
{{ end }}
{{ if ne .chezmoi.os "linux" }}
.config/app/file.conf
{{ end }}
```

___

### Создайте архив своих dot-файлов [#](https://www.chezmoi.io/docs/how-to/#create-an-archive-of-your-dotfiles)

`chezmoi archive` создает архив, содержащий целевое состояние. Это может быть полезно для создания целевого состояния для другой машины. Вы можете указать другой файл конфигурации (включая переменные шаблона) с помощью этой `--config`опции.

___

## Сохраняйте конфиденциальность данных[#](https://www.chezmoi.io/docs/how-to/#keep-data-private)

chezmoi автоматически определяет, являются ли файлы и каталоги закрытыми при их добавлении, проверяя их разрешения. Личные файлы и каталоги хранятся в `~/.local/share/chezmoi`виде обычных общедоступных файлов с разрешениями `0644`и префиксом имени `private_`. Например:

```
$ chezmoi add ~/.netrc
```

создаст `~/.local/share/chezmoi/private_dot_netrc`(при `~/.netrc` условии, что он не читается в мире или группе, как это должно быть). Этот файл по - прежнему является закрытым , поскольку `~/.local/share/chezmoi`он не доступен для чтения в группах или во всем мире и не является исполняемым. chezmoi проверяет наличие разрешений `~/.local/share/chezmoi``0700`на каждый запуск и выводит предупреждение, если это не так.

Как правило, вам необходимо хранить токены доступа в файлах конфигурации, например[, токен доступа на GitHub](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/). Существует несколько способов обеспечить безопасность этих токенов и предотвратить их покидание вашей машины.

___

### Используйте 1 пароль[#](https://www.chezmoi.io/docs/how-to/#use-1password)

chezmoi включает поддержку [1Password с](https://1password.com/) использованием [интерфейса командной](https://support.1password.com/command-line-getting-started/) строки 1Password для предоставления данных в качестве функции шаблона.

Войдите в систему и получите сеанс с помощью:

```
$ eval $(op signin <subdomain>.1password.com <email>)
```

Вывод `op get item <uuid>`доступен в качестве функции `onepassword`шаблона . chezmoi анализирует выходные данные JSON и возвращает их в виде структурированных данных. Например, если вывод `op get item "<uuid>"`является:

```
{
    "uuid": "<uuid>",
    "details": {
        "password": "xxx"
    }
}
```

Затем вы можете получить доступ `details.password`с помощью синтаксиса:

```
{{ (onepassword "<uuid>").details.password }}
```

Поля данных для входа можно получить с помощью`onepasswordDetailsFields` функция, например:

```
{{- (onepasswordDetailsFields "uuid").password.value }}
```

Документы можно получить с помощью:

```
{{- onepasswordDocument "uuid" -}}
```

Обратите внимание на дополнительные `-`после открытия `{{`и перед закрытием `}}`. Это указывает языку шаблонов удалять любые пробелы до и после подстановки. Это удаляет любую завершающую новую строку, добавленную вашим редактором при сохранении шаблона.

___

### Используйте Bitwarden[#](https://www.chezmoi.io/docs/how-to/#use-bitwarden)

chezmoi включает поддержку [Bitwarden с](https://bitwarden.com/) использованием [интерфейса командной](https://github.com/bitwarden/cli) строки Bitwarden для предоставления данных в качестве функции шаблона.

Войдите в Bitwarden с помощью:

```
$ bw login <bitwarden-email>
```

Разблокируйте свое хранилище Bitwarden:

```
$ bw unlock
```

Установите `BW_SESSION`переменную среды, как указано в инструкции.

Структурированные данные из `bw get`доступны в качестве функции `bitwarden`шаблона в ваших файлах конфигурации, например:

```
username = {{ (bitwarden "item" "example.com").login.username }}
password = {{ (bitwarden "item" "example.com").login.password }}
```

Доступ к пользовательским полям можно получить с `bitwardenFields`помощью функции шаблона. Например, если у вас есть пользовательское поле с именем`token`, вы можете получить его значение с помощью:

```
{{ (bitwardenFields "item" "example.com").token.value }}
```

___

### Используйте gopass [#](https://www.chezmoi.io/docs/how-to/#use-gopass)

chezmoi включает поддержку [gopass](https://www.gopass.pw/) с использованием интерфейса командной строки gopass.

Первая строка вывода `gopass show <pass-name>`доступна в качестве функции `gopass`шаблона, например:

```
{{ gopass "<pass-name>" }}
```

___

### Используйте KeePassXC [#](https://www.chezmoi.io/docs/how-to/#use-keepassxc)

chezmoi включает поддержку [KeePassXC с](https://keepassxc.org/) использованием интерфейса командной строки KeePassXC (`keepassxc-cli`) для предоставления данных в качестве функции шаблона.

Укажите путь к базе данных KeePassXC в файле конфигурации:

```
[keepassxc]
    database = "/home/user/Passwords.kdbx"
```

Структурированные данные из `keepassxc-cli show $database`доступны в качестве функции `keepassxc`шаблона в ваших файлах конфигурации, например:

```
username = {{ (keepassxc "example.com").UserName }}
password = {{ (keepassxc "example.com").Password }}
```

Дополнительные атрибуты доступны через `keepassxcAttribute`функцию. Например, если у вас есть запись `SSH Key`с вызовом дополнительного атрибута `private-key`, ее значение доступно как:

```
{{ keepassxcAttribute "SSH Key" "private-key" }}
```

___

### Используйте связку ключей или Диспетчер учетных данных Windows [#](https://www.chezmoi.io/docs/how-to/#use-keychain-or-windows-credentials-manager)

chezmoi включает поддержку связки ключей (на macOS), связки ключей GNOME (в Linux) и диспетчера учетных данных Windows (в Windows) через [`zalando/go-keyring`](https://github.com/zalando/go-keyring)библиотеку.

Установите значения с помощью:

```
$ chezmoi secret keyring set --service=<service> --user=<user>
Value: xxxxxxxx
```

Затем значение может быть использовано в шаблонах с помощью `keyring`функции, которая принимает службу и пользователя в качестве аргументов.

Например, сохраните токен доступа GitHub в связке ключей с:

```
$ chezmoi secret keyring set --service=github --user=<github-username>
Value: xxxxxxxx
```

а затем включите его в свой `~/.gitconfig`файл с:

```
[github]
    user = {{ .github.user | quote }}
    token = {{ keyring "github" .github.user | quote }}
```

Вы можете запросить связку ключей из командной строки:

```
$ chezmoi secret keyring get --service=github --user=<github-username>
```

___

### Используйте LastPass [#](https://www.chezmoi.io/docs/how-to/#use-lastpass)

chezmoi включает поддержку [LastPass с](https://lastpass.com/) использованием [интерфейса командной](https://lastpass.github.io/lastpass-cli/lpass.1.html) строки LastPass для предоставления данных в качестве функции шаблона.

Войдите в LastPass с помощью:

```
$ lpass login <lastpass-username>
```

Проверьте правильность `lpass`работы, показав данные пароля:

```
$ lpass show --json <lastpass-entry-id>
```

где `<lastpass-entry-id>`находится запись [LastPass Спецификация](https://lastpass.github.io/lastpass-cli/lpass.1.html#_entry_specification).

Структурированные данные из `lpass show --json id`доступны в качестве функции `lastpass`шаблона. Значением будет массив объектов. Вы можете использовать `index`функцию и `.Field`синтаксис `text/template`языка для извлечения нужного поля. Например, чтобы извлечь `password`поле из первой записи “GitHub”, используйте:

```
githubPassword = {{ (index (lastpass "GitHub") 0).password | quote }}
```

chezmoi автоматически анализирует `note`значение записи Lastpass в виде пар ключ-значение, разделенных двоеточием, поэтому, например, вы можете извлечь закрытый SSH -ключ следующим образом:

```
{{ (index (lastpass "SSH") 0).note.privateKey }}
```

Ключи в `note`разделе, записанные как`CamelCase Words`, преобразуются в `camelCaseWords`.

Если `note`значение не содержит пар ключ-значение, разделенных двоеточием, то вы можете использовать `lastpassRaw`его для получения исходного значения, например:

```
{{ (index (lastpassRaw "SSH Private Key") 0).note }}
```

___

### Используйте пропуск [#](https://www.chezmoi.io/docs/how-to/#use-pass)

chezmoi включает поддержку [pass](https://www.passwordstore.org/) с помощью интерфейса командной строки pass.

Первая строка вывода `pass show <pass-name>`доступна в качестве функции `pass`шаблона, например:

```
{{ pass "<pass-name>" }}
```

___

### Используйте Хранилище [#](https://www.chezmoi.io/docs/how-to/#use-vault)

chezmoi включает поддержку [хранилища с](https://www.vaultproject.io/) использованием [интерфейса командной](https://www.vaultproject.io/docs/commands/) строки хранилища для предоставления данных в качестве функции шаблона.

Интерфейс командной строки хранилища должен быть правильно настроен на вашем компьютере, например`VAULT_ADDR`, `VAULT_TOKEN`переменные среды и должны быть установлены правильно. Убедитесь, что это так, запустив:

```
$ vault kv get -format=json <key>
```

Структурированные данные из `vault kv get -format=json`доступны в виде`vault` функция шаблона. Вы можете использовать `.Field`синтаксис`text/template` язык для извлечения нужных вам данных. Например:

```
{{ (vault "<key>").data.data.password }}
```

___

### Используйте пользовательский менеджер паролей [#](https://www.chezmoi.io/docs/how-to/#use-a-custom-password-manager)

Вы можете использовать любой инструмент командной строки, который выводит секреты либо в виде строки, либо в формате JSON. Выберите двоичный `secret.command`файл, указав его в файле конфигурации. Затем вы можете вызвать эту команду с `secret``secretJSON`помощью функций шаблона и, которые возвращают исходные данные и данные, декодированные в формате JSON, соответственно. Все вышеперечисленные секретные менеджеры могут быть поддержаны таким образом:

Секретный менеджер

`secret.command`

Каркас шаблона

1 Пароль

`op`

`{{ secretJSON "get" "item" <id> }}`

Битварден

`bw`

`{{ secretJSON "get" <id> }}`

Хранилище HashiCorp

`vault`

`{{ secretJSON "kv" "get" "-format=json" <id> }}`

Последний проход

`lpass`

`{{ secretJSON "show" "--json" <id> }}`

KeePassXC

`keepassxc-cli`

Невозможно (только интерактивная команда)

проходить

`pass`

`{{ secret "show" <id> }}`

___

### Шифруйте целые файлы с помощью gpg[#](https://www.chezmoi.io/docs/how-to/#encrypt-whole-files-with-gpg)

chezmoi поддерживает шифрование файлов с [помощью gpg](https://www.gnupg.org/). Зашифрованные файлы хранятся в исходном состоянии и автоматически расшифровываются при создании целевого состояния или печати содержимого файла `chezmoi cat`. `chezmoi edit` будет прозрачно расшифровывать файл перед редактированием и повторно шифровать его впоследствии.

___

#### Асимметричное шифрование (с закрытым/открытым ключом) [#](https://www.chezmoi.io/docs/how-to/#asymmetric-privatepublic-key-encryption)

Укажите ключ шифрования для использования в файле конфигурации (`chezmoi.toml`) вместе с `gpg.recipient`ключом:

```
encryption = "gpg"
[gpg]
    recipient = "..."
```

Добавьте файлы, которые будут зашифрованы с `--encrypt`помощью флага, например:

```
$ chezmoi add --encrypt ~/.ssh/id_rsa
```

chezmoi зашифрует файл с помощью:

```
gpg --armor --recipient ${gpg.recipient} --encrypt
```

и сохраните зашифрованный файл в исходном состоянии. Файл будет автоматически расшифрован при создании целевого состояния.

___

#### Симметричное шифрование[#](https://www.chezmoi.io/docs/how-to/#symmetric-encryption)

Укажите симметричное шифрование в файле конфигурации:

```
encryption = "gpg"
[gpg]
    symmetric = true
```

Добавьте файлы, которые будут зашифрованы с `--encrypt`помощью флага, например:

```
$ chezmoi add --encrypt ~/.ssh/id_rsa
```

chezmoi зашифрует файл с помощью:

___

### Шифруйте целые файлы с возрастом [#](https://www.chezmoi.io/docs/how-to/#encrypt-whole-files-with-age)

chezmoi поддерживает шифрование файлов с [возрастом](https://age-encryption.org/). Зашифрованные файлы хранятся в исходном состоянии и автоматически расшифровываются при создании целевого состояния или печати содержимого файла `chezmoi cat`. `chezmoi edit` будет прозрачно расшифровывать файл перед редактированием и повторно шифровать его впоследствии.

Сгенерируйте ключ с помощью`age-keygen`:

```
$ age-keygen -o $HOME/key.txt
Public key: age1ql3z7hjy54pw3hyww5ayyfg7zqgvc7w3j2elw8zmrj2kg5sfn9aqmcac8p
```

Укажите шифрование возраста в файле конфигурации, обязательно указав по крайней мере личность и одного получателя:

```
encryption = "age"
[age]
    identity = "/home/user/key.txt"
    recipient = "age1ql3z7hjy54pw3hyww5ayyfg7zqgvc7w3j2elw8zmrj2kg5sfn9aqmcac8p"
```

Добавьте файлы, которые будут зашифрованы с `--encrypt`помощью флага, например:

```
$ chezmoi add --encrypt ~/.ssh/id_rsa
```

chezmoi поддерживает несколько получателей и файлов получателей, а также несколько удостоверений личности.

___

#### Симметричное шифрование[#](https://www.chezmoi.io/docs/how-to/#symmetric-encryption-1)

Чтобы использовать симметричное шифрование age, укажите один идентификатор и включите симметричное шифрование в файле конфигурации, например:

```
encryption = "age"
[age]
    identity = "~/.ssh/id_rsa"
    symmetric = true
```

___

#### Симметричное шифрование с парольной фразой [#](https://www.chezmoi.io/docs/how-to/#symmetric-encryption-with-a-passphrase)

Чтобы использовать симметричное шифрование age с парольной `age.passphrase`фразой, например, установите значение `true`в файле конфигурации:

```
encryption = "age"
[age]
    passphrase = true
```

Вам будет предложено ввести кодовую фразу при каждом запуске `chezmoi add --encrypt` и всякий раз, когда chezmoi потребуется расшифровать файл, например, при запуске `chezmoi apply`, `chezmoi diff`, или `chezmoi status`.

___

### Используйте частный файл конфигурации и переменные шаблона[#](https://www.chezmoi.io/docs/how-to/#use-a-private-configuration-file-and-template-variables)

Как правило, `~/.config/chezmoi/chezmoi.toml`не регистрируется в системе управления версиями и имеет разрешения 0600. Вы можете хранить токены в качестве значений шаблона в этом `data`разделе. Например, если ваш `~/.config/chezmoi/chezmoi.toml`содержит:

```
[data.github]
    user = "<github-username>"
    token = "<github-token>"
```

`~/.local/share/chezmoi/private_dot_gitconfig.tmpl`Затем вы можете содержать:

```
{{- if (index . "github") }}
[github]
    user = {{ .github.user | quote }}
    token = {{ .github.token | quote }}
{{- end }}
```

Любые файлы конфигурации, содержащие токены в виде обычного текста, должны быть закрытыми (разрешения `0600`).

___

## Используйте сценарии для выполнения действий[#](https://www.chezmoi.io/docs/how-to/#use-scripts-to-perform-actions)

___

### Понять, как работают сценарии[#](https://www.chezmoi.io/docs/how-to/#understand-how-scripts-work)

chezmoi поддерживает сценарии, которые выполняются при запуске `chezmoi apply`. Сценарии могут запускаться либо при каждом запуске `chezmoi apply`, либо только после изменения их содержимого.

В подробном режиме содержимое скрипта будет распечатано перед его выполнением. В режиме сухого запуска сценарий не выполняется.

Сценарии представляют собой любой файл в исходном каталоге с префиксом `run_`и выполняются в алфавитном порядке. Сценарии, которые следует запускать только в том случае, если они не запускались ранее, имеют префикс `run_once_`. Сценарии, которые следует запускать всякий раз, когда их содержимое изменяется, имеют `run_onchange_`префикс.

Сценарии нарушают декларативный подход chezmoi, и поэтому их следует использовать экономно. Любой сценарий должен быть идемпотентным, даже `run_once_`и `run_onchange_`сценарии.

Сценарии должны создаваться вручную в исходном каталоге, как правило, путем запуска`chezmoi cd`, а затем создания файла с `run_`префиксом. Сценарии выполняются непосредственно с использованием `exec`и должны включать строку shebang или быть исполняемыми двоичными файлами. Нет необходимости устанавливать исполняемый бит в сценарии.

Сценарии с суффиксом `.tmpl`обрабатываются как шаблоны, при этом доступны обычные переменные шаблона. Если после выполнения шаблона результатом является только пробел или пустая строка, то сценарий не выполняется. Это полезно для отключения сценариев.

___

### Установка пакетов со сценариями[#](https://www.chezmoi.io/docs/how-to/#install-packages-with-scripts)

Перейдите в исходный каталог и создайте файл с именем`run_once_install-packages.sh`:

```
$ chezmoi cd
$ $EDITOR run_once_install-packages.sh
```

В этом файле создайте сценарий установки пакета, например

```
#!/bin/sh
sudo apt install ripgrep
```

В следующий раз, когда вы запустите `chezmoi apply`или `chezmoi update`этот скрипт будет запущен. Поскольку у него есть `run_once_`префикс, он не будет запущен снова, если его содержимое не изменится, например, если вы добавите дополнительные пакеты для установки.

Этот скрипт также может быть шаблоном. Например, если вы создаете `run_once_install-packages.sh.tmpl`с помощью содержимого:

```
{{ if eq .chezmoi.os "linux" -}}
#!/bin/sh
sudo apt install ripgrep
{{ else if eq .chezmoi.os "darwin" -}}
#!/bin/sh
brew install ripgrep
{{ end -}}
```

Это будет установлено `ripgrep`как в системах Linux Debian/Ubuntu, так и в macOS.

___

### Запуск сценария при изменении содержимого другого файла[#](https://www.chezmoi.io/docs/how-to/#run-a-script-when-the-contents-of-another-file-changes)

`run_`сценарии chezmoi запускаются при каждом запуске `chezmoi apply`, в то `run_once_`время как сценарии запускаются только тогда, когда их содержимое изменилось, после выполнения их в виде шаблонов. Это используется для `run_once_`запуска сценария при изменении содержимого другого файла путем включения контрольной суммы содержимого другого файла в сценарий.

Например, если ваши [](https://wiki.gnome.org/Projects/dconf)настройки dconf хранятся `dconf.ini`в вашем исходном каталоге, вы можете `chezmoi apply`загрузить их только тогда, когда содержимое `dconf.ini`изменилось, добавив следующий сценарий в качестве`run_once_dconf-load.sh.tmpl`:

```
#!/bin/bash

# dconf.ini hash: {{ include "dconf.ini" | sha256sum }}
dconf load / {{ joinPath .chezmoi.sourceDir "dconf.ini" | quote }}
```

Поскольку сумма SHA256 `dconf.ini`включена в комментарий в сценарии, содержимое сценария будет меняться всякий `dconf.ini` раз, когда изменяется содержимое, поэтому chezmoi будет повторно запускать сценарий всякий раз, когда содержимое`dconf.ini` менять.

В этом примере вы также должны добавить`dconf.ini``.chezmoiignore`, чтобы chezmoi не создавался `dconf.ini`в вашем домашнем каталоге.

___

## Используйте chezmoi на macOS[#](https://www.chezmoi.io/docs/how-to/#use-chezmoi-on-macos)

___

### Используйте `brew bundle`для управления своими варами и бочонками[#](https://www.chezmoi.io/docs/how-to/#use-brew-bundle-to-manage-your-brews-and-casks)

[`brew bundle`Подкоманда Homebrew](https://docs.brew.sh/Manpage#bundle-subcommand) позволяет указать список сортов пива и бочек, которые будут установлены. Вы можете интегрировать это с chezmoi, создав `run_once_`скрипт. Например, создайте файл в исходном каталоге с именем`run_once_before_install-packages-darwin.sh.tmpl`, содержащим:

```
{{- if (eq .chezmoi.os "darwin") -}}
#!/bin/bash

brew bundle --no-lock --file=/dev/stdin <<EOF
brew "git"
cask "google-chrome"
EOF
{{ end -}}
```

Обратите внимание, что `Brewfile`он встроен непосредственно в скрипт с помощью документа bash here. chezmoi будет запускать этот скрипт всякий раз, когда его содержимое меняется, т. е. когда вы добавляете или удаляете пиво или бочки.

___

## Используйте chezmoi в Windows[#](https://www.chezmoi.io/docs/how-to/#use-chezmoi-on-windows)

___

### Обнаружение подсистемы Windows для Linux (WSL) [#](https://www.chezmoi.io/docs/how-to/#detect-windows-subsystem-for-linux-wsl)

WSL можно обнаружить , выполнив поиск строки `Microsoft`или `microsoft`в `/proc/sys/kernel/osrelease`, которая доступна в переменной шаблона`.chezmoi.kernel.osrelease`, например:

```
{{ if (eq .chezmoi.os "linux") }}
{{   if (.chezmoi.kernel.osrelease | lower | contains "microsoft") }}
# WSL-specific code
{{   end }}
{{ end }}
```

___

### Запустите сценарий PowerShell от имени администратора в Windows [#](https://www.chezmoi.io/docs/how-to/#run-a-powershell-script-as-admin-on-windows)

Поместите следующее в начало вашего сценария:

```
# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
  if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
    $CommandLine = "-NoExit -File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
    Exit
  }
}
```

___

## Используйте chezmoi с кодовыми пространствами GitHub, кодовыми пространствами Visual Studio или удаленными контейнерами кода Visual Studio [#](https://www.chezmoi.io/docs/how-to/#use-chezmoi-with-github-codespaces-visual-studio-codespaces-or-visual-studio-code-remote---containers)

Ниже предполагается, что вы используете chezmoi 1.8.4 или более поздней версии. Он не работает с более ранними версиями chezmoi.

Вы можете использовать chezmoi для управления файлами точек в [кодовых пространствах GitHub](https://docs.github.com/en/github/developing-online-with-codespaces/personalizing-codespaces-for-your-account), [кодовых пространствах Visual Studio](https://docs.microsoft.com/en/visualstudio/codespaces/reference/personalizing)и [удаленных контейнерах кода Visual Studio](https://code.visualstudio.com/docs/remote/containers#_personalizing-with-dotfile-repositories).

Для быстрого начала вы можете клонировать [`chezmoi/dotfiles`репозиторий](https://github.com/chezmoi/dotfiles), который поддерживает кодовые пространства, прямо из коробки.

Рабочий процесс отличается от использования chezmoi на новой машине, в частности:

+   Эти системы автоматически клонируют ваше `dotfiles`репо `~/dotfiles`, поэтому нет необходимости клонировать ваше репо самостоятельно.
+   Сценарий установки должен быть неинтерактивным.
+   При запуске в кодовом пространстве переменная `CODESPACES`среды будет установлена в `true`значение . Вы можете прочитать его значение с [`env`помощью функции шаблона](http://masterminds.github.io/sprig/os.html).

Во-первых, если вы используете шаблон файла конфигурации chezmoi, убедитесь, что он не является интерактивным при запуске в кодовых пространствах, например, `.chezmoi.toml.tmpl`может содержать:

```
{{- $codespaces:= env "CODESPACES" | not | not -}}
sourceDir = {{ .chezmoi.sourceDir | quote }}

[data]
    name = "Your name"
    codespaces = {{ $codespaces }}
{{- if $codespaces }}{{/* Codespaces dotfiles setup is non-interactive, so set an email address */}}
    email = "your@email.com"
{{- else }}{{/* Interactive setup, so prompt for an email address */}}
    email = {{ promptString "email" | quote }}
{{- end }}
```

Это устанавливает переменную `codespaces`шаблона, поэтому вам не нужно повторять `(env "CODESPACES")`в своих шаблонах. Он также устанавливает `sourceDir`конфигурацию `--source`в соответствии с переданным аргументом `chezmoi init`.

Во-вторых, создайте `install.sh`скрипт, который устанавливает chezmoi и ваши файлы точек:

```
#!/bin/sh

set -e # -e: exit on error

if [ ! "$(command -v chezmoi)" ]; then
  bin_dir="$HOME/.local/bin"
  chezmoi="$bin_dir/chezmoi"
  if [ "$(command -v curl)" ]; then
    sh -c "$(curl -fsLS https://git.io/chezmoi)" -- -b "$bin_dir"
  elif [ "$(command -v wget)" ]; then
    sh -c "$(wget -qO- https://git.io/chezmoi)" -- -b "$bin_dir"
  else
    echo "To install chezmoi, you must have curl or wget installed." >&2
    exit 1
  fi
else
  chezmoi=chezmoi
fi

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"
# exec: replace current process with chezmoi init
exec "$chezmoi" init --apply "--source=$script_dir"
```

Убедитесь, что этот файл является исполняемым (`chmod a+x install.sh`), и добавьте `install.sh` в ваше `.chezmoiignore`досье.

При необходимости он устанавливает последнюю версию chezmoi`~/.local/bin`, а затем `chezmoi init ...`вызывает chezmoi, чтобы создать файл конфигурации и инициализировать ваши файлы точек. `--apply` говорит чезмою немедленно применить изменения и `--source=...`сообщает чезмою, где найти клонированное `dotfiles`репозитарие, которое в данном случае является той же папкой, из которой выполняется сценарий.

Если вы не используете шаблон файла конфигурации chez moi, вы можете использовать `chezmoi apply --source=$HOME/dotfiles`его вместо `chezmoi init ...`in `install.sh`.

Наконец, измените любой из ваших шаблонов, чтобы `codespaces`при необходимости использовать переменную. Например, для установки `vim-gtk`в Linux, но не в кодовых пространствах, вы `run_once_install-packages.sh.tmpl`можете содержать:

```
{{- if (and (eq .chezmoi.os "linux") (not .codespaces)) -}}
#!/bin/sh
sudo apt install -y vim-gtk
{{- end -}}
```

___

## Настройка chezmoi [#](https://www.chezmoi.io/docs/how-to/#customize-chezmoi)

___

### Не показывайте сценарии в выходных данных diff[#](https://www.chezmoi.io/docs/how-to/#dont-show-scripts-in-the-diff-output)

По умолчанию `chezmoi diff`будут показаны все изменения, включая содержимое сценариев, которые будут запущены. Вы можете исключить сценарии из выходных данных diff, установив переменную `diff.exclude`конфигурации в файле конфигурации, например:

```
[diff]
    exclude = ["scripts"]
```

___

Вы можете изменить формат diff и/или передать вывод на пейджер по вашему выбору, установив `diff.pager`переменную конфигурации. Например, для использования [`diff-so-fancy`](https://github.com/so-fancy/diff-so-fancy)укажите:

```
[diff]
    pager = "diff-so-fancy"
```

Пейджер можно отключить с помощью `--no-pager`флага или установив `diff.pager` пустую строку.

___

### Используйте пользовательский инструмент различий[#](https://www.chezmoi.io/docs/how-to/#use-a-custom-diff-tool)

По умолчанию chezmoi использует встроенное различие. Вы можете использовать пользовательский инструмент, установив `diff.command``diff.args`переменные и конфигурации. Элементы `diff.args`интерпретируются как шаблоны с переменными `.Destination`и `.Target`содержат имена файлов файла в состоянии назначения и целевом состоянии соответственно. Например, чтобы использовать [meld](https://meldmerge.org/), укажите:

```
[diff]
    command = "meld"
    args = ["--diff", "{{ .Destination }}", "{{ .Target }}"]
```

___

### Используйте пользовательский инструмент слияния [#](https://www.chezmoi.io/docs/how-to/#use-a-custom-merge-tool)

По умолчанию chezmoi использует vimdiff. Вы можете использовать пользовательский инструмент, установив `merge.command``merge.args`переменные и конфигурации. Элементы `merge.args`интерпретируются как шаблоны с переменными`.Destination``.Source`, и `.Target`содержат имена файлов файла в состоянии назначения, исходном состоянии и целевом состоянии соответственно. Например, чтобы использовать [режим различий](https://neovim.io/doc/user/diff.html)neovim, укажите:

```
[merge]
    command = "nvim"
    args = ["-d", "{{ .Destination }}", "{{ .Source }}", "{{ .Target }}"]
```

___

## Переход на chezmoi из другого менеджера dotfile [#](https://www.chezmoi.io/docs/how-to/#migrating-to-chezmoi-from-another-dotfile-manager)

___

### Миграция из диспетчера точечных файлов, использующего символические ссылки[#](https://www.chezmoi.io/docs/how-to/#migrate-from-a-dotfile-manager-that-uses-symlinks)

Многие менеджеры файлов точек заменяют файлы точек символическими ссылками на файлы в общем каталоге. Если у вас `chezmoi add`такая символическая ссылка, chezmoi добавит символическую ссылку, а не файл. Чтобы помочь с переходом с систем, основанных на символических ссылках , используйте `--follow`опцию`chezmoi add`, например:

```
$ chezmoi add --follow ~/.bashrc
```

Это покажет`chezmoi add`, что целевое состояние `~/.bashrc`является целью `~/.bashrc`символической ссылки, а не самой символической ссылкой. Когда ты бежишь `chezmoi apply`, chezmoi заменит `~/.bashrc`символическую ссылку содержимым файла.

___

## Мигрируйте подальше от чезмои[#](https://www.chezmoi.io/docs/how-to/#migrate-away-from-chezmoi)

chezmoi предоставляет несколько механизмов, которые помогут вам перейти к альтернативному менеджеру dotfile (или даже вообще не использовать менеджер dotfile) в будущем:

+   chezmoi создает ваши файлы точек так же, как если бы вы вообще не использовали менеджер файлов точек. Ваши точечные файлы-это обычные файлы, каталоги и символические ссылки. Вы можете запустить[`chezmoi purge`](https://www.chezmoi.io/docs/reference/#purge), чтобы удалить все следы chezmoi, а затем, если вы переходите на новый менеджер файлов точек, вы можете использовать любой механизм, который он предоставляет, для добавления ваших файлов точек в вашу новую систему.
+   У chezmoi есть [`chezmoi archive`](https://www.chezmoi.io/docs/reference/#archive)команда, которая генерирует tar-файл ваших точечных файлов. Вы можете заменить содержимое вашего репозитория dotfiles содержимым архива, и вы фактически сразу же перешли из chezmoi.
+   У chezmoi есть [`chezmoi dump`](https://www.chezmoi.io/docs/reference/#dump-target)команда, которая выводит интерпретируемое (целевое) состояние в машиночитаемую форму, поэтому вы можете писать сценарии вокруг chezmoi.
`###### tags: [] `
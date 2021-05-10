---
DESCRIPTION: |
    При написании скриптов практически всегда имеется необходимость в
    проверке(ветвлении) каких либо процессов, другими словами --- «делать
    это? или не делать?
KEYWORDS: 'bash,if,then,else,fi,Проверка условий в bash,Linux'
lang: ru
title: |
    Проверка условий в bash / Unix-way / IT бубен - шаманим вместе, блоги,
    сообщества
---

::: {#debug style="border: 2px #dd0000 solid; display: none;"}
:::

::: {#container}
::: {style="display: none;"}
::: {#login-form .login-popup}
::: {.login-popup-top}
[](#){.close-block}
:::

::: {.content}
### 0.0.1. Авторизация

::: {.lite-note}
[Зарегистрироваться](http://itbuben.org/registration/)Логин или эл.
почта
:::

::: {.lite-note}
[Напомнить пароль](http://itbuben.org/login/reminder/)Пароль
:::

::: {.lite-note}
*Войти*

Запомнить меня
:::
:::

::: {.login-popup-bottom}
:::
:::
:::

::: {#header}
::: {.logo}
[![itbuben.org](http://itbuben.org//templates/skin/itbuben/images/logo.png)](http://itbuben.org/)
:::

::: {.menu-wrapper-tags}
::: {.menu-tags}
::: {.left-bg-tags}
::: {.right-bg-tags}
-   [GNU/Linux](http://itbuben.org/blog/Unix-way/)
-   [Windows](http://itbuben.org/blog/Windows/)
-   [IT-Новости](http://itbuben.org/blog/news_IT/)
-   [Q&A](http://itbuben.org/blog/question/ "Вопрос/Ответ")
-   [Все сообщества](http://itbuben.org/blogs/)
:::
:::
:::
:::

-   [Блоги](http://itbuben.org/blog/)
-   [Люди](http://itbuben.org/people/)

::: {.profile .guest}
[Войти](http://itbuben.org/login/) или
[Зарегистрироваться](http://itbuben.org/registration/){.reg}
:::
:::

::: {#nav}
::: {.menu-box .menu-box-corner}
::: {.write}
[](http://itbuben.org/topic/add/ "написать")
:::

-   [Главная](http://itbuben.org/)
-   [Сообщества](http://itbuben.org/blog/)
    ::: {.sub-menu-wrapper}
    ::: {.sub-menu-box}
    ::: {.left-bg}
    ::: {.right-bg}
    -   [Зачетные](http://itbuben.org/blog/)
    -   [Не зачетные](http://itbuben.org/blog/bad/)
    :::
    :::
    :::
    :::

-   [Личные блоги](http://itbuben.org/personal_blog/)
-   [TOP](http://itbuben.org/top/)

::: {.right}
:::

::: {.search}
:::
:::
:::

::: {#wrapper .update-hide}
::: {#content}
::: {.box}
::: {.inner}
::: {.topic}
::: {.favorite .fav-guest}
[](#)
:::

-   

::: {.content}
::: {style="margin-bottom: 20px;"}
::: {#yandex_rtb_R-A-649753-2}
:::
:::

При написании скриптов практически всегда имеется необходимость в
проверке(ветвлении) каких либо процессов, другими словами --- «делать
это? или не делать? а если делать то что?». В интернетах достаточно
много информации о операторах if\|then\|else которые и позволяют нам
манипулировать ходом выполнения нашего скрипта. Тут главное понять «как
это работает» все остальное приходит с практикой. Оговорюсь --- не
претендую на истину, потому что bash только изучаю, не один из примеров
не несет сакраментального характера, все они сделаны для наглядности.\
\
**Операторы if\|then и else**\
\
Операторы if\|then проверяют код завершения списка команд на «успешное
завершение(истина)» что в свою очередь означает «0», и если это так, то
выполняет одну или более команд следующих за словом then. Если проверка
возвращает «не успешное завершение (ложь)» что в свою очередь означает
«1» выполняется else «иначе» если того требует условие. В завершении
условия обязательно закрываем его «fi»!\
\
Все выше написанное возможно будет понятно не сразу, но когда дальше по
статье пойдут примеры, все станет на свои места.\
\
**Скобки**\
\
\[ --- является специальной встроенной командой test воспринимающей свои
аргументы как выражение сравнения или файловую проверку \[\.....\].\
\
\[\[ --- расширенный вариант от «\[«, является зарезервированным словом,
а не командой, его bash выполняет как один элемент с кодом возврата.
Внутри «\[\[\....\]\]» разрешается выполнение операторов &&, \|\|
которые приводят к ошибке в обычных скобках «\[\....\]» тем самым
вариант с двойной скобкой более универсален.\
\
(( --- является арифметическими выражениями, которое так же возвращают
код 0. Тем самым такие выражения могут участвовать в операциях
сравнения.\
\
Приведу список логических операторов, которые используются для
if\|then\|else:\
\

-   строка пуста\

    ``` {.prettyprint}
    -z
    ```

-   строка не пуста\

    ``` {.prettyprint}
    -n
    ```

-   строки равны\

    ``` {.prettyprint}
    =, ( == )
    ```

-   строки неравны\

    ``` {.prettyprint}
    !=
    ```

-   равно\

    ``` {.prettyprint}
    -eq
    ```

-   неравно\

    ``` {.prettyprint}
    -ne
    ```

-   меньше\

    ``` {.prettyprint}
    -lt,(< )
    ```

-   меньше или равно\

    ``` {.prettyprint}
    -le,(<=)
    ```

-   больше\

    ``` {.prettyprint}
    -gt,(>)
    ```

-   больше или равно\

    ``` {.prettyprint}
    -ge,(>=)
    ```

-   отрицание логического выражения\

    ``` {.prettyprint}
    !
    ```

-   логическое «И»\

    ``` {.prettyprint}
    -a,(&&)
    ```

-   логическое «ИЛИ»\

    ``` {.prettyprint}
    -o,(||)
    ```

\
\
**Конструкции простой проверки if\|then**\
\

``` {.prettyprint}
if условие; then
    команды
fi
```

\
\
другими словами\
\

``` {.prettyprint}
если  проверяемое_выражение_или_команды_верны;  то
   выполняем команды
закрываем если
```

\
\
***Пример 1***\

``` {.prettyprint}
#!/bin/bash

if echo Тест; then
    echo 0
fi
```

\
\
Часто встречается в скриптах проверка --- «существует ли файлы или
каталоги» на их примере покажу работу\
\
***пример 2***\
\

``` {.prettyprint}
#!/bin/bash

if [ -f $HOME/.bashrc ]; then
    echo "Файл существует!"
fi
```

\
\
*где*\

-   \$HOME/.bashrc --- путь до файла
-   echo --- печатает сообщение в консоль

\
***Пример 3***\
\

``` {.prettyprint}
#!/bin/bash

if [[ -f $HOME/.bashrc && -f  /usr/bin/nano ]]; then
    echo "Все впорядке, можно редактировать!"
fi
```

\
*где*\

-   && --- логическое «и», если первый путь «истина» проверяем второй,
    если он тоже «истина», то выполняем команды (echo)
-   -f --- ключ проверки на существования файла (о них чуть ниже)

\
\
**Конструкции простой проверки if\|then\|else**\
\

``` {.prettyprint}
if условие; then
    команды 1
else
    команды 2
fi
```

\
другими словами\
\

``` {.prettyprint}
если проверяемое_выражение_или_команды_верны;  то
   команды 1
иначе
   команды 2
закрываем если
```

\
\
***Пример 4***\
\
Возможно не лучший пример, нас интересует именно ответ 0 или 1. В
результате печатается в консоль «Тест» и «0» потому что команда «echo
Тест» успешна и это «истина».\

``` {.prettyprint}
#!/bin/bash

if echo Тест; then
    echo 0
else
    echo 1
fi
```

\
\
Намерено допустите ошибку изменив echo, в результате получите «1» и
сообщение о том что «команда eho не существует» и это «ложь».\
\

``` {.prettyprint}
#!/bin/bash

if eho Тест; then
    echo 0
else
    echo 1
fi
```

\
\
**Примеры «существуют ли файл?»**\
\
***Пример 5***\
\
Если файл bashrc существует, то печатает в консоль «Файл существует!»,
иначе печатает «Файл не существует!»\
\

``` {.prettyprint}
#!/bin/bash

if [ -f "$HOME/.bashrc" ]; then
    echo "Файл существует!"
else
  echo "Файл не существует!"
fi
```

\
\
Поиграйте с именем проверяемого файла\
\
***Пример 5***\
\

``` {.prettyprint}
#!/bin/bash

if [[ -f "$HOME/.bashrc" && -f "/usr/bin/nano" ]]; then
    echo "Все в порядке, можно редактировать!"
  else
  echo "Ошибка!"
fi
```

\
\
Ключи к фалам и каталогам\

``` {.prettyprint}
[ -ключ "путь" ]
```

\
\

``` {.prettyprint}
[ -e "путь каталогу_или_файлу"] #- существует ли файл или каталог?
[ -r "путь к файлу/каталогу"] #-  доступен ли файл/каталог для чтения?
[ -f "путь к файлу/каталогу"] #- существует ли файл?
[ -d "путь к каталогу"] #- существует ли каталог?
```

\
\
Полное описание возможных применений различных скобок, правильное
разставление кавычек уходит далеко от темы потому могу посоветовать
обратится к руководству [Advanced Bash
Scripting](http://www.bash-scripting.ru/abs/chunks/index.html)\
\
**Арифметика**\
\
***Пример 6***\
\
Если оператор \> использовать внутри \[\[....\]\], он рассматривается
как оператор сравнения строк, а не чисел. Поэтому операторам \> и \< для
сравнения чисел лучше заключить в круглые скобки.\
\
Используем круглые скобки для математического сравнение. Если «3» меньше
«6» печатаем «Да».\

``` {.prettyprint}
#!/bin/bash

if (( 3 < 6)); then
    echo Да
fi
```

\
\
***Пример 7***\
\
Использование команды test коей является квадратные скобки. Если «3»
меньше «6» печатаем «Да».\
\

``` {.prettyprint}
#!/bin/bash

if [ 3 -lt 6 ]; then
    echo Да
fi
```

\
\
Можно использовать и двойные квадратные скобки, как вы наверно уже
поняли это расширенный вариант команды test эквивалентом которой
является «\[ \]». Если «3» меньше «6» печатаем «Да».\
\

``` {.prettyprint}
#!/bin/bash
if [[ 3 -lt 6 ]]; then
    echo Да
fi
```

\
\
***Пример 8***\
\
Используем двойные квадратные скобки, потому что применяем оператор
«&&». Если первое выражение 2 = 2 (истина) тогда выполняем второе, и
если оно тоже 2=2 (истина), печатаем «Верно»\
\

``` {.prettyprint}
#!/bin/bash

a="2"
b="2"
if [[ 2 = "$a" && 2 = "$b" ]] ; then
    echo Верно
else
    echo Не верно
fi
```

\
\
Если первое выражение 2 = 2 (истина) тогда выполняем второе, и если
переменная «b» не равна двум (лож), печатаем «Не верно»\
\

``` {.prettyprint}
#!/bin/bash

a="2"
b="3"
if [[ 2 = "$a" && 2 = "$b" ]] ; then
    echo Верно
else
    echo Не верно
fi
```

\
\
Можно конечно сделать проще, нам главное понять принцип if\|then и else,
не стесняйтесь менять подставляя свои значения.\
\
**Вложение нескольких проверок**\
\
Bash позволяет вкладывать в блок несколько блоков\
\

``` {.prettyprint}
#!/bin/bash

if [ Условие 1 ]; then
  if [ Условие 2 ]; then
    Команда 1
  else
    Команда 2
  fi
else
  Команда 3
fi
```

\
\
**Построения многоярусных конструкций**\
\
Для построения многоярусных конструкции, когда необходимо выполнять
множество проверок лучше использовать elif --- это краткая форма записи
конструкции else if.\
\

``` {.prettyprint}
if [ Условие 1 ]; then
   Команда 1
   Команда 2
elif [ Условие 2 ]; then
   Команда 3
   Команда 4
else
   Команда 5
fi
```
:::

-   [bash](http://itbuben.org/tag/bash/),
-   [if](http://itbuben.org/tag/if/),
-   [then](http://itbuben.org/tag/then/),
-   [else](http://itbuben.org/tag/else/),
-   [fi](http://itbuben.org/tag/fi/),
-   [Проверка условий в
    bash](http://itbuben.org/tag/Проверка%20условий%20в%20bash/),
-   [Linux](http://itbuben.org/tag/Linux/)

::: {.boxline}
::: {.content-line-cr}
::: {.content-line-lt}
::: {.content-line-rt}
::: {.inner}
:::
:::
:::
:::
:::

-   [![avatar](http://itbuben.org/uploads/images/00/00/47/2010/10/29/avatar_24x24.png?204716){.avatar}](http://itbuben.org/profile/itshnic/)
-   [itshnic](http://itbuben.org/profile/itshnic/)
-   54777
-   [](#)
-   +23
-   [](#)
-   11 апреля 2011, 20:02

<!-- -->

-   -   -   [В мой
    мир](http://connect.mail.ru/share?share_url=http://itbuben.org/blog/Unix-way/807.html){.mrc__share}
-   [![Опубликовать в своем блоге
    livejournal.com](http://itbuben.org//templates/skin/itbuben/images/livejournal.png){width="19"}](http://www.livejournal.com/update.bml?event=http://itbuben.org/blog/Unix-way/807.html&subject=Проверка%20условий%20в%20bash "Опубликовать в своем блоге livejournal.com")
-   [![](http://itbuben.org//templates/skin/itbuben/images/yandex.png "Поделиться с друзьями на Я.ру"){width="19"}](http://wow.ya.ru/posts_share_link.xml?url=http://itbuben.org/blog/Unix-way/807.html&title=Проверка%20условий%20в%20bash)
-   [![](http://itbuben.org//templates/skin/itbuben/images/odnoklassniki.png "Поделиться с друзьями в Одноклассниках"){width="19"}](http://www.odnoklassniki.ru/dk?st.cmd=addShare&st.s=1&st._surl=http://itbuben.org/blog/Unix-way/807.html)
-   -   [Tweet](http://twitter.com/share){.twitter-share-button}

::: {style="overflow: hidden; width: 100%; clear: both; padding-top: 20px;"}
::: {#yandex_rtb_R-A-649753-1}
:::
:::
:::
:::
:::

::: {.comments}
::: {.header}
### 0.0.2. Комментариум ([4]{#count-comments})

[]{#comments} [RSS](http://itbuben.org/rss/comments/807/){.rss}
[свернуть](#) / [развернуть](#)
:::

::: {#comment_id_10552 .comment}
![+](http://itbuben.org//templates/skin/itbuben/images/close.gif "свернуть/развернуть"){.folding}
[]{#comment10552}

::: {.voting .positive .guest}
::: {.total}
+6
:::

[](#){.plus} [](#){.minus}
:::

::: {.info}
[![avatar](http://itbuben.org/uploads/images/00/01/06/2010/11/19/avatar_24x24.png?160105){.avatar}](http://itbuben.org/profile/StranNik/)

[StranNik](http://itbuben.org/profile/StranNik/){.author}

-   12 апреля 2011, 07:14
-   [](#comment10552 "Ссылка"){.imglink .link}
-   [↓](# "Обратно к ответу")
:::

::: {#comment_content_id_10552 .content}
::: {.bl}
::: {.bb}
::: {.br}
:::
:::
:::

::: {#comment_text_10552 .text}
Весьма полезно, спасибо!\
\
Хотелось бы побольше примеров, например я долго искал как можно
использовать в условиях результаты выполнения команд:\

``` {.prettyprint}
#!/bin/bash
var=`ps afx | grep -U worker.php ` # Все процессы с именем worker
output=$(grep -e 'first' <<<"$var" | wc -l) # Отсеиваем нужный процесс
if test "$output" -ge "1" ; then # Если больше или равен 1 
    echo "OK - $output"   
else
    /usr/bin/php /var/www/worker.php first & # Иначе запускаем
fi
```
:::

::: {.tb}
::: {.tl}
::: {.tr}
:::
:::
:::
:::

::: {.comment}
::: {.content}
::: {#comment_preview_10552 .text style="display: none;"}
:::
:::
:::

::: {#reply_10552 .reply style="display: none;"}
:::

::: {#comment-children-10552 .comment-children}
:::
:::

::: {#comment_id_10562 .comment}
![+](http://itbuben.org//templates/skin/itbuben/images/close.gif "свернуть/развернуть"){.folding}
[]{#comment10562}

::: {.voting .positive .guest}
::: {.total}
+5
:::

[](#){.plus} [](#){.minus}
:::

::: {.info}
[![avatar](http://itbuben.org/uploads/images/00/01/41/2012/02/25/avatar_24x24.png?150553){.avatar}](http://itbuben.org/profile/pashtuun/)

[pashtuun](http://itbuben.org/profile/pashtuun/){.author}

-   12 апреля 2011, 12:45
-   [](#comment10562 "Ссылка"){.imglink .link}
-   [↓](# "Обратно к ответу")
:::

::: {#comment_content_id_10562 .content}
::: {.bl}
::: {.bb}
::: {.br}
:::
:::
:::

::: {#comment_text_10562 .text}
Добавил в избранное, пригодится, спасибо!
:::

::: {.tb}
::: {.tl}
::: {.tr}
:::
:::
:::
:::

::: {.comment}
::: {.content}
::: {#comment_preview_10562 .text style="display: none;"}
:::
:::
:::

::: {#reply_10562 .reply style="display: none;"}
:::

::: {#comment-children-10562 .comment-children}
:::
:::

::: {#comment_id_10581 .comment}
![+](http://itbuben.org//templates/skin/itbuben/images/close.gif "свернуть/развернуть"){.folding}
[]{#comment10581}

::: {.voting .positive .guest}
::: {.total}
+4
:::

[](#){.plus} [](#){.minus}
:::

::: {.info}
[![avatar](http://www.itbuben.org/uploads/images/00/00/02/2010/09/11/avatar_24x24.jpg?063527){.avatar}](http://itbuben.org/profile/makenskiy/)

[makenskiy](http://itbuben.org/profile/makenskiy/){.author}

-   12 апреля 2011, 18:16
-   [](#comment10581 "Ссылка"){.imglink .link}
-   [↓](# "Обратно к ответу")
:::

::: {#comment_content_id_10581 .content}
::: {.bl}
::: {.bb}
::: {.br}
:::
:::
:::

::: {#comment_text_10581 .text}
Тоже об этом хотел пост делать, спасибо! Еще бы о функциях написать.
:::

::: {.tb}
::: {.tl}
::: {.tr}
:::
:::
:::
:::

::: {.comment}
::: {.content}
::: {#comment_preview_10581 .text style="display: none;"}
:::
:::
:::

::: {#reply_10581 .reply style="display: none;"}
:::

::: {#comment-children-10581 .comment-children}
:::
:::

::: {#comment_id_10901 .comment}
![+](http://itbuben.org//templates/skin/itbuben/images/close.gif "свернуть/развернуть"){.folding}
[]{#comment10901}

::: {.voting .positive .guest}
::: {.total}
+2
:::

[](#){.plus} [](#){.minus}
:::

::: {.info}
[![avatar](http://itbuben.org//templates/skin/itbuben/images/avatar_24x24.jpg){.avatar}](http://itbuben.org/profile/Anonymous/)

[Anonymous](http://itbuben.org/profile/Anonymous/){.author}

-   16 апреля 2011, 22:55
-   [](#comment10901 "Ссылка"){.imglink .link}
-   [↓](# "Обратно к ответу")
:::

::: {#comment_content_id_10901 .content}
::: {.bl}
::: {.bb}
::: {.br}
:::
:::
:::

::: {#comment_text_10901 .text}
Вставь в пост http://www.easyfoto.ru/20110416185448039.gif картинку
наглядную
:::

::: {.tb}
::: {.tl}
::: {.tr}
:::
:::
:::
:::

::: {.comment}
::: {.content}
::: {#comment_preview_10901 .text style="display: none;"}
:::
:::
:::

::: {#reply_10901 .reply style="display: none;"}
:::

::: {#comment-children-10901 .comment-children}
:::
:::

[]{#comment-children-0}\
Только зарегистрированные и авторизованные пользователи могут оставлять
комментарии.\
:::
:::

::: {#sidebar}
::: {.banner-sidebar}
::: {.text style="text-align: left;"}
**Приложение для чтения бубна:**

-   -- Версия для Linux и Windows;
-   -- Уведомление о топиках;
-   -- Уведомление о комментариях;
-   -- Уведомление о личной переписке;
-   -- Подписка на топики пользователей;
-   -- Добавление в избранное;
-   -- Пользовательская настройка.
:::

::: {.text-type-corner}
:::

::: {.text-type}
:::

::: {.promo}
::: {.see}
[Windows](http://itbuben.org/page/itnotify/){.button-1 .more}
:::

::: {.download}
[Linux](http://itbuben.org/page/itnotify/){.button-2 .save}
:::
:::

![](http://itbuben.org/templates/skin/itbuben/images/banner/guru_deb.png){.itnotify}
:::

::: {.block .stream}
::: {.box}
::: {.border-top}
::: {.border-right}
::: {.border-bot}
::: {.border-left}
::: {.left-top-corner}
::: {.right-top-corner}
::: {.right-bot-corner}
::: {.left-bot-corner}
::: {.inner}
-   [](http://itbuben.org//page/rss/ "RSS-канал")
-   [](http://twitter.com/ITbuben "Следуй за нами")

Прямой эфир ↓
=============

-   [Публикации](#){#block_stream_topic}
-   [Комментариум](#){#block_stream_comment}

::: {.block-content}
-   ::: {.avatar}
    [![avatar](http://www.itbuben.org/uploads/images/00/00/02/2010/09/11/avatar_24x24.jpg?063527){.avatar}](http://itbuben.org/profile/makenskiy/)
    :::

    ::: {.info}
    [makenskiy](http://itbuben.org/profile/makenskiy/){.stream-author} →
    []{.stream-comment-icon}[Globoxhost кидалы. Отзыв о
    хостинге.](http://itbuben.org/blog/resent/33568.html#comment30226){.stream-comment}
    7 в [Я негодую](http://itbuben.org/blog/resent/){.stream-blog}
    :::

-   ::: {.avatar}
    [![avatar](http://www.itbuben.org/uploads/images/00/00/02/2010/09/11/avatar_24x24.jpg?063527){.avatar}](http://itbuben.org/profile/makenskiy/)
    :::

    ::: {.info}
    [makenskiy](http://itbuben.org/profile/makenskiy/){.stream-author} →
    []{.stream-comment-icon}[Kodi (Elec, XBMC) и
    приложения](http://itbuben.org/blog/Unix-way/33587.html#comment30223){.stream-comment}
    3 в [Unix-way](http://itbuben.org/blog/Unix-way/){.stream-blog}
    :::

-   ::: {.avatar}
    [![avatar](http://www.itbuben.org/uploads/images/00/00/02/2010/09/11/avatar_24x24.jpg?063527){.avatar}](http://itbuben.org/profile/makenskiy/)
    :::

    ::: {.info}
    [makenskiy](http://itbuben.org/profile/makenskiy/){.stream-author} →
    []{.stream-comment-icon}[Спамеры](http://itbuben.org/blog/administration/28869.html#comment30190){.stream-comment}
    1 в
    [Администрация](http://itbuben.org/blog/administration/){.stream-blog}
    :::

-   ::: {.avatar}
    [![avatar](http://itbuben.org//templates/skin/itbuben/images/avatar_24x24.jpg){.avatar}](http://itbuben.org/profile/Anonymous/)
    :::

    ::: {.info}
    [Anonymous](http://itbuben.org/profile/Anonymous/){.stream-author} →
    []{.stream-comment-icon}[BlueScreen BCCode: 124
    \[решено\]](http://itbuben.org/blog/question/684.html#comment30152){.stream-comment}
    71 в [Есть вопрос](http://itbuben.org/blog/question/){.stream-blog}
    :::

-   ::: {.avatar}
    [![avatar](http://itbuben.org//templates/skin/itbuben/images/avatar_24x24.jpg){.avatar}](http://itbuben.org/profile/KinoPoiskHD/)
    :::

    ::: {.info}
    [KinoPoiskHD](http://itbuben.org/profile/KinoPoiskHD/){.stream-author} →
    []{.stream-comment-icon}[самый опасный человек
    смотреть](http://itbuben.org/blog/8983.html#comment29995){.stream-comment}
    2 в [Личный блог:
    hauteverlu1971](http://itbuben.org/my/hauteverlu1971/){.stream-blog}
    :::

-   ::: {.avatar}
    [![avatar](http://itbuben.org//templates/skin/itbuben/images/avatar_24x24.jpg){.avatar}](http://itbuben.org/profile/KinoPoiskHD/)
    :::

    ::: {.info}
    [KinoPoiskHD](http://itbuben.org/profile/KinoPoiskHD/){.stream-author} →
    []{.stream-comment-icon}[великий уравнитель
    смотреть](http://itbuben.org/blog/8997.html#comment29993){.stream-comment}
    2 в [Личный блог:
    hauteverlu1971](http://itbuben.org/my/hauteverlu1971/){.stream-blog}
    :::

-   ::: {.avatar}
    [![avatar](http://itbuben.org//templates/skin/itbuben/images/avatar_24x24.jpg){.avatar}](http://itbuben.org/profile/KinoPoiskHD/)
    :::

    ::: {.info}
    [KinoPoiskHD](http://itbuben.org/profile/KinoPoiskHD/){.stream-author} →
    []{.stream-comment-icon}[париж город мёртвых смотреть
    онлайн](http://itbuben.org/blog/8967.html#comment29992){.stream-comment}
    2 в [Личный блог:
    hauteverlu1971](http://itbuben.org/my/hauteverlu1971/){.stream-blog}
    :::

-   ::: {.avatar}
    [![avatar](http://itbuben.org//templates/skin/itbuben/images/avatar_24x24.jpg){.avatar}](http://itbuben.org/profile/KinoPoiskHD/)
    :::

    ::: {.info}
    [KinoPoiskHD](http://itbuben.org/profile/KinoPoiskHD/){.stream-author} →
    []{.stream-comment-icon}[избави нас от лукавого 2014 смотреть
    онлайн](http://itbuben.org/blog/8950.html#comment29991){.stream-comment}
    2 в [Личный блог:
    hauteverlu1971](http://itbuben.org/my/hauteverlu1971/){.stream-blog}
    :::

-   ::: {.avatar}
    [![avatar](http://itbuben.org//templates/skin/itbuben/images/avatar_24x24.jpg){.avatar}](http://itbuben.org/profile/KinoPoiskHD/)
    :::

    ::: {.info}
    [KinoPoiskHD](http://itbuben.org/profile/KinoPoiskHD/){.stream-author} →
    []{.stream-comment-icon}[\@LGB@ Волки смотреть онлайн фильм
    2014ё](http://itbuben.org/blog/8823.html#comment29987){.stream-comment}
    2 в [Личный блог:
    densektor](http://itbuben.org/my/densektor/){.stream-blog}
    :::

-   ::: {.avatar}
    [![avatar](http://itbuben.org//templates/skin/itbuben/images/avatar_24x24.jpg){.avatar}](http://itbuben.org/profile/KinoPoiskHD/)
    :::

    ::: {.info}
    [KinoPoiskHD](http://itbuben.org/profile/KinoPoiskHD/){.stream-author} →
    []{.stream-comment-icon}[Мачо и ботан 2 смотреть онлайн 720
    UIX](http://itbuben.org/blog/8838.html#comment29986){.stream-comment}
    2 в [Личный блог:
    densektor](http://itbuben.org/my/densektor/){.stream-blog}
    :::

-   ::: {.avatar}
    [![avatar](http://itbuben.org//templates/skin/itbuben/images/avatar_24x24.jpg){.avatar}](http://itbuben.org/profile/KinoPoiskHD/)
    :::

    ::: {.info}
    [KinoPoiskHD](http://itbuben.org/profile/KinoPoiskHD/){.stream-author} →
    []{.stream-comment-icon}[\@XFK@ Стражи галактики смотреть онлайн в
    хорошем
    качестве](http://itbuben.org/blog/6572.html#comment29983){.stream-comment}
    2 в [Личный блог:
    densektor](http://itbuben.org/my/densektor/){.stream-blog}
    :::

-   ::: {.avatar}
    [![avatar](http://itbuben.org//templates/skin/itbuben/images/avatar_24x24.jpg){.avatar}](http://itbuben.org/profile/KinoPoiskHD/)
    :::

    ::: {.info}
    [KinoPoiskHD](http://itbuben.org/profile/KinoPoiskHD/){.stream-author} →
    []{.stream-comment-icon}[Mega Планета обезьян: революция смотреть
    онлайн
    \$hs\$](http://itbuben.org/blog/8770.html#comment29982){.stream-comment}
    2 в [Личный блог:
    densektor](http://itbuben.org/my/densektor/){.stream-blog}
    :::

-   ::: {.avatar}
    [![avatar](http://itbuben.org//templates/skin/itbuben/images/avatar_24x24.jpg){.avatar}](http://itbuben.org/profile/KinoPoiskHD/)
    :::

    ::: {.info}
    [KinoPoiskHD](http://itbuben.org/profile/KinoPoiskHD/){.stream-author} →
    []{.stream-comment-icon}[\[ПРЕМЬЕРА\] Планета обезьян: Революция
    смотреть онлайн на
    русском](http://itbuben.org/blog/8787.html#comment29980){.stream-comment}
    2 в [Личный блог:
    densektor](http://itbuben.org/my/densektor/){.stream-blog}
    :::

-   ::: {.avatar}
    [![avatar](http://itbuben.org//templates/skin/itbuben/images/avatar_24x24.jpg){.avatar}](http://itbuben.org/profile/KinoPoiskHD/)
    :::

    ::: {.info}
    [KinoPoiskHD](http://itbuben.org/profile/KinoPoiskHD/){.stream-author} →
    []{.stream-comment-icon}[\#2014\# Волки смотреть онлайн
    фильм](http://itbuben.org/blog/8811.html#comment29979){.stream-comment}
    2 в [Личный блог:
    densektor](http://itbuben.org/my/densektor/){.stream-blog}
    :::

-   ::: {.avatar}
    [![avatar](http://itbuben.org//templates/skin/itbuben/images/avatar_24x24.jpg){.avatar}](http://itbuben.org/profile/KinoPoiskHD/)
    :::

    ::: {.info}
    [KinoPoiskHD](http://itbuben.org/profile/KinoPoiskHD/){.stream-author} →
    []{.stream-comment-icon}[WEBRIP Стражи галактики смотреть онлайн
    +720+](http://itbuben.org/blog/8737.html#comment29976){.stream-comment}
    2 в [Личный блог:
    densektor](http://itbuben.org/my/densektor/){.stream-blog}
    :::

-   ::: {.avatar}
    [![avatar](http://itbuben.org//templates/skin/itbuben/images/avatar_24x24.jpg){.avatar}](http://itbuben.org/profile/KinoPoiskHD/)
    :::

    ::: {.info}
    [KinoPoiskHD](http://itbuben.org/profile/KinoPoiskHD/){.stream-author} →
    []{.stream-comment-icon}[FILM Стражи галактики смотреть онлайн
    =hd=](http://itbuben.org/blog/8754.html#comment29974){.stream-comment}
    2 в [Личный блог:
    densektor](http://itbuben.org/my/densektor/){.stream-blog}
    :::

-   ::: {.avatar}
    [![avatar](http://itbuben.org//templates/skin/itbuben/images/avatar_24x24.jpg){.avatar}](http://itbuben.org/profile/KinoPoiskHD/)
    :::

    ::: {.info}
    [KinoPoiskHD](http://itbuben.org/profile/KinoPoiskHD/){.stream-author} →
    []{.stream-comment-icon}[\|FV\| Планета обезьян: революция смотреть
    онлайн
    полностью](http://itbuben.org/blog/8365.html#comment29972){.stream-comment}
    2 в [Личный блог:
    densektor](http://itbuben.org/my/densektor/){.stream-blog}
    :::

-   ::: {.avatar}
    [![avatar](http://itbuben.org//templates/skin/itbuben/images/avatar_24x24.jpg){.avatar}](http://itbuben.org/profile/KinoPoiskHD/)
    :::

    ::: {.info}
    [KinoPoiskHD](http://itbuben.org/profile/KinoPoiskHD/){.stream-author} →
    []{.stream-comment-icon}[Стражи галактики 2014 смотреть онлайн
    полностью](http://itbuben.org/blog/8407.html#comment29970){.stream-comment}
    2 в [Личный блог:
    densektor](http://itbuben.org/my/densektor/){.stream-blog}
    :::

-   ::: {.avatar}
    [![avatar](http://itbuben.org//templates/skin/itbuben/images/avatar_24x24.jpg){.avatar}](http://itbuben.org/profile/KinoPoiskHD/)
    :::

    ::: {.info}
    [KinoPoiskHD](http://itbuben.org/profile/KinoPoiskHD/){.stream-author} →
    []{.stream-comment-icon}[Мачо и ботан 2 смотреть онлайн полный
    фильм](http://itbuben.org/blog/8414.html#comment29968){.stream-comment}
    2 в [Личный блог:
    densektor](http://itbuben.org/my/densektor/){.stream-blog}
    :::

-   ::: {.avatar}
    [![avatar](http://itbuben.org//templates/skin/itbuben/images/avatar_24x24.jpg){.avatar}](http://itbuben.org/profile/KinoPoiskHD/)
    :::

    ::: {.info}
    [KinoPoiskHD](http://itbuben.org/profile/KinoPoiskHD/){.stream-author} →
    []{.stream-comment-icon}[Мачо и ботан 2 смотреть онлайн \#в хорошем
    качестве\#](http://itbuben.org/blog/8343.html#comment29966){.stream-comment}
    2 в [Личный блог:
    densektor](http://itbuben.org/my/densektor/){.stream-blog}
    :::
:::

::: {.right}
[Весь эфир](http://itbuben.org/comments/) \|
[RSS](http://itbuben.org/rss/allcomments/)
:::
:::
:::
:::
:::
:::
:::
:::
:::
:::
:::
:::

::: {.block .blogs}
::: {.box}
::: {.border-top}
::: {.border-right}
::: {.border-bot}
::: {.border-left}
::: {.left-top-corner}
::: {.right-top-corner}
::: {.right-bot-corner}
::: {.left-bot-corner}
::: {.inner}
Сообщества ↓
============

-   [Топ](#){#block_blogs_top}

::: {.block-content}
-   ::: {.avatar}
    ![avatar](http://itbuben.org/uploads/images/00/00/01/2013/09/26/avatar_blog_Unix-way_24x24.jpg){.avatar}
    :::

    ::: {.total}
    73.19
    :::

    ::: {.name}
    [Unix-way](http://itbuben.org/blog/Unix-way/){.stream-author}
    :::

-   ::: {.avatar}
    ![avatar](http://itbuben.org/uploads/images/00/00/02/2011/03/09/avatar_blog_question_24x24.jpg){.avatar}
    :::

    ::: {.total}
    72.39
    :::

    ::: {.name}
    [Есть вопрос](http://itbuben.org/blog/question/){.stream-author}
    :::

-   ::: {.avatar}
    ![avatar](http://itbuben.org/uploads/images/00/00/04/2011/03/28/avatar_blog_beza_24x24.png){.avatar}
    :::

    ::: {.total}
    55.44
    :::

    ::: {.name}
    [Безопасность](http://itbuben.org/blog/beza/){.stream-author}
    :::

-   ::: {.avatar}
    ![avatar](http://itbuben.org/uploads/images/00/00/01/2013/09/26/avatar_blog_Windows_24x24.png){.avatar}
    :::

    ::: {.total}
    53.49
    :::

    ::: {.name}
    [Windows](http://itbuben.org/blog/Windows/){.stream-author}
    :::

-   ::: {.avatar}
    ![avatar](http://itbuben.org/uploads/images/00/00/17/2013/09/26/avatar_blog_humor_24x24.png){.avatar}
    :::

    ::: {.total}
    41.17
    :::

    ::: {.name}
    [Юмор](http://itbuben.org/blog/humor/){.stream-author}
    :::

-   ::: {.avatar}
    ![avatar](http://itbuben.org/uploads/images/00/00/90/2011/05/08/avatar_blog_mobile_zone_24x24.png){.avatar}
    :::

    ::: {.total}
    41.14
    :::

    ::: {.name}
    [Mobile Zone](http://itbuben.org/blog/mobile_zone/){.stream-author}
    :::

-   ::: {.avatar}
    ![avatar](http://itbuben.org/uploads/images/00/00/04/2011/03/28/avatar_blog_iron_24x24.png){.avatar}
    :::

    ::: {.total}
    38.19
    :::

    ::: {.name}
    [Железо](http://itbuben.org/blog/iron/){.stream-author}
    :::

-   ::: {.avatar}
    ![avatar](http://itbuben.org/uploads/images/00/00/17/2013/09/26/avatar_blog_software_24x24.png){.avatar}
    :::

    ::: {.total}
    36.69
    :::

    ::: {.name}
    [Soft](http://itbuben.org/blog/software/){.stream-author}
    :::

-   ::: {.avatar}
    ![avatar](http://itbuben.org/uploads/images/00/00/08/2011/01/09/avatar_blog_Programming_24x24.png){.avatar}
    :::

    ::: {.total}
    34.32
    :::

    ::: {.name}
    [Программирование](http://itbuben.org/blog/Programming/){.stream-author}
    :::

-   ::: {.avatar}
    ![avatar](http://itbuben.org/uploads/images/00/00/02/2013/09/26/avatar_blog_internet_24x24.png){.avatar}
    :::

    ::: {.total}
    34.02
    :::

    ::: {.name}
    [Интернет](http://itbuben.org/blog/internet/){.stream-author}
    :::
:::

::: {.right}
[Все сообщества](http://itbuben.org/blogs/)
:::
:::
:::
:::
:::
:::
:::
:::
:::
:::
:::
:::
:::
:::

::: {#footer}
::: {.footerrt}
-   [![©
    itbuben.org](http://itbuben.org//templates/skin/itbuben/images/logo-bot.png)](http://itbuben.org/)
-   [![](http://itbuben.org//templates/skin/itbuben/images/copyright.png)](http://livestreetcms.com/)
:::

::: {.footerlt}
<div>

<div>

-   --- [Зарегистрироваться](http://itbuben.org/registration/)
-   --- [Войти](http://itbuben.org/login/)

</div>

<div>

### 0.0.3. Разделы

-   --- [Главная](http://itbuben.org/)
-   --- [Люди](http://itbuben.org/people/)
-   --- [](http://itbuben.org/page/about/)
-   --- [](http://itbuben.org/page/regulations/)
-   --- [](http://itbuben.org/page/help/)

</div>

<div>

### 0.0.4. Блоги

-   --- [Сообщества](http://itbuben.org/blogs/)
-   --- [Личные блоги](http://itbuben.org/personal_blog/)
-   --- [Лучшие](http://itbuben.org/top/)

</div>

<div>

### 0.0.5. Информация

-   --- [Администрация](http://itbuben.org//blog/administration/)
-   --- [Twitter](http://twitter.com/ITbuben)
-   --- [RSS](http://itbuben.org//page/rss/)
-   --- [Друзья](http://itbuben.org/page/friends/)

</div>

</div>
:::
:::

<div>

[](#header){#gotop .gotop}

</div>
:::

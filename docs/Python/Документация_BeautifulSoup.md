# Документация Beautiful Soup

!["Лакей Карась начал с того, что вытащил из-под мышки огромный конверт (чуть ли не больше его самого)."](https://www.crummy.com/software/BeautifulSoup/bs4/doc.ru/_images/6.1.jpg)

# Быстрый старт

Вот HTML-документ, который я буду использовать в качестве примера в этой документации. Это фрагмент из «Алисы в стране чудес»:

```html
html_doc = """
<html><head><title>The Dormouse's story</title></head>
<body>
<p class="title"><b>The Dormouse's story</b></p>

<p class="story">Once upon a time there were three little sisters; and their names were
<a href="http://example.com/elsie" class="sister" id="link1">Elsie</a>,
<a href="http://example.com/lacie" class="sister" id="link2">Lacie</a> and
<a href="http://example.com/tillie" class="sister" id="link3">Tillie</a>;
and they lived at the bottom of a well.</p>

<p class="story">...</p>
"""
```

Прогон документа через `Beautiful Soup` дает нам объект `BeautifulSoup`, который представляет документ в виде вложенной структуры данных:

```shell
from bs4 import BeautifulSoup
soup = BeautifulSoup (html_doc, 'html.parser')

print(soup.prettify())
```

Вот несколько простых способов навигации по этой структуре данных:

```shell
soup.title
```
```shell
soup.title.name
```
```shell
soup.title.string
```
```shell
soup.title.parent.name
```
```shell
soup.p
```
```shell
soup.p['class']
```
```shell
soup.a
```
```shell
soup.find_all('a')
```
```shell
soup.find(id="link3")
```

Одна из распространенных задач — извлечь все URL-адреса, найденные на странице в тегах <a>:

```shell
for link in soup.find_all('a'):
    print(link.get('href'))
```

Другая распространенная задача — извлечь весь текст со страницы:

```shell
print(soup.get_text())
```

Это похоже на то, что вам нужно? Если да, продолжайте читать.

## Установка парсера

Beautiful Soup поддерживает парсер HTML, включенный в стандартную библиотеку Python, а также ряд сторонних парсеров на Python. Одним из них является [парсер lxml](http://lxml.de/). В зависимости от ваших настроек, вы можете установить lxml с помощью одной из следующих команд:
```shell
apt-get install python-lxml
```
```shell
easy_install lxml
```
```shell
pip install lxml
```
Другая альтернатива — написанный исключительно на Python [парсер html5lib](http://code.google.com/p/html5lib/), который разбирает HTML таким же образом, как это делает веб-браузер. В зависимости от ваших настроек, вы можете установить **html5lib** с помощью одной из этих команд:
```shell
apt-get install python-html5lib
```
```shell
easy_install html5lib
```
```shell
pip install html5lib
```

# Приготовление супа

Чтобы разобрать документ, передайте его в конструктор `BeautifulSoup`. Вы можете передать строку или открытый дескриптор файла:

```python
from bs4 import BeautifulSoup

with open("index.html") as fp:
    soup = BeautifulSoup(fp)

soup = BeautifulSoup("<html>data</html>")
```

Первым делом документ конвертируется в Unicode, а HTML-мнемоники конвертируются в символы Unicode:

```python
BeautifulSoup("Sacr&eacute; bleu!")
<html><head></head><body>Sacré bleu!</body></html>
```

Затем Beautiful Soup анализирует документ, используя лучший из доступных парсеров. Библиотека будет использовать HTML-парсер, если вы явно не укажете, что нужно использовать XML-парсер. (См. [Разбор XML](https://www.crummy.com/software/BeautifulSoup/bs4/doc.ru/bs4ru.html#xml).)

## Проход сверху вниз

Теги могут содержать строки и другие теги. Эти элементы являются дочерними (children) для тега. Beautiful Soup предоставляет множество различных атрибутов для навигации и перебора дочерних элементов.

Обратите внимание, что строки Beautiful Soup не поддерживают ни один из этих атрибутов, потому что строка не может иметь дочерних элементов.

### Навигация с использованием имен тегов

Самый простой способ навигации по дереву разбора — это указать имя тега, который вам нужен. Если вы хотите получить тег <head>, просто напишите `soup.head`:

```python
soup.head
# <head><title>The Dormouse's story</title></head>

soup.title
# <title>The Dormouse's story</title>
```

Вы можете повторять этот трюк многократно, чтобы подробнее рассмотреть определенную часть дерева разбора. Следующий код извлекает первый тег <b> внутри тега <body>:

```python
soup.body.b
# <b>The Dormouse's story</b>
```

Использование имени тега в качестве атрибута даст вам только первый тег с таким именем:

```python
soup.a
# <a class="sister" href="http://example.com/elsie" id="link1">Elsie</a>
```

Если вам нужно получить все теги <a> или что-нибудь более сложное, чем первый тег с определенным именем, вам нужно использовать один из методов, описанных в разделе [Поиск по дереву](https://www.crummy.com/software/BeautifulSoup/bs4/doc.ru/bs4ru.html#id27), такой как find_all():

```python
soup.find_all('a')
# [<a class="sister" href="http://example.com/elsie" id="link1">Elsie</a>,
#  <a class="sister" href="http://example.com/lacie" id="link2">Lacie</a>,
#  <a class="sister" href="http://example.com/tillie" id="link3">Tillie</a>]
```

### `.contents` и `.children`

Дочерние элементы доступны в списке под названием `.contents`:

```python
head_tag = soup.head
head_tag
# <head><title>The Dormouse's story</title></head>

head_tag.contents
[<title>The Dormouse's story</title>]

title_tag = head_tag.contents[0]
title_tag
# <title>The Dormouse's story</title>
title_tag.contents
# [u'The Dormouse's story']
```

Сам объект `BeautifulSoup` имеет дочерние элементы. В этом случае тег <html> является дочерним для объекта `BeautifulSoup`:

```python
len(soup.contents)
# 1
soup.contents[0].name
# u'html'
```

У строки нет `.contents`, потому что она не может содержать ничего:

```python
text = title_tag.contents[0]
text.contents
# AttributeError: У объекта 'NavigableString' нет атрибута 'contents'
```

Вместо того, чтобы получать дочерние элементы в виде списка, вы можете перебирать их с помощью генератора `.children`:

```python
for child in title_tag.children:
    print(child)
# The Dormouse's story
```

### `.descendants`

Атрибуты `.contents` и `.children` применяются только в отношении непосредственных дочерних элементов тега. Например, тег <head> имеет только один непосредственный дочерний тег <title>:

```python
head_tag.contents
# [<title>The Dormouse's story</title>]
```

Но у самого тега <title> есть дочерний элемент: строка “The Dormouse’s story”. В некотором смысле эта строка также является дочерним элементом тега <head>. Атрибут `.descendants` позволяет перебирать все дочерние элементы тега рекурсивно: его непосредственные дочерние элементы, дочерние элементы дочерних элементов и так далее:

```python
for child in head_tag.descendants:
    print(child)
# <title>The Dormouse's story</title>
# The Dormouse's story
```

У тега <head> есть только один дочерний элемент, но при этом у него два потомка: тег <title> и его дочерний элемент. У объекта `BeautifulSoup` только один прямой дочерний элемент (тег <html>), зато множество потомков:

```python
len(list(soup.children))
# 1
len(list(soup.descendants))
# 25
```



### `.string`

Если у тега есть только один дочерний элемент, и это `NavigableString`, его можно получить через `.string`:

```python
title_tag.string
# u'The Dormouse's story'
```

Если единственным дочерним элементом тега является другой тег, и у этого другого тега есть строка `.string`, то считается, что родительский тег содержит ту же строку `.string`, что и дочерний тег:

```python
head_tag.contents
# [<title>The Dormouse's story</title>]

head_tag.string
# u'The Dormouse's story'
```

Если тег содержит больше чем один элемент, то становится неясным, какая из строк `.string` относится и к родительскому тегу, поэтому `.string` родительского тега имеет значение `None`:

```python
print(soup.html.string)
# None
```



### `.strings` и `.stripped_strings`

Если внутри тега есть более одного элемента, вы все равно можете посмотреть только на строки. Используйте генератор `.strings`:

```python
for string in soup.strings:
    print(repr(string))
# u"The Dormouse's story"
# u'\n\n'
# u"The Dormouse's story"
# u'\n\n'
# u'Once upon a time there were three little sisters; and their names were\n'
# u'Elsie'
# u',\n'
# u'Lacie'
# u' and\n'
# u'Tillie'
# u';\nand they lived at the bottom of a well.'
# u'\n\n'
# u'...'
# u'\n'
```

В этих строках много лишних пробелов, которые вы можете удалить, используя генератор `.stripped_strings`:

```python
for string in soup.stripped_strings:
    print(repr(string))
# u"The Dormouse's story"
# u"The Dormouse's story"
# u'Once upon a time there were three little sisters; and their names were'
# u'Elsie'
# u','
# u'Lacie'
# u'and'
# u'Tillie'
# u';\nand they lived at the bottom of a well.'
# u'...'
```

Здесь строки, состоящие исключительно из пробелов, игнорируются, а пробелы в начале и конце строк удаляются.


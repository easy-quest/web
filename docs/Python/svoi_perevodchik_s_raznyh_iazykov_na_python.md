---
created: 2021-11-07T03:01:41 (UTC +03:00)
source: https://zen.yandex.ru/media/id/5cab3ea044061700afead675/svoi-perevodchik-s-raznyh-iazykov-na-python-5f857a928e35355ad1852a60
author: Ivan Yastrebov
---

---

## Сегодня мы напишем свой консольный переводчик с разных языков на Python

![pythontoday](https://avatars.mds.yandex.net/get-zen_doc/2262910/pub_5f857a928e35355ad1852a60_5f85807701c3532acce3d590/scale_1200)


Первым делом устанавливаем необходимую библиотеку:

```shell
pip install translate
```

Импортируем модуль в исполняемый файл:

```python
from translate import Translator
```

Создаём объект класса переводчика:

```python
translator = Translator()
```

Который принимает два параметра. Первый **from_lang** язык с которого мы переводим и соответственно **to_lang** язык на который переводим текст:

```python
translator = Translator(from_lang="Russian",to_lang="English")
```

Сохраним результат в переменную **result**:

```python
result = translator.translate("Привет мой друг")
```

И распечатаем результат:

```python
print(result)
```

Конечно в качестве параметров мы можем передавать множество разных языков а не только **Ru** и **En**.



![pythontoday](https://avatars.mds.yandex.net/get-zen_doc/1889318/pub_5f857a928e35355ad1852a60_5f857cfaa144c35a270943dd/scale_1200)

`###### tags: []`
# vncviewer

> Запускает клиент VNC (виртуальные сетевые вычисления).

- Запустите клиент VNC, который подключается к хосту на заданном дисплее:

`vncviewer {{host}}:{{display_number}}`

- Запускаем в полноэкранном режиме:

`vncviewer -FullScreen {{host}}:{{display_number}}`

- Запустите клиент VNC с определенной геометрией экрана:

`vncviewer --geometry {{width}}x{{height}} {{host}}:{{display_number}}`

- Запустите клиент VNC, который подключается к хосту на заданном порту:

`vncviewer {{host}}::{{port}}`

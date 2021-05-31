# vncserver

> Запускает рабочий стол VNC (виртуальные сетевые вычисления)..

- Запустите VNC-сервер на следующем доступном экране:

```
vncserver
```

- Запустите VNC-сервер с определенной геометрией экрана:

```
vncserver --geometry {{width}}x{{height}}
```

- Убейте экземпляр VNC Server, запущенный на определенном дисплее:

```
vncserver --kill :{{display_number}}
```{}
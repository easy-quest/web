# Установка и использование удаленного рабочего стола Guacamole в Ubuntu 20.04

 

Удобство наличия единого места для доступа к вашим серверам – это то, о чем большинство администраторов может подумать о том, чтобы есть в своем основном блюдо каждый божий день. Чтобы удовлетворить эту потребность, в этом руководстве подробно рассказывается о настройке одной такой платформы. К концу этого руководства у нас должен быть установлен рабочий сервер Apache Guacamole, который можно использовать для предоставления одного места для доступа ко всем вашим серверам. Будь то Windows или Linux, Apache Guacamole здесь для вас.

Прежде чем углубиться в суть этого инструмента, было бы хорошо, если бы мы знали, в чем дело? Хорошо, давайте продолжим и демистифицируем этот инструмент. Apache Guacamole – это бесклиентский шлюз удаленного рабочего стола, поддерживающий стандартные протоколы, такие как *VNC, RDP и SSH. Благодаря HTML5* , когда Guacamole установлен на сервере, все, что вам нужно для доступа к своим рабочим столам, – это веб-браузер.Guacamole разделен на две части: guacamole-server, который предоставляет *прокси* -сервер *guacd* и связанные библиотеки, и guacamole-client, который предоставляет клиента для обслуживания вашим контейнером сервлетов. В большинстве случаев единственный источник, который вам нужно будет собрать, – это guacamole-server, и загрузки последней версии *guacamole.war* с веб-сайта проекта будет достаточно, чтобы предоставить клиенту.

## Шаг 1: Подготовка сервера

Apache Guacamole имеет множество зависимостей, и на этом этапе мы разберемся с большинством из них. Давайте продвинемся вперед и установим все зависимости, которые потребуются нашему серверу Guacamole, чтобы дышать и жить. Установите их все следующим образом:

```
sudo apt update
sudo apt install -y gcc vim curl wget g++ libcairo2-dev libjpeg-turbo8-dev libpng-dev \
libtool-bin libossp-uuid-dev libavcodec-dev libavutil-dev libswscale-dev build-essential \
libpango1.0-dev libssh2-1-dev libvncserver-dev libtelnet-dev \
libssl-dev libvorbis-dev libwebp-dev
```

### Установить FreeRDP2

Мы собираемся установить версию FreeRDP2, размещенную в remmina PPA, следующим образом:

```
sudo add-apt-repository ppa:remmina-ppa-team/freerdp-daily
sudo apt update
sudo apt install freerdp2-dev freerdp2-x11 -y
```



После того, как все предварительные условия выполнены, теперь у нас есть возможность приготовить основное блюдо, которое включает в себя еще пару шагов, которые мы рассмотрим далее.

## Шаг 2. Установите Apache Tomcat

На этом этапе мы собираемся установить контейнер сервлетов Java Apache Tomcat, который будет запускать военный файл Java Guacamole и, таким образом, обслуживать Java-клиент Guacamole. Поскольку он находится на Java, нам нужно сначала установить Java.

```
sudo apt install openjdk-11-jdk
```

Как только он будет установлен, вы можете проверить установленную версию

```
$ java --version

openjdk 11.0.9.1 2020-11-04
OpenJDK Runtime Environment (build 11.0.9.1+1-Ubuntu-0ubuntu1.20.04)
OpenJDK 64-Bit Server VM (build 11.0.9.1+1-Ubuntu-0ubuntu1.20.04, mixed mode, sharing)
```

### Создать пользователя системы Tomcat

Рекомендуется, чтобы для запуска приложений использовался пользователь в системе, кроме root. Для tomcat мы собираемся создать пользователя, который будет использоваться для запуска приложения tomcat.

```
sudo useradd -m -U -d /opt/tomcat -s /bin/false tomcat
```

### Получить Apache Tomcat

Вы можете получить двоичный дистрибутив Apache Tomcat на [официальной странице загрузок Tomcat](https://tomcat.apache.org/download-90.cgi) . На момент написания этого руководства последней стабильной версией была 9.0.41.

```
wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.41/bin/apache-tomcat-9.0.41.tar.gz -P ~
```



Загрузка будет завершена, и вы приступите к извлечению tar-файла в каталог /opt/tomcat следующим образом:



```
sudo mkdir /opt/tomcat
sudo tar -xzf apache-tomcat-9.0.41.tar.gz -C /opt/tomcat/
sudo mv /opt/tomcat/apache-tomcat-9.0.41 /opt/tomcat/tomcatapp
```

Поскольку пользователь tomcat будет запускать Apache Tomcat, нам нужно будет предоставить ему необходимые права на каталог / opt / tomcat. Выполните команду ниже, чтобы это произошло

```
sudo chown -R tomcat: /opt/tomcat
```

Затем сделайте все сценарии оболочки в каталоге /opt/tomcat/tomcatapp/bin исполняемыми

```
sudo chmod +x /opt/tomcat/tomcatapp/bin/*.sh
```

Затем мы готовы добавить службу Tomcat Systemd, чтобы мы могли легко запускать и останавливать ее, как и другие службы на вашем сервере. Для этого нам нужно будет создать новый файл, а затем заполнить его правильной конфигурацией, как показано ниже.

```
$ sudo vim /etc/systemd/system/tomcat.service

[Unit]
Description=Tomcat 9 servlet container
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

Environment="JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom -Djava.awt.headless=true"

Environment="CATALINA_BASE=/opt/tomcat/tomcatapp"
Environment="CATALINA_HOME=/opt/tomcat/tomcatapp"
Environment="CATALINA_PID=/opt/tomcat/tomcatapp/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=/opt/tomcat/tomcatapp/bin/startup.sh
ExecStop=/opt/tomcat/tomcatapp/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
```



Наш новый файл systemd чистый. Сохраните его, затем перезагрузите демон, чтобы демон SystemD прочитал его.

```
sudo systemctl daemon-reload
```

Затем запустите службу

```
sudo systemctl enable --now tomcat
```

И кот должен бежать счастливо

```
$ systemctl status tomcat

● tomcat.service - Tomcat 9 servlet container
     Loaded: loaded (/etc/systemd/system/tomcat.service; enabled; vendor preset: enabled)
     Active: active (running) since Fri 2020-12-18 13:36:34 UTC; 2s ago
    Process: 53538 ExecStart=/opt/tomcat/tomcatapp/bin/startup.sh (code=exited, status=0/SUCCESS)
   Main PID: 53545 (java)
      Tasks: 27 (limit: 2204)
     Memory: 137.3M
     CGroup: /system.slice/tomcat.service
             └─53545 /usr/lib/jvm/java-11-openjdk-amd64/bin/java -Djava.util.logging.config.file=/opt/tomcat/to
```

Tomcat по умолчанию прослушивает порт 8080, и, как вы можете догадаться, нам нужно разрешить доступ к приложению удаленно, разрешив порт на брандмауэре. Это так же просто, как однострочная команда, как показано ниже:

```
sudo ufw allow 8080/tcp
```

## Шаг 3. Создайте сервер Guacamole из исходников

guacamole-server содержит все встроенные серверные компоненты, необходимые Guacamole для подключения к удаленным рабочим столам. Он предоставляет общую библиотеку C, *libguac* , от которой зависят все остальные собственные компоненты, а также отдельные библиотеки для каждого поддерживаемого протокола и *прокси-демон, guacd,* сердце Guacamole.

Загрузите [последнюю стабильную версию guacamole-server](https://downloads.apache.org/guacamole)



```
wget http://mirror.cc.columbia.edu/pub/software/apache/guacamole/1.2.0/source/guacamole-server-1.2.0.tar.gz -P ~
```

Распакуйте архив с исходным кодом после загрузки

```
tar xzf ~/guacamole-server-1.2.0.tar.gz
```

Перейдите в каталог исходного кода сервера гуакамоле;

```
cd ~/guacamole-server-1.2.0
```

Затем выполните сценарий настройки, чтобы проверить, нет ли какой-либо необходимой зависимости, и адаптировать сервер Guacamole к вашей системе.

```
./configure --with-init-dir=/etc/init.d
```

Приведенная выше команда приведет к длинной струйке выходных данных. Когда он закончится, вы должны увидеть следующий результат, в котором должно быть положено следующее: RDP, SSH, Telnet и VNC.

```
guacamole-server version 1.2.0
------------------------------------------------

   Library status:

     freerdp2 ............ yes
     pango ............... yes
     libavcodec .......... yes
     libavformat.......... no
     libavutil ........... yes
     libssh2 ............. yes
     libssl .............. yes
     libswscale .......... yes
     libtelnet ........... yes
     libVNCServer ........ yes
     libvorbis ........... yes
     libpulse ............ no
     libwebsockets ....... no
     libwebp ............. yes
     wsock32 ............. no

   Protocol support:

      Kubernetes .... no
      RDP ........... yes
      SSH ........... yes
      Telnet ........ yes
      VNC ........... yes

   Services / tools:

      guacd ...... yes
      guacenc .... no
      guaclog .... yes

   FreeRDP plugins: /usr/lib/x86_64-linux-gnu/freerdp2
   Init scripts: /etc/init.d
   Systemd units: no

Type "make" to compile guacamole-server.
```



После этого просто запустите команду make, как указано в последнем сообщении.

```
make
```

Дайте ему немного времени, пока он сделает свое дело. По завершении установите сервер гуакамоле следующим образом

```
sudo make install
```

Чтобы завершить все это, запустите команду *ldconfig,* чтобы создать необходимые ссылки и кэшировать самые последние общие библиотеки, найденные в каталоге сервера guacamole.

```
sudo ldconfig
```

Обновите systemd, чтобы он нашел службу guacd (прокси-демон Guacamole), установленную в каталоге */etc/init.d/* .

```
sudo systemctl daemon-reload
```

После перезагрузки запустите и включите службу guacd.

```
sudo systemctl start guacd
sudo systemctl enable guacd
```

И чтобы такое настроение появилось на турбо-лифте, проверьте его состояние.

```
$ systemctl status guacd

● guacd.service - LSB: Guacamole proxy daemon
     Loaded: loaded (/etc/init.d/guacd; generated)
     Active: active (running) since Fri 2020-12-18 14:03:06 UTC; 8s ago
       Docs: man:systemd-sysv-generator(8)
    Process: 76312 ExecStart=/etc/init.d/guacd start (code=exited, status=0/SUCCESS)
      Tasks: 1 (limit: 2204)
     Memory: 10.1M
     CGroup: /system.slice/guacd.service
             └─76324 /usr/local/sbin/guacd -p /var/run/guacd.pid
```

## Шаг 4. Установите веб-приложение Guacamole

В развертывании Guacamole задействованы два важных файла: *guacamole.war* – файл, содержащий веб-приложение, и *guacamole.properties* – основной файл конфигурации для Guacamole. Рекомендуемый способ настройки Guacamole включает размещение этих файлов в стандартных местах с последующим созданием на них символических ссылок, чтобы Tomcat мог их найти.

guacamole-client содержит все компоненты Guacamole Java и Maven ( *guacamole, guacamole-common, guacamole-ext и guacamole-common-js* ). Эти компоненты в конечном итоге составляют веб-приложение, которое будет обслуживать клиент HTML5 Guacamole для пользователей, которые подключаются к вашему серверу. Это веб-приложение будет подключаться к *guacd* , части сервера guacamole, от имени подключенных пользователей, чтобы обслуживать их любой удаленный рабочий стол, к *которому* они имеют доступ.

### Установите клиент Guacamole в Ubuntu 20.04

Клиент Guacamole доступен в виде двоичного файла. Чтобы установить его, просто вытащите его со страницы загрузки двоичных файлов Guacamole, как показано ниже, скопируйте его в каталог */etc/guacamole/* и одновременно переименуйте.

```
sudo mkdir /etc/guacamole
wget https://downloads.apache.org/guacamole/1.2.0/binary/guacamole-1.2.0.war -P ~
sudo mv ~/guacamole-1.2.0.war /etc/guacamole/guacamole.war
```

Чтобы установить двоичный файл клиента Guacamole, создайте символическую ссылку клиента Guacamole на каталог веб-приложений Tomcat, как показано ниже;

```
sudo ln -s /etc/guacamole/guacamole.war /opt/tomcat/tomcatapp/webapps
```

## Шаг 5: Настройте сервер Guacamole

После установки демона сервера Guacamole вам необходимо определить, как клиент Guacamole будет подключаться к серверу Guacamole (guacd) в *файле* конфигурации */etc/guacamole/guacamole.properties* . В этой конфигурации вам нужно просто определить имя хоста сервера Guacamole, порт, файл конфигурации сопоставления пользователей, поставщика аутентификации.

*GUACAMOLE_HOME* – это имя, присвоенное каталогу конфигурации Guacamole, который по умолчанию находится в */etc/guacamole* . Все файлы конфигурации, расширения и т. Находятся в этом каталоге.

Создать переменную среды *GUACAMOLE_HOME*

```
echo "GUACAMOLE_HOME=/etc/guacamole" | sudo tee -a /etc/default/tomcat
```

Создайте *файл* конфигурации */etc/guacamole/guacamole.properties* и заполните его, как показано ниже:

```
$ sudo vim /etc/guacamole/guacamole.properties
guacd-hostname: localhost
guacd-port:    4822
user-mapping:    /etc/guacamole/user-mapping.xml
auth-provider:    net.sourceforge.guacamole.net.basic.BasicFileAuthenticationProvider
```

После того, как конфигурация станет такой же красивой, как указано выше, сохраните ее и свяжите каталог конфигураций Guacamole с каталогом сервлетов Tomcat, как показано ниже.

```
sudo ln -s /etc/guacamole /opt/tomcat/tomcatapp/.guacamole
```

## Шаг 6. Настройте метод аутентификации гуакамоле.

Метод проверки подлинности Гуакамоле по умолчанию считывает всех пользователей и подключения из одного файла с именем *user-mapping.xml* . В этом файле вам необходимо определить пользователей, которым разрешен доступ к веб-интерфейсу Guacamole, серверы для подключения и метод подключения.

Сгенерируйте MD5-хэш паролей для пользователя, которого вы собираетесь использовать для входа в веб-интерфейс пользователя Guacamole. Соответственно замените свой пароль.

```
$ echo -n StrongPassword | openssl md5
(stdin)= 0f6e4a1df0cf5ee97c2066953bed21b2
```

Когда ваш пароль будет готов, создайте файл сопоставления пользователей с примерами содержимого, показанными ниже. Вы можете разместить любое имя хоста, имена пользователей и хосты в соответствии с вашей средой.

```
$ sudo vim /etc/guacamole/user-mapping.xml

<user-mapping>

    <!-- Per-user authentication and config information -->

    <!-- A user using md5 to hash the password
         guacadmin user and its md5 hashed password below is used to 
             login to Guacamole Web UI-->
    <authorize 
            username="GeeksAdmin"
            password="0f6e4a1df0cf5ee97c2066953bed21b2"
            encoding="md5">

        <!-- First authorized Remote connection -->
        <connection name="RHEL 7 Maipo">
            <protocol>ssh</protocol>
            <param name="hostname">172.25.169.26</param>
            <param name="port">22</param>
        </connection>

        <!-- Second authorized remote connection -->
        <connection name="Windows Server 2019">
            <protocol>rdp</protocol>
            <param name="hostname">10.10.10.5</param>
            <param name="port">3389</param>
            <param name="username">tech</param>
            <param name="ignore-cert">true</param>
        </connection>

    </authorize>

</user-mapping>
```

Мы продвигаемся очень хорошо. Как только все будет сделано, перезапустите Tomcat и *guacd,* чтобы изменения вступили в силу.

```
sudo systemctl restart tomcat guacd
```

Если у вас запущен брандмауэр и вы еще не разрешили порты, у вас есть шанс сделать это так же быстро, как показано ниже:

```
sudo ufw allow 4822/tcp
```

## Шаг 7. Получение веб-интерфейса Guacamole

Пока мы все настроили хорошо, и поэтому мы должны быть готовы получить доступ к приложению, над созданием которого мы так долго работали. Чтобы получить доступ к веб-интерфейсу Guacamole, просто укажите в браузере *http://ip-or-domain-name: 8080/ guacamole,* и вы увидите экран входа в систему, как показано ниже:

[![Установка и использование удаленного рабочего стола Guacamole в Ubuntu 20.04](https://infoit.com.ua/wp-content/uploads/2021/05/%D0%A3%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B0-%D0%B8-%D0%B8%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-%D1%83%D0%B4%D0%B0%D0%BB%D0%B5%D0%BD%D0%BD%D0%BE%D0%B3%D0%BE-%D1%80%D0%B0%D0%B1%D0%BE%D1%87%D0%B5%D0%B3%D0%BE-%D1%81%D1%82%D0%BE%D0%BB%D0%B0-Guacamole-%D0%B2-Ubuntu-20.04-300x263.png)](https://infoit.com.ua/wp-content/uploads/2021/05/Установка-и-использование-удаленного-рабочего-стола-Guacamole-в-Ubuntu-20.04.png)

Как видите, подключения, которые мы установили в файле конфигурации, то есть имена серверов, уже загружаются при входе в систему.

[![Установка и использование удаленного рабочего стола Guacamole в Ubuntu 20.04](https://infoit.com.ua/wp-content/uploads/2021/05/%D0%A3%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B0-%D0%B8-%D0%B8%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-%D1%83%D0%B4%D0%B0%D0%BB%D0%B5%D0%BD%D0%BD%D0%BE%D0%B3%D0%BE-%D1%80%D0%B0%D0%B1%D0%BE%D1%87%D0%B5%D0%B3%D0%BE-%D1%81%D1%82%D0%BE%D0%BB%D0%B0-Guacamole-%D0%B2-Ubuntu-20.04-1-300x141.png)](https://infoit.com.ua/wp-content/uploads/2021/05/Установка-и-использование-удаленного-рабочего-стола-Guacamole-в-Ubuntu-20.04-1.png)

Просто нажмите на тот, к которому вы хотите подключиться, и вам будет предложено ввести имя пользователя и пароль, будь то через SSH или RDP, в зависимости от операционной системы.

И если учетные данные верны, вы должны быть допущены на свой сервер

## [![Установка и использование удаленного рабочего стола Guacamole в Ubuntu 20.04](https://infoit.com.ua/wp-content/uploads/2021/05/%D0%A3%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B0-%D0%B8-%D0%B8%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-%D1%83%D0%B4%D0%B0%D0%BB%D0%B5%D0%BD%D0%BD%D0%BE%D0%B3%D0%BE-%D1%80%D0%B0%D0%B1%D0%BE%D1%87%D0%B5%D0%B3%D0%BE-%D1%81%D1%82%D0%BE%D0%BB%D0%B0-Guacamole-%D0%B2-Ubuntu-20.04-2-300x68.png)](https://infoit.com.ua/wp-content/uploads/2021/05/Установка-и-использование-удаленного-рабочего-стола-Guacamole-в-Ubuntu-20.04-2.png)

## Заключение

Организуйте свою среду и сделайте ее простой в использовании даже для новых пользователей в вашей среде, воспользовавшись преимуществами Apache Guacamole для использования его интересных функций, как вы увидите после установки. Оцените его и воспользуйтесь его гибкостью и удобством, особенно в этот сезон, когда большинство из нас сохранят воспоминания о тех, кто нам небезразличен.
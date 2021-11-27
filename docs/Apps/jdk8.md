---
created: 2021-11-04T20:33:00 (UTC +03:00)
source: https://docs.aidlux.com//#/configuration?id=c-opengl
author: Ivan Yastrebov
---

---
## [jdk-8](#/configuration?id=jdk-8)

Шаг 1, загрузите jdk1.8.0_291, который можно загрузить на официальном сайте java или в группе QQ.  
Шаг 2, распакуйте его в каталоге /opt

```shell
cd /opt
tar -zxvf jdk-8u291-linux-aarch64.tar 
```

Шаг 3. Настройка переменных среды  
Чтобы открыть файл конфигурации, вы можете использовать vim или документ.

```shell
vim /etc/profile
```

Вы также можете копировать, вставлять и сохранять vim с помощью Baidu или копировать, вставлять и сохранять его в документе.  
Добавить в конце файла：

```shell
vim /etc/profile
```

```shell
#set java env
export JAVA_HOME=/opt/jdk8
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH
```

Шаг 4. После изменения, сохранения и выхода используйте команду, чтобы конфигурация вступила в силу: источник/etc/профиль

```shell
source /etc/profile
```

Шаг 5: Проверьте, успешна ли конфигурация, введите команду: java-версия

```shell
java -version
```

Обычное отображение означает, что конфигурация выполнена успешно  
[. Адрес загрузки](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)  
[официального веб-сайта java не соответствует версии openjfx. Обратитесь к этой статье](https://bugs.launchpad.net/ubuntu/+source/openjfx/+bug/1799946)  

> Примечание: После выполнения source/etc/profile терминал не будет выделен. Просто повторите следующую команду.

```shell
source ~/.bashrc
```
`######tags: [jdk8]`
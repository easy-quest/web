# Python

```sh
pkg install python
```

```sh
pkg install python2
```

### Numpy and Scipy

```sh
curl -LO https://its-pointless.github.io/setup-pointless-repo.sh
bash setup-pointless-repo.sh
```

```sh
pkg install numpy
pkg install scipy
```

### OpenCV

```sh
pkg install build-essential cmake libjpeg-turbo libpng python
```

```sh
git clone https://github.com/opencv/opencv
cd opencv
```

```sh
mkdir build
cd build
```

```sh
LDFLAGS=" -llog -lpython3" cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=$PREFIX -DBUILD_opencv_python3=on -DBUILD_opencv_python2=off -DWITH_QT=OFF -DWITH_GTK=OFF ..
```

```sh
make
```

```sh
make install
```

### Tkinter

Tkinter is splitted of from the python package and can be installed by

```sh
pkg install python-tkinter
```

We do not provide Tkinter for Python v2.7.x.

Since Tkinter is a graphical library, it will work only if X Windows System environment is installed and running. How to do this, see page [Graphical Environment]().

### Installing Python modules from source

Некоторые модули невозможно установить без исправлений. Их следует устанавливать из исходного кода. Вот краткое руководство по установке модулей Python из исходного кода.

1. Получите исходный код. Вы можете клонировать репозиторий git вашего пакета:

```sh
git clone https://your-package-repo-url
cd ./your-package-repo
```

или загрузите исходный пакет с помощью pip:

```sh
pip download {module name}
unzip {module name}.zip
cd {module name}
```

2. При желании примените желаемые изменения к исходному коду. Универсальных руководств по этому поводу нет, проделайте этот шаг самостоятельно.

3. При желании исправить все шебанги. В этом нет необходимости, если termux-exec установлен и работает правильно.

```sh
find . -type f -not -path '*/\.*' -exec termux-fix-shebang "{}" \;
```

4. Наконец, установите пакет:

```sh
python setup.py install
```

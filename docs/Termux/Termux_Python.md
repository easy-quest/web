#  Python

```
pkg install python
```
```
pkg install python2
```

### Numpy and Scipy

```
curl -LO https://its-pointless.github.io/setup-pointless-repo.sh
bash setup-pointless-repo.sh
```
```
pkg install numpy
pkg install scipy
```

### OpenCV

```
pkg install build-essential cmake libjpeg-turbo libpng python
```
```
git clone https://github.com/opencv/opencv
cd opencv
```
```
mkdir build
cd build
```
```
LDFLAGS=" -llog -lpython3" cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=$PREFIX -DBUILD_opencv_python3=on -DBUILD_opencv_python2=off -DWITH_QT=OFF -DWITH_GTK=OFF ..
```
```
make
```
```
make install
```

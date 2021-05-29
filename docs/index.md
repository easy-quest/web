Welcome
=======

Python is an interpreted, high-level, general-purpose programming language. Created
by Guido van Rossum and first released in 1991, Python's design philosophy emphasizes
code readability with its notable use of significant whitespace. Its language constructs
and object-oriented approach aim to help programmers write clear, logical code for small
and large-scale projects.

In Termux Python v3.x can be installed by executing

 pkg install python

Legacy, deprecated version 2.7.x can be installed by

 pkg install python2

'''Warning''': upgrading major/minor version of Python package, for example from Python 3.8 to 3.9, will make all your currently installed modules unusable. You will need to reinstall them. However upgrading patch versions, for example from 3.8.1 to 3.8.2, is safe.

Note that Termux does not provide a way for downgrading. If you are not sure whether new Python version is appropriate for you, [[Backing up Termux|make a backup of $PREFIX]].

== Package management ==

After installing Python, <code>pip</code> (<code>pip2</code> if using python2) package
manager will be available. Here is a quick tutorial about its usage.

Installing a new Python module:

 pip install {module name}

Uninstalling Python module:

 pip uninstall {module name}

Listing installed modules:

 pip list

When installing Python modules, it is highly recommended to have a package
<code>build-essential</code> to be installed - some modules compile native extensions
during their installation.

== Python module installation tips and tricks ==

It is assumed that you have <code>build-essential</code> or at least <code>clang</code>,
<code>make</code> and <code>pkg-config</code> installed.

It also assumed that <code>termux-exec</code> is not broken and works on your device.
Environment variable <code>LD_PRELOAD</code> is not tampered or unset. Otherwise you
will need to patch modules' source code to fix all shebangs!

{| class="wikitable"
! style="text-align:left;"| Package
! Description
! Dependencies
! Special Instructions
|-
|electrum
|Lightweight Bitcoin wallet.<br>https://electrum.org/
|
|<code>pkg install unstable-repo</code><br><code>pkg install electrum</code>
|-
|gmpy2
|C-coded Python modules for fast multiple-precision arithmetic.<br>https://github.com/aleaxit/gmpy
|libgmp libmpc libmpfr
|
|-
|lxml
|Bindings to libxml2 and libxslt.<br>https://lxml.de/
|libxml2 libxslt
|
|-
|Numpy
|The fundamental package for scientific computing with Python
<br>https://numpy.org/
|
|<code>pip install numpy</code>
|-
|matplotlib
|A plotting library for Python.<br>https://matplotlib.org/
|freetype libpng
|On some devices a patch/config file is needed to get rid of the <code>-flto</code> flag passed to the compiler. If <code>pip install matplotlib</code> does not work, try 
<br><code>git clone https://github.com/matplotlib/matplotlib</code><br><code>cd matplotlib</code><br><code>sed 's@#enable_lto = True@enable_lto = False@g' setup.cfg.template > setup.cfg</code><br><code>pip install .</code>
|-
|pandas
|Flexible and powerful data analysis / manipulation library for Python.<br>https://pandas.pydata.org/
|
|<code>export CFLAGS="-Wno-deprecated-declarations -Wno-unreachable-code"</code><br><code>pip install pandas</code>
|-
|pynacl
|Bindings to the Networking and Cryptography library.<br>https://pypi.python.org/pypi/PyNaCl
|libsodium
|
|-
|pillow
|Python Imaging Library.<br>https://pillow.readthedocs.io/en/stable/
|libjpeg-turbo libpng
|
|-
|pyzmq
|Bindings to libzmq.<br>https://pyzmq.readthedocs.io/en/latest/
|libzmq
|
|}

=== Advanced installation instructions ===

Some Python modules may not be easy to install. Here are collected information on how to get
them available in your Termux.

==== Numpy and Scipy ====

Building complex software like numpy and scipy is tedious. Therefore, Termux user
[https://github.com/its-pointless its-pointless (aka live_the_dream)] has packaged
this software and maintain a Termux APT repository with these and many other useful
packages.

Before Numpy/Scipy installation, you need to subscribe to APT repository:
<pre>
curl -LO https://its-pointless.github.io/setup-pointless-repo.sh
bash setup-pointless-repo.sh
</pre>

Then you can install Numpy or Scipy like a regular Termux package:
<pre>
pkg install numpy
pkg install scipy
</pre>

==== OpenCV ====

Instructions taken from [https://github.com/termux/termux-packages/issues/512 #512]
and [https://github.com/termux/termux-packages/issues/1992 #1992]. OpenCV is not a
Python package but it includes the Python bindings (known as opencv-python in pip).

OpenCV needs to be built from source using CMake, install it and other dependencies
with:

 pkg install build-essential cmake libjpeg-turbo libpng python

Numpy is also required, see instructions for installing it above.

There might be other required dependecies as well, see the OpenCV
[https://docs.opencv.org/trunk/d7/d9f/tutorial_linux_install.html docs] for the list.

The rest of the instructions can be copy-pasted straight away, but if you are not sure
if you have all dependencies then it might be best to do it in two steps: first all
commands up until the <code>LDFLAGS=" -llog" cmake</code> command and then in a second
step make and make install.

To get the sources, git clone (from a suitable folder):
<pre>
git clone https://github.com/opencv/opencv
cd opencv
</pre>

You should now be in the opencv folder. Let's create a build folder where we will
build the package:
<pre>
mkdir build
cd build
</pre>

To configure the package for python3 but not python2 (change the on/off flags to
use python2 instead of python3) we run:
<pre>
LDFLAGS=" -llog -lpython3" cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=$PREFIX -DBUILD_opencv_python3=on -DBUILD_opencv_python2=off -DWITH_QT=OFF -DWITH_GTK=OFF ..
</pre>

Last command will throw errors if there are missing dependencies. After this we can
compile the package with
<pre>
make
</pre>
and then install the files with
<pre>
make install
</pre>

==== Tkinter ====

Tkinter is splitted of from the <code>python</code> package and can be installed by

 pkg install python-tkinter

We do not provide Tkinter for Python v2.7.x.

Since Tkinter is a graphical library, it will work only if X Windows System environment
is installed and running. How to do this, see page [[Graphical Environment]].

=== Installing Python modules from source ===

Some modules may not be installable without patching. They should be installed from
source code. Here is a quick how-to about installing Python modules from source code.

1. Obtain the source code. You can clone a git repository of your package:
<pre>
git clone https://your-package-repo-url
cd ./your-package-repo
</pre>
or download source bundle with <code>pip</code>:
<pre>
pip download {module name}
unzip {module name}.zip
cd {module name}
</pre>

2. Optionally, apply the desired changes to source code. There no universal guides on that,
perform this step on your own.

3. Optionally, fix the all shebangs. This is not needed if <code>termux-exec</code> is installed
and works correctly.
<pre>
find . -type f -not -path '*/\.*' -exec termux-fix-shebang "{}" \;
</pre>

4. Finally install the package:
<pre>
python setup.py install
</pre>

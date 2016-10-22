installing the cross development environment
============================================

Built on OSX 10.12, with some pushing it should build on any unix.

Notes: 
   * My /usr/local is writable by me. You will probable need to add "sudo" to any "make install" lines
   * You can probably install most of this stuff using a package system rather than building from sources

0. wget
    ```
# curl -O http://ftp.gnu.org/gnu/wget/wget-1.18.tar.xz
# tar zxfv wget-1.18.tar.xz
# cd wget-1.18
# ./configure --predix=/usr/local --without-ssl
# make -j4
# make install
```

1. gcc-6.2.0 for OSX
    ```
# svn checkout svn://gcc.gnu.org/svn/gcc/tags/gcc_6_2_0_release gcc-6.1.0-src
# cd gcc-6.2.0-src
# ./contrib/download_prerequisites
# cd ..
# mkdir gcc-6.2.0-build
# cd gcc-6.2.0-build
# ../gcc-6.2.0-src/configure --prefix=/usr/local --enable-languages=c,c++
# make -j4
# make install
```

2. The fantastic AmigaOS cross compiler for Linux / MacOSX / Windows 

   https://github.com/cahirwpz/amigaos-cross-toolchain

    ```
# git clone git://github.com/cahirwpz/amigaos-cross-toolchain.git
# cd amigaos-cross-toolchain
# ./toolchain-m68k --prefix=/usr/local/amiga build
```
   
3. autoconf
    ```
    # curl -OL http://ftpmirror.gnu.org/autoconf/autoconf-2.69.tar.gz
    # tar xzf autoconf-2.69.tar.gz
    # cd autoconf-2.69
    # ./configure --prefix=/usr/local
    # make
    # make install
```

4. automake
    ```
    # curl -OL http://ftpmirror.gnu.org/automake/automake-1.15.tar.gz
    # tar xzf automake-1.15.tar.gz
    # cd automake-1.15
    # ./configure --prefix=/usr/local
    # make
    # make install
```

5. pkg-config
    ```
    # curl -OL https://pkg-config.freedesktop.org/releases/pkg-config-0.29.tar.gz
    # tar zxf pkg-config-0.29.tar.gz
    # cd pkg-config-0.29
    # ./configure --with-internal-glib --prefix=/usr/local LDFLAGS="-framework CoreFoundation -framework Carbon" CC=clang
    # make
    # make install
```

6. lha
    ```
    # git clone https://github.com/jca02266/lha.git
    # aclocal
    # autoheader
    # automake -a
    # autoconf
    # ./configure --prefix=/usr/local
    # make
    # make install
```

7. libtool
    ```
   # wget http://ftpmirror.gnu.org/libtool/libtool-2.4.6.tar.gz
   # tar zxfv libtool-2.4.6.tar.gz
   # cd libtool-2.4.6
   # ./configure --prefix=/usr/local
   # make
   # make install
```

8. libpng
    ```
   # wget ftp://ftp.simplesystems.org/pub/png/src/libpng16/libpng-1.6.25.tar.gz
   # tar zxfv libpng-1.6.25.tar.gz
   # cd libpng-1.6.25
   # ./configure --prefix=/usr/local
   # make
   # make install
```

9. pngquant
    ```
    # git clone git://github.com/pornel/pngquant.git
    # cd pngquant/lib
    # git apply ~/Projects/amiga/blockyskies/docs/pngquant.patch
    # ./configure --prefix=/usr/local
    # make
    # mkdir /usr/local/include/pngquant
    # cp *.h /usr/local/include/pngquant/
    # cp *.a /usr/local/lib
```

10. GraphicsMagick
    ```
    # wget http://78.108.103.11/MIRROR/ftp/GraphicsMagick/1.3/GraphicsMagick-1.3.23.tar.gz
    # tar zxfv GraphicsMagick-1.3.23.tar.gz
    # cd GraphicsMagick-1.3.23
    # ./configure --prefix=/usr/local
    # make
    # make install
```

11. CMake
    ```
    # curl -O  https://cmake.org/files/v3.5/cmake-3.5.1-Darwin-x86_64.tar.gz
    # tar zxfv cmake-3.5.1-Darwin-x86_64.tar.gz
    # mv CMake.app /Applications
```

12. TMX C Loader
    ```
    # git clone https://github.com/baylej/tmx.git
    # cd tmx
    # mkdir build
    # cd build
    # /Applications/CMake.app/Contents/bin/cmake ..
    # make install
```

13. SOX
    ```
    # git clone git://sox.git.sourceforge.net/gitroot/sox/sox
    # cd sox
    # autoreconf -i
    # ./configure --prefix=/usr/local
    # make install
```

14. Up to date vlink
  ```
    # curl -OL http://sun.hasenbraten.de/vlink/daily/vlink.tar.gz
    # tar zxfv vlink.tar.gz 
    # cd vlink
    # mkdir objects
    # make
    # cp vlink /usr/local/amiga/bin
```

15. html2text
  ```
    # git clone https://github.com/aaronsw/html2text.git
    # cp html2text/html2text.py /usr/local/bin
```

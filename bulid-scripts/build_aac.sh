CONFIGURE_FLAGS="--enable-static --with-pic=yes --disable-shared"
#指定编译平台
ARCHS="i386 armv7 armv7s x86_64 arm64"
# 源码位置
SOURCE="fdk-aac-2.0.2"
FAT="fdk-aac-ios"
SCRATCH="scratch"
# must be an absolute path
THIN=`pwd`/"thin"
COMPILE="y"
LIPO="y"

if [ "$*" ]
then
    if [ "$*" = "lipo" ]
    then
        COMPILE=
    else
        ARCHS="$*"
        if [ $# -eq 1 ]
        then
            # skip lipo
            LIPO=
        fi
    fi
fi

if [ "$COMPILE" ]
then
    CWD=`pwd`
    for ARCH in $ARCHS
    do
        echo "building $ARCH..."
        mkdir -p "$SCRATCH/$ARCH"
        cd "$SCRATCH/$ARCH"
        CFLAGS="-arch $ARCH"
        if [ "$ARCH" = "i386" -o "$ARCH" = "x86_64" ]
        then
            PLATFORM="iPhoneSimulator"
            CPU=
            if [ "$ARCH" = "x86_64" ]
            then
                CFLAGS="$CFLAGS -mios-simulator-version-min=7.0"
                HOST="--host=x86_64-apple-darwin"
            else
                CFLAGS="$CFLAGS -mios-simulator-version-min=7.0"
                HOST="--host=i386-apple-darwin"
            fi
        else
            PLATFORM="iPhoneOS"
            if [ $ARCH = arm64 ]
            then
                HOST="--host=aarch64-apple-darwin"
            else
                HOST="--host=arm-apple-darwin"
            fi
            CFLAGS="$CFLAGS -fembed-bitcode"
        fi

        XCRUN_SDK=`echo $PLATFORM | tr '[:upper:]' '[:lower:]'`
        CC="xcrun -sdk $XCRUN_SDK clang -Wno-error=unused-command-line-argument-hard-error-in-future"
        AS="$CWD/$SOURCE/extras/gas-preprocessor.pl $CC"
        CXXFLAGS="$CFLAGS"
        LDFLAGS="$CFLAGS"

        $CWD/$SOURCE/configure \
            $CONFIGURE_FLAGS \
            $HOST \
            $CPU \
            CC="$CC" \
            CXX="$CC" \
            CPP="$CC -E" \
            AS="$AS" \
            CFLAGS="$CFLAGS" \
            LDFLAGS="$LDFLAGS" \
            CPPFLAGS="$CFLAGS" \
            --prefix="$THIN/$ARCH" || exit 1
        make -j8 install || exit 1
        cd $CWD
    done
fi

#合并各个架构平台的库文件
if [ "$LIPO" ]
then
    echo "building fat binaries..."
    mkdir -p $FAT/lib
    set - $ARCHS
    CWD=`pwd`
    cd $THIN/$1/lib
    for LIB in *.a
    do
        cd $CWD
        lipo -create `find $THIN -name $LIB` -output $FAT/lib/$LIB
    done
    
    cd $CWD
    cp -rf $THIN/$1/include $FAT
fi


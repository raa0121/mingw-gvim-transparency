# Maintainer: raa0121 <raa0121@gmail.com>
pkgname="${MINGW_PACKAGE_PREFIX}-gvim-transparency"
pkgver=8.2.3159
pkgrel=1
pkgdesc="Vi Improved, a highly configurable, improved version of the vi text editor."
arch=('any')
url="http://www.vim.org"
license=('vim')
groups=('edior')
depends=("${MINGW_PACKAGE_PREFIX}-python3"
         "${MINGW_PACKAGE_PREFIX}-lua")
makedepends=("patch" "${MINGW_PACKAGE_PREFIX}-make")
checkdepends=()
optdepends=()
provides=()
conflicts=()
replaces=()
backup=()
options=()
install=
changelog=
source=("https://github.com/vim/vim/archive/v$pkgver.tar.gz"
        "https://raw.githubusercontent.com/koron/vim-kaoriya-patches/master/master/2002-windows_transparency.diff"
        "Makefile")

md5sums=('33d8e2855ef4ee3947e033c9cdefc85a'
         '9c8d73a178cde13de108826531baa675'
         '0c87e86d155b9272ee52979e5478fc37')

noextract=()
validpgpkeys=()
_pkgname=vim

prepare() {
        cd "$_pkgname-$pkgver"
        patch -p1 -i "$srcdir/2002-windows_transparency.diff"
        sed -i 's|^.*\(#define SYS_.*VIMRC_FILE.*"\) .*$|\1|' src/feature.h
        sed -i 's|^.*\(#define VIMRC_FILE.*"\) .*$|\1|' src/feature.h
}

build() {
        cd "$_pkgname-$pkgver/src"
        [ "$MINGW_PREFIX" == "/mingw64" ] && MINGW_ARCH=64 TARGET_ARCH="x86-64" || MINGW_ARCH=32 TARGET_ARCH="i686"
        export PATH=$MINGW_PREFIX/bin:$PATH
        mingw32-make -f Make_ming.mak \
                GUI=yes IME=yes MBYTE=yes ICONV=yes \
                PYTHON3=$MINGW_PREFIX DYNAMIC_PYTHON3=yes PYTHON3_VER=38 \
                PYTHON3INC=-I$MINGW_PREFIX/include/python3.8 \
                DYNAMIC_PYTHON3_DLL=libpython3.8.dll \
                LUA=$MINGW_PREFIX DYNAMIC_LUA=yes \
                CSCOPE=yes NETBEANS=yes ARCH=$TARGET_ARCH DIRECTX=yes \
                STATIC_STDCPLUS=yes DEBUG=no TERMINAL=yes \
                VIMRCLOC=$MINGW_PREFIX/etc VIMRUNTIMEDIR=$MINGW_PREFIX/share/$_pkgname/runtime
}

package() {
        # FIXME: after install VIMRUNTIMEDIR is setting to $MINGW_PREFIX/bin
        cd "$_pkgname-$pkgver"
        install -Dm 755 src/gvim.exe $pkgdir$MINGW_PREFIX/bin/gvim.exe
        install -Dm 755 src/vimrun.exe $pkgdir$MINGW_PREFIX/bin/vimrun.exe
        make -f $srcdir/Makefile SRCDIR=$srcdir/$_pkgname-$pkgver DISTDIR=$pkgdir$MINGW_PREFIX/share/$_pkgname install
        install -Dm 644 runtime/doc/uganda.txt "${pkgdir}${MINGW_PREFIX}"/share/licenses/${pkgname}/license.txt
        install -Dm 644 runtime/rgb.txt "${pkgdir}${MINGW_PREFIX}"/share/$_pkgname/runtime
}

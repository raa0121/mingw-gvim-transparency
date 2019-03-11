# Maintainer: raa0121 <raa0121@gmail.com>
pkgname="${MINGW_PACKAGE_PREFIX}-gvim-transparency"
pkgver=8.1.1005
pkgrel=1
pkgdesc="Vi Improved, a highly configurable, improved version of the vi text editor."
arch=('i686' 'x86_64')
url="http://www.vim.org"
license=('vim')
groups=('edior')
depends=("${MINGW_PACKAGE_PREFIX}-python2"
         "${MINGW_PACKAGE_PREFIX}-python3"
         "${MINGW_PACKAGE_PREFIX}-ruby"
         "${MINGW_PACKAGE_PREFIX}-perl"
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
        "https://raw.githubusercontent.com/presuku/vim-kaoriya-patches/master/master/2002-windows_transparency.diff"
        "Makefile")
md5sums=('8c6a399a8b438978de98f164fe870518'
         '731e401ca286217f760b40cdf9e1baf2'
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
                PERL=$MINGW_PREFIX DYNAMIC_PERL=yes PERL_VER=528 \
                PERLEXE=$MINGW_PREFIX/bin/perl.exe \
                PERLLIB=$MINGW_PREFIX/lib/perl5/core_perl \
                PYTHON=$MINGW_PREFIX DYNAMIC_PYTHON=yes PYTHON_VER=27 \
                PYTHON_HOME=$MINGW_PREFIX \
                PYTHONINC=-I$MINGW_PREFIX/include/python2.7 \
                DYNAMIC_PYTHON_DLL=libpython2.7.dll \
                PYTHON3=$MINGW_PREFIX DYNAMIC_PYTHON3=yes PYTHON3_VER=37 \
                PYTHON3_HOME=$MINGW_PREFIX/ \
                PYTHON3INC=-I$MINGW_PREFIX/include/python3.7m \
                DYNAMIC_PYTHON3_DLL=libpython3.7m.dll \
                RUBY=$MINGW_PREFIX DYNAMIC_RUBY=yes RUBY_VER=26 RUBY_VER_LONG=2.6.0 \
                LUA=$MINGW_PREFIX DYNAMIC_LUA=yes \
                CSCOPE=yes NETBEANS=yes ARCH=$TARGET_ARCH DIRECTX=yes \
                STATIC_STDCPLUS=yes DEBUG=no TERMINAL=yes \
                VIMRCLOC=/etc VIMRUNTIMEDIR=$MINGW_PREFIX/share/$_pkgname/runtime
}

package() {
        # FIXME: after install VIMRUNTIMEDIR is setting to $MINGW_PREFIX/bin
        cd "$_pkgname-$pkgver"
        install -Dm 755 src/gvim.exe $pkgdir$MINGW_PREFIX/bin/gvim.exe
        make -f $srcdir/Makefile SRCDIR=$srcdir/$_pkgname-$pkgver DISTDIR=$pkgdir$MINGW_PREFIX/share/$_pkgname install
        install -Dm 644 runtime/doc/uganda.txt "${pkgdir}${MINGW_PREFIX}"/share/licenses/${pkgname}/license.txt
        install -Dm 644 runtime/rgb.txt "${pkgdir}${MINGW_PREFIX}"/share/$_pkgname/runtime
}

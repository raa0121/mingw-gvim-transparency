# Maintainer: raa0121 <raa0121@gmail.com>
pkgname="${MINGW_PACKAGE_PREFIX}-gvim-transparency"
pkgver=8.0.1376
pkgrel=1
pkgdesc=""
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
conflicts=('vim' 'gvim')
replaces=()
backup=()
options=()
install=
changelog=
source=("https://github.com/vim/vim/archive/v$pkgver.tar.gz"
        "https://raw.githubusercontent.com/koron/vim-kaoriya-patches/master/master/2002-windows_transparency.diff")
md5sums=('62855881a2d96d48956859d74cfb8a3b'
         '51e5362c7da48253d9880ef72d9defed')
noextract=()
validpgpkeys=()
_pkgname=vim

prepare() {
        cd "$_pkgname-$pkgver"
        patch -p1 -i "$srcdir/2002-windows_transparency.diff"
}

build() {
        cd "$_pkgname-$pkgver/src"
        [ "$MINGW_PREFIX" == "/mingw64" ] && MINGW_ARCH=64 TARGET_ARCH="x86-64" || MINGW_ARCH=32 TARGET_ARCH="i686"
        export PATH=$MINGW_PREFIX/bin:$PATH
        mingw32-make -f Make_ming.mak \
                GUI=yes IME=yes MBYTE=yes ICONV=yes \
                PERL=$MINGW_PREFIX DYNAMIC_PERL=yes PERL_VER=522 \
                PERLEXE=$MINGW_PREFIX/bin/perl.exe \
                PERLLIB=$MINGW_PREFIX/lib/perl5/core_perl \
                PYTHON=$MINGW_PREFIX DYNAMIC_PYTHON=yes PYTHON_VER=27 \
                PYTHON_HOME=$MINGW_PREFIX \
                PYTHONINC=-I$MINGW_PREFIX/include/python2.7 \
                DYNAMIC_PYTHON_DLL=libpython2.7.dll \
                PYTHON3=$MINGW_PREFIX DYNAMIC_PYTHON3=yes PYTHON3_VER=35 \
                PYTHON3_HOME=$MINGW_PREFIX/ \
                PYTHON3INC=-I$MINGW_PREFIX/include/python3.6m \
                DYNAMIC_PYTHON3_DLL=libpython3.6m.dll \
                RUBY=$MINGW_PREFIX DYNAMIC_RUBY=yes RUBY_VER=24 RUBY_VER_LONG=2.4.0 \
                LUA=$MINGW_PREFIX DYNAMIC_LUA=yes \
                CSCOPE=yes NETBEANS=yes ARCH=$TARGET_ARCH DIRECTX=yes \
                STATIC_STDCPLUS=yes DEBUG=no TERMINAL=yes
}

package() {
        cd "$_pkgname-$pkgver/src"
        #mingw32-make -f Make_ming.mak DESTDIR="$pkgdir/" install
}

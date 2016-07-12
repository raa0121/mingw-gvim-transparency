# Maintainer: raa0121 <raa0121@gmail.com>
pkgname=gvim-transparency
pkgver=7.4.1941
pkgrel=1
pkgdesc=""
arch=('i686' 'x86_64')
url="http://www.vim.org"
license=('vim')
groups=('edior')
depends=('mingw-w64-x86_64-python2'
         'mingw-w64-x86_64-python3'
         'mingw-w64-x86_64-ruby'
         'mingw-w64-x86_64-perl'
         'mingw-w64-x86_64-luajit-git')
makedepends=('patch' 'mingw-w64-x86_64-make')
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
md5sums=('11936d2aa60041dfa05be0ca58b7cbb3'
         'aa3dff7e6617a44580f160d2bd7cc0e3')
noextract=()
validpgpkeys=()
_pkgname=vim

prepare() {
        cd "$_pkgname-$pkgver"
        patch -p1 -i "$srcdir/2002-windows_transparency.diff"
}

build() {
        cd "$_pkgname-$pkgver/src"
        MSYSHOME=$(cygpath.exe -w /)
        [ "$CARCH" == "x86_64" ] && MINGW_ARCH=64 TARGET_ARCH="x86-64" || MINGW_ARCH=32
        mingw32-make -f Make_ming.mak GUI=yes IME=yes MBYTE=yes ICONV=yes \
                PERL=$MSYS_HOME/mingw$MINGW_ARCH DYNAMIC_PERL=yes PERL_VER=522 \
                PERLEXE=$MSYS_HOME/mingw$MINGW_ARCH/bin/perl.exe \
                PERLLIB=$MSYS_HOME/mingw$MINGW_ARCH/lib/perl5/core_perl \
                PYTHON=$MSYS_HOME/mingw$MINGW_ARCH DYNAMIC_PYTHON=yes PYTHON_VER=27 \
                PYTHON_HOME=$MSYS_HOME/mingw$MINGW_ARCH \
                PYTHONINC=-I$MSYS_HOME/mingw$MINGW_ARCH/include/python2.7 \
                DYNAMIC_PYTHON_DLL=libpython2.7.dll \
                PYTHON3=$MSYS_HOME/mingw$MINGW_ARCH DYNAMIC_PYTHON3=yes PYTHON3_VER=35 \
                PYTHON3_HOME=$MSYS_HOME/mingw$MINGW_ARCH/ \
                PYTHON3INC=-I$MSYS_HOME/mingw$MINGW_ARCH/include/python3.5m \
                DYNAMIC_PYTHON3_DLL=libpython3.5m.dll \
                RUBY=$MSYS_HOME/mingw$MINGW_ARCH DYNAMIC_RUBY=yes RUBY_VER=23 RUBY_VER_LONG=2.3.0 \
                LUA=$MSYS_HOME/mingw$MINGW_ARCH DYNAMIC_LUA=yes LUA_VER=51 \
                CSCOPE=yes NETBEANS=yes ARCH=$TARGET_ARCH DIRECTX=yes STATIC_STDCPLUS=yes DEBUG=no
}

package() {
        cd "$_pkgname-$pkgver/src"
        # mingw32-make -f Make_ming.mak DESTDIR="$pkgdir/" install
}


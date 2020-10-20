# mingw-gvim-transparency
[![Build Vim](https://github.com/raa0121/mingw-gvim-transparency/workflows/Build%20Vim/badge.svg)](https://github.com/raa0121/mingw-gvim-transparency/actions)

This provides Vim packages for mingw32/mingw64. This Vim has +python3/dyn and +lua/dyn, iconv/dyn and [kaoriya's transparency patch](https://github.com/koron/vim-kaoriya-patches/blob/master/master/2002-windows_transparency.diff) enabled.

The packages will be built at 0:00 UTC everyday.

## How to use
Add `/etc/pacman.conf`
```
[mingw-raa0121]
Server = https://github.com/raa0121/mingw-gvim-transparency/releases/latest/download
SigLevel = Never
```

```
pacman -Sy mingw-w64-i686-gvim-transparency
```
or
```
pacman -Sy mingw-w64-x86_64-gvim-transparency
```

## TODO
- [ ] Signing package
- [ ] Testing after build

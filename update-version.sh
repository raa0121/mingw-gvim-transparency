#!/bin/bash
# Fetch all tag names, and get only second column. Then remove all unnecessary characters.
function sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' | \
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}
latest_version=$(
  git ls-remote --tags https://github.com/vim/vim.git \
  | awk '!/({})/ {print $2}'                                  \
  | sed -e 's|refs/tags/v||'                        \
  | sort_versions                                             \
  | tail -n 1
)
source ./PKGBUILD
if [ $pkgver = $latest_version ]
then
  echo 'pkgver is same.'
  exit
fi
sed -i -e "s/pkgver=.*$/pkgver=${latest_version}/" ./PKGBUILD
eval "$(makepkg -g 2>/dev/null | sed -e 's/md5sums/new_\0/')"
for ((i = 0; i < ${#md5sums[@]}; i++)) {
  sed -i -e "s/${md5sums[$i]}/${new_md5sums[$i]}/" ./PKGBUILD
}

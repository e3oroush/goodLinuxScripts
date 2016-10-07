#!/bin/bash
# hard clean for qt projecs
make clean
find -iname makefile -delete
rm `find -type f -executable -exec file -i '{}' \; | grep 'x-executable; charset=binary'| cut -d":" -f1`

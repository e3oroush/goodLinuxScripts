#!/bin/bash
#renames white spaces of file to underscore
find . -depth -name "* *" -execdir rename 's/ /_/g' "{}" \;
echo all files renamed

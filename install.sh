#!/bin/bash

NOW=`date +%s`
PWD=`pwd`
READLINK=readlink
hash greadlink 2>&- && READLINK=greadlink

shopt -s nullglob

function install {
  PLATFORM=$1
  for file in $(find $PLATFORM/); do

    DIR=$PWD/$PLATFORM
    if ! [[ -f $file ]];      then continue; fi
    if [[ $file =~ .git/ ]];  then continue; fi

    versioned=$($READLINK -f "$file")
    echo "Checking $versioned"

    original=${versioned/#$DIR/~}
    canonical_original=$($READLINK -m "$original")
    if [ -h "$original" -a ! -e "$canonical_original" ]; then
      rm $original
      canonical_original=$original
    fi

    if [[ $versioned == $canonical_original ]]; then
      echo "Symlink already installed."
      echo
      continue
    fi

    if [[ -f $canonical_original ]]; then
      # should show a diff and give the option of bailing
      backup="$canonical_original.$NOW.bak"
      echo "Moving $canonical_original to $backup"
      $(mv $canonical_original $backup)
    fi

    dir=$(dirname $canonical_original)
    if [[ ! -d $dir ]]; then
      $(mkdir -p $dir)
    fi

    echo "Linking $canonical_original to $versioned"
    $(ln -s $versioned $canonical_original)
    echo

  done
}

install all
install $(uname)

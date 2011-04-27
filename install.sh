#!/bin/bash

NOW=`date +%s`
PWD=`pwd`
shopt -s nullglob

for file in `find .`; do

  if ! [[ -f $file ]]; then continue; fi
  if [[ $file =~ install.sh ]]; then continue; fi
  if [[ $file =~ .git/ ]]; then continue; fi
  if [[ $file =~ .gitignore ]]; then continue; fi

  versioned=$(readlink -f "$file")
  echo "Checking $versioned"

  original=${versioned/#$PWD/~}
  canonical_original=$(readlink -m "$original")

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
  if [[ -d $dir ]]; then
    $(mkdir -p $dir)
  fi

  echo "Linking $canonical_original to $versioned"
  $(ln -s $versioned $canonical_original)
  echo

done

#!/bin/bash --login

set -o errexit
set -o nounset

# stolen from: https://github.com/lukas2511/dehydrated/commit/85a25b56b7c50f9c950d7de8f40d1b090acb2343
# This makes it possible to run from outside this directory
# Find directory in which this script is stored by traversing all symbolic links
SOURCE="${0}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
SCRIPTDIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

# stolen from https://github.com/ajmalsiddiqui/dotfiles/blob/master/bootstrap.exclude.sh
# symlinks all files that start with dot (i.e. a literal dot -- .) to $HOME
link () {
  echo "This utility will symlink the files in this repo to the home directory"
  echo
  echo "Proceed? (y/n)"
  read resp
  if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
    find "${SCRIPTDIR}" -type f -name ".*" \( ! -name ".gitignore" \) -print0 |\
      xargs -0 -I "{}" ln -sv "{}" "$HOME"
    echo "Symlinking complete"
  else
    echo "Symlinking cancelled by user"
    exit 1
  fi
}

link

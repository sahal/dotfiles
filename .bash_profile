
# shellcheck source=/dev/null
# https://github.com/mathiasbynens/dotfiles/blob/master/.bash_profile
# NOTE: extra is not backed up unless you move it to this repository
#
# I've added an example `.extra` file in this repo as extra-linux
#   (this will not be copied by the bootstrap script)
for file in $HOME/.{path,bash_prompt,exports,aliases,functions,bash_completion,extra}; do
  # test if file is readable and that is a file
  test -r "$file" && \
  test -f "$file" && \
  source "$file"
done
unset file;

# vimode in bash
set -o vi

TERM="xterm-color"
export TERM

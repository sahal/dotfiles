PATH="$HOME/bin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
export PATH

# https://github.com/mathiasbynens/dotfiles/blob/master/.bash_profile
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra,bash_completion}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file;

# vimode in bash
set -o vi

function gitdiff {
  find "$1" -type f -exec git diff "$2" "$3" -- "{}" \;
}


function backup_home {

  backup_filename="${HOME}/Desktop/personal/home_dir_backup_$(date +%m-%d-%y).tar"

  mkdir -p "${HOME}/Desktop/personal/"

  find "${HOME}" -print0 \
    | gtar cf "${backup_filename}" \
        --exclude-from="${HOME}/.backup_exclude_file.txt" \
        --null \
        -T \
        -

  bzip2 "${backup_filename}"
}

working_directory() {
  echo -ne "${PWD##*/}";
}

full_working_dir() {
  echo -ne "${PWD}";
}

function pud {
  "$HOME/stash/repos/local_jenkins_env/utils/push-update.sh" "$(eval full_working_dir)" "$@"
}

docker-build() {
  date && time docker build -t $(eval working_directory) .
}

docker-run() {
  docker run --user root -i -t $(eval working_directory)
}

# http://stackoverflow.com/questions/19915683/how-to-find-package-for-installed-file-in-brew
function brew_find_pkg {
  file_to_search="$@"
  list_of_brew_pkgs=$(brew list)

  for package in $list_of_brew_pkgs; do
    brew ls $package | grep -E -q "/${file_to_search}$"
    if [ $? -eq 0 ]; then
      echo $package
      break
    fi
  done
}

rawurlencode() {
  local string="$@"
  local strlen=${#string}
  local encoded=""
  local pos c o

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"    # You can either set a return variable (FASTER)
  REPLY="${encoded}"   #+or echo the result (EASIER)... or both... :p
}

function web() {
  search_provider="https://duckduckgo.com/lite/"

  if [[ -n "$1" ]]; then
    query=$(rawurlencode "$@")
    tempfile=$(mktemp)
    echo "q=${query}" > $tempfile
    eval "w3m -no-cookie -post ${tempfile} ${search_provider}"
    rm -rf $tempfile
  else
    w3m https://duckduckgo.com
  fi
}

log_bash_persistent_history()
{
  [[
    $(history 1) =~ ^\ *[0-9]+\ +([^\ ]+\ [^\ ]+)\ +(.*)$
  ]]
  local date_part="${BASH_REMATCH[1]}"
  local command_part="${BASH_REMATCH[2]}"
  if [ "$command_part" != "$PERSISTENT_HISTORY_LAST" ]
  then
    echo $date_part "|" "$command_part" >> ~/.persistent_history
    export PERSISTENT_HISTORY_LAST="$command_part"
  fi
}

# http://eli.thegreenplace.net/2013/06/11/keeping-persistent-history-in-bash
# Stuff to do on PROMPT_COMMAND
run_on_prompt_command()
{
    log_bash_persistent_history
}

PROMPT_COMMAND="run_on_prompt_command"

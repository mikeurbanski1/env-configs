source ~/.zsh_prompt

export GPG_TTY=$(tty)
export HOME=/home/mike
export PYTHONSTARTUP=$HOME/startup.py

export GOPATH=$HOME/go-workspace # don't forget to change your path correctly!
# export GOBIN=$GOPATH/bin
# export GOROOT=/usr/local/opt/go/libexec
# export PATH=$PATH:$GOPATH/bin
# export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:/home/mike/.local/bin
export NODE_OPTIONS=--max-old-space-size=8192

export BIKETAG="$HOME/projects/biketag"
export ANONYMUS="/mnt/c/Users/mike/anonymus"

# PYTHON_TEST_PYTHON=~/.local/share/virtualenvs/python_test-LHT7_Exf/bin/python
# PYTHON_TEST_DIR=~/misc/python_test

#################################### Aliases ####################################

alias SRC="source ~/.zshrc"
alias ZRC="sublime '\\\\wsl$\Ubuntu\home\mike\.zshrc'"

alias sublime="/mnt/d/Programs/Sublime\ Text/sublime_text.exe"
alias chrome="/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe"
alias ll='ls -la'

########## git ##########
alias status="git status"
# alias newbranch="git checkout -b"
alias rename-branch="git branch -M"
alias co="git checkout"
alias fp="git fetch && pull"
alias fpm="git checkout main && git fetch && pull"
alias mfp="git checkout main && git fetch && pull"
alias merge="git merge"
alias mm="git merge main"
# alias pull="git pull"

########## curl ##########
alias cpost="curl -X POST"
alias cpostjson="curl -X POST -H \"Content-Type: application/json\" -d"
alias cdelete="curl -X DELETE"

alias trim="awk '{"'$1=$1}'";1'"

########## AWS ##########
alias tf="terraform"
alias s3cprec="aws s3 cp --recursive"

########## Kubernetes ##########
alias kget="kubectl get"
alias kg="kubectl get"
alias kgp="kubectl get pods"
alias kdp="kubectl describe pod"
alias kdelp="kubectl delete pod"
alias kaget="kubectl get --all-namespaces"
alias kdelete="kubectl delete"
alias kapply="kubectl apply -f"
alias kgetservice="kubectl get service"
alias kagetservice="kubectl get --all-namespaces service"
alias kgetpod="kubectl get pod"
alias kagetpod="kubectl get --all-namespaces pod"
alias kgeting="kubectl get ingress"
alias kageting="kubectl get --all-namespaces ingress"
alias kgetdepl="kubectl get deployment"
alias kagetdepl="kubectl get --all-namespaces deployment"
alias kgetall="kubectl get all"
alias kagetall="kubectl get --all-namespaces all"
alias kexec="kubectl exec"
alias klogs="kubectl logs"
alias kl="kubectl logs"
alias ktail="klogs -f --tail=1"
alias kedit="kubectl edit"
alias kdesc="kubectl describe"
alias k="kubectl"
alias kcfg="kubectl config"
alias kctx="kubectl config use-context"
KUBE_BASH=(--stdin --tty -- /bin/bash) # use with kexec to get interactive shell
KUBE_SH=(--stdin --tty -- /bin/sh)

alias translate="/usr/local/bin/trans"

trans() {
	local t="$(translate :he "$1" -b)"
	echo "$t" | trim
	echo "----"
	echo -n "Reversed: $(echo -n "$t" | rev | trim)"
	echo -n "$t" | rev | trim | pbcopy
	echo ""
	echo "(copied to clipboard - paste the reversed version into other apps)"
}

# This allows `tree` to use colors
# eval $(gdircolors)

#################################### Functions ####################################

########## Misc. terminal ##########

vscode() {
	/mnt/c/Users/mike/AppData/Local/Programs/Microsoft\ VS\ Code/Code.exe "$@" &
}

mc() {
	if [[ -z "$1" ]]; then
		return
	fi

	mkdir -p "$1"
	cd "$1"
}

mt() {
	if [[ -z "$1" ]]; then
		return
	fi

	mkdir -p "/tmp/$1"
	cd "/tmp/$1"
}

#################################### Aliases ####################################

alias format-json='$SA_TOOLS_PYTHON $SA_TOOLS/python/shell_utils/format_json_files.py'

########## Misc. ##########

alias epoch="$SA_TOOLS_PYTHON $SA_TOOLS/python/shell_utils/epoch_converter.py"
alias cpdir='pwd | pbcopy'
alias yaml-to-json='$SA_TOOLS_PYTHON $SA_TOOLS/python/shell_utils/yaml_to_json.py'
alias mv="mv -i"
alias build="yarn run build"
alias test="yarn run test"

########## Python ##########

alias activate="venv_activate"
alias venv="python3 -m venv venv && venv_activate"
alias prun="pipenv run"

#################################### Misc ####################################

rawurlencode() {
  local string="${1}"
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

print-and-copy() {
  echo "$1"
  echo "$1" | pbcopy
  echo "(copied to clipboard)"
}

contains() {
  # source: https://stackoverflow.com/questions/2829613/how-do-you-tell-if-a-string-contains-another-string-in-posix-sh
    string="$1"
    substring="$2"
    if test "${string#*$substring}" != "$string"
    then
        return 0    # $substring is in $string
    else
        return 1    # $substring is not in $string
    fi
}

#################################### Helper Functions ####################################

urlencode() {
    # urlencode <string>
    old_lc_collate=$LC_COLLATE
    LC_COLLATE=C

    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:$i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf '%s' "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done

    LC_COLLATE=$old_lc_collate
}

testexit() {
	return $1
}

changenew() { # Change to the newest directory
	cd $(ls -1 -tr | tail -1)
}

newestdir() { # Print the name of the newest directory
	ls -1 -tr -d */ | tail -1
}

setsecretvar() {
	read -rs "$1?Enter $1: "
}

function awkcut() {

	while [[ -n "$1" ]]; do
		if [[ "$1" == "-f" ]]; then
			shift
			__FIELD="$1"
		fi

		if [[ "$1" == "-d" ]]; then
			shift
			__DELIM="$1"
		fi

		shift
	done

	awk -F "$__DELIM" '{print $'"$__FIELD"'}'
}

function sortinplace() {
	local f="$1"
	shift
	sort "$@" "$f" >> .__tmp
	cat .__tmp > $1
	rm .__tmp
}

function encode() {
	echo -n "$1" | base64
}

function decode() {
	echo -n "$1" | base64 -D
}

delete-pipenv() {
  if [[ -a "Pipfile" ]]; then
    local python="$(pipenv run which python)"
    echo "Python location: $python"
    local python="$(dirname "$(dirname "$python")")"
    echo "Removing $python"
    rm -rf "$python"
    rm Pipfile
    rm Pipfile.lock
  else
    echo "Must run from the root of a Pipenv project (could not find Pipfile)"
  fi
}

pyscript() {
	local CMD=$(echo $1 | sed -e 's/\//./g' | sed -e 's/.py//')
	shift
	python -m $CMD "$@"
}

venv_activate() {
	__SILENT_ACTIVATE=false
	__SILENT_FAIL=false
	if [[ "$1" == "silent" ]]; then
		__SILENT_ACTIVATE=true
	fi

	if [[ "$2" == "silent" ]]; then
		__SILENT_FAIL=true
	fi

	__ORIG_DIR="`pwd`"
	__DIR="$__ORIG_DIR"
	while [[ "$__DIR" != '/' ]]; do
		if [[ -a "$__DIR/venv/bin/activate" ]]; then
			source "$__DIR/venv/bin/activate"
			if [[ "$__SILENT_ACTIVATE" == "false" ]]; then
				echo "Activated $__DIR/venv"
			fi
			__ACTIVATED_VENV="$__DIR"
			__VENV_ACTIVATED=true
			return
		elif [[ -a "$__DIR/env/bin/activate" ]]; then
			source "$__DIR/env/bin/activate"
			if [[ "$__SILENT_ACTIVATE" == "false" ]]; then
				echo "Activated $__DIR/env"
			fi
			__ACTIVATED_VENV="$__DIR"
			__VENV_ACTIVATED=true
			return
		elif [[ -a "$__DIR/.env/bin/activate" ]]; then
			source "$__DIR/.env/bin/activate"
			if [[ "$__SILENT_ACTIVATE" == "false" ]]; then
				echo "Activated $__DIR/.env"
			fi
			__ACTIVATED_VENV="$__DIR"
			__VENV_ACTIVATED=true
			return
		fi
		__DIR=$(dirname "$__DIR")
	done
	if [[ "$__SILENT_FAIL" == "false" ]]; then
		echo "No virtualenv found."
	fi
	__VENV_ACTIVATED=false
}

deactiv() {
	if typeset -f deactivate > /dev/null; then
	  deactivate
	fi

	__VENV_ACTIVATED=false
	unset __ACTIVATED_VENV
}

########## Git ##########

commitnogpg() {
	if [[ "$1" == "-m" ]]; then
		shift
	fi

	git commit -m "$1"
}

branch() {
  if [[ -z "$1" ]]; then
    echo 'missing branch name'
    return
  fi

  local branch="$1"

  git checkout "$branch" 2> /tmp/newbrancherror
  local error=$(</tmp/newbrancherror)
  if [[ "$error" != "error: pathspec"* ]]; then
    # all output goes to stderr
    cat /tmp/newbrancherror
    return
  fi

  local currentBranch="$(git branch | grep '*' | cut -b 3-)"

  if ! [[ "$currentBranch" == "master" || "$currentBranch" == "main" || "$currentBranch" == "(HEAD detached at stable"* ]]; then
    read -r "__confirm?You are not on the master branch or stable tag. Do you mean to create a new branch here? (y/N) "
    if [[ "$__confirm" != "y" ]]; then
      echo "Goodbye"
      return
    fi
  fi

  git checkout -b "$branch"
}

add() {
	if [[ -n "$1" ]]; then
		git add $*
	else
		git add .
	fi
}

gitpush() {
	git push origin $(git branch | grep '*' | cut -b 3-) "$@"
}

pull() {
	git pull origin $(git branch | grep '*' | cut -b 3-) "$@"
}

create-pr() {
	url="https://github.com/mikeurbanski1/biketag-pnpm/compare/$(git branch | grep '*' | cut -b 3-)?expand=1"
	cmd.exe /C start "$url"
}

open-in-vcs() {

  local file=""
  local branch=""
  local wd="$(pwd)"

  if [[ "$wd" == "/Users/mikeurbanski/misc/sa-tools"* ]]; then
    branch="master"
  elif [[ "$wd" == "/Users/mikeurbanski/platform/platform"* ]]; then
    branch="master"
  elif [[ "$wd" == "/Users/mikeurbanski/platform/checkov"* || "$wd" == "/Users/mikeurbanski/platform/redshirts"* ]]; then
    branch="main"
  fi

  while [[ -n "$1" ]]; do
    if [[ "$1" == "--branch" ]]; then
      shift
      branch="$1"
    elif [[ "$1" == "-b" ]]; then
      branch="$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')"
    else
      file="$1"
    fi
    shift
  done

  if [[ -z "$file" ]]; then
    file="$wd"
  fi

  echo "branch: $branch"
  echo "file: $file"

  PYTHONPATH=$SA_TOOLS $SA_TOOLS_PYTHON -m python.misc_scripts.open_in_vcs "$file" -b "$branch" "$@"
}

alias vcs="open-in-vcs"

clone() {
	if [[ -z "$1" ]]; then
		echo 'Usage: clone repo_url [dest_dir]'
		return
	fi

	if [[ -z "$2" ]]; then
		git clone "$1"
		cd $(echo "$1" | cut -d '/' -f 2 | cut -d '.' -f 1)
	else
		git clone "$1" "$2"
		cd "$2"
	fi
}

########## AWS ##########

alias aws-whoami="aws sts get-caller-identity"

unset-aws() {
	unset AWS_ACCESS_KEY_ID
	unset AWS_SECRET_ACCESS_KEY
	unset AWS_SESSION_TOKEN
	unset AWS_DEFAULT_PROFILE
	unset AWS_PROFILE
	unset AWS_CUSTOMER
	unset AWS_ACCOUNT
}

aws-profile() {
	unset-aws silent

	export AWS_PROFILE=$1
	export AWS_DEFAULT_PROFILE=$1

	if [[ "$2" != "silent" ]]; then
		aws sts get-caller-identity
	fi
}

set_aws() {
	read -r "AWS_ACCESS_KEY_ID?Enter access key: "
	read -r -s "AWS_SECRET_ACCESS_KEY?Enter secret: "
	read -r "AWS_SESSION_TOKEN?Enter session token: "

	export AWS_ACCESS_KEY_ID
	export AWS_SECRET_ACCESS_KEY
	export AWS_SESSION_TOKEN

	aws sts get-caller-identity
}
alias set-aws="set_aws"

lambda-func-to-js-env() {

	if [[ -z "$1" ]]; then
		echo "Missing function name"
		echo 'Usage: lambda-func-to-js-env func_name'
		echo '(also set AWS profile and AWS_REGION if needed)'
		return
	fi

	local res=$(aws lambda get-function --function-name "$1" | jq -r '.Configuration.Environment.Variables | to_entries | map("process.env.\(.key) = \"\(.value)\";") | .[]' | sort)
	echo "process.env.IS_OFFLINE = true;\n$res"
	echo "process.env.IS_OFFLINE = true;\n$res" | pbcopy

	echo ""
	echo "(Copied to clipboard)"
}

lambda-func-to-py-env() {

	if [[ -z "$1" ]]; then
		echo "Missing function name"
		echo 'Usage: lambda-func-to-py-env func_name'
		echo '(also set AWS profile and AWS_REGION if needed)'
		return
	fi

	local res=$(aws lambda get-function --function-name "$1" | jq -r '.Configuration.Environment.Variables | to_entries | map("os.environ[\"\(.key)\"] = \"\(.value)\"") | .[]')
	echo "os.environ['IS_OFFLINE'] = 'true'\n$res"
	echo "os.environ['IS_OFFLINE'] = 'true'\n$res" | pbcopy
	echo ""
	echo "(Copied to clipboard)"
}

#### biketag

update-pending-tag() {
	if [[ -z "$1" ]]; then
		echo "Usage: update-pending-game game-name"
		return 1
	fi

	local game_id="$(mongosh mongodb://172.25.160.1:27017/biketag --eval 'JSON.stringify(db.games.find().toArray())' | jq -r ".[] | select(.name == \"$1\") | ._id")"
	echo $game_id
	pnpm update-pending-tag -g "$game_id"
}

alias start-server

### help and autocomplete

_help() {
	integer ret=1
	local -a args
	args+=(
	    'replace'
	    'conditionals'
	)
	_describe 'help123' args && ret=0
	return ret
}

compdef _help help

_branches() {
  integer ret=1
	local -a args=("${(@f)$(git branch | cut -c 3-)}")
	_describe 'branches' args && ret=0
}

compdef _branches branch

_pnpm() {
	integer ret=1
	local -a args=("${(@f)$(cat package.json| jq -r '.scripts | keys[]')}")
	_describe 'branches' args && ret=0
}

compdef _pnpm pnpm

_games() {
	integer ret=1
	local -a args=("${(@f)$(mongosh mongodb://172.25.160.1:27017/biketag --eval 'JSON.stringify(db.games.find().toArray())' | jq -r ".[].name")}")
	_describe 'branches' args && ret=0
}
compdef _games update-pending-tag

function help() {
	if [[ -z "$1" ]]; then
		echo "replace"
		echo "conditionals"
	elif [[ "$1" == "replace" ]]; then
		echo "Replace first: !!:s/old/new/ or ^old^new^"
		echo "Replace all: !!:gs/old/new/"
		echo "Can stack: !!:gs/old1/new1/:s/old2/new2/"
	elif [[ "$1" == "conditionals" ]]; then
		echo "-a file		true if file exists."
		echo "-b file		true if file exists and is a block special file."
		echo "-c file		true if file exists and is a character special file."
		echo "-d file		true if file exists and is a directory."
		echo "-e file		true if file exists."
		echo "-f file		true if file exists and is a regular file."
		echo "-g file		true if file exists and has its setgid bit set."
		echo "-h file		true if file exists and is a symbolic link."
		echo "-k file		true if file exists and has its sticky bit set."
		echo "-n string	true if length of string is non-zero."
		echo "-o option 	true if option named option is on."
		echo "-p file		true if file exists and is a FIFO special file (named pipe)."
		echo "-r file		true if file exists and is readable by current process."
		echo "-s file		true if file exists and has size greater than zero."
		echo "-t fd		true if file descriptor number fd is open and associated with a terminal device"
		echo "-u file		true if file exists and has its setuid bit set."
		echo "-v varname	true if shell variable varname is set."
		echo "-w file		true if file exists and is writable by current process."
		echo "-x file		true if file exists and is executable by current process. If file exists and is a directory, then the current process has permission to search in the directory."
		echo "-z string	true if length of string is zero."
		echo "-L file		true if file exists and is a symbolic link."
		echo "-O file		true if file exists and is owned by the effective user ID of this process."
		echo "-G file		true if file exists and its group matches the effective group ID of this process."
		echo "-S file		true if file exists and is a socket."
		echo "-N file		true if file exists and its access time is not newer than its modification time."
		echo "file1 -nt file2		true if file1 exists and is newer than file2."
		echo "file1 -ot file2		true if file1 exists and is older than file2."
		echo "file1 -ef file2		true if file1 and file2 exist and refer to the same file."
		echo "string = pattern"
		echo "string == pattern	true if string matches pattern."
		echo "string != pattern	true if string does not match pattern."
		echo "string =~ regexp	true if string matches the regular expression regexp."
		echo "string1 < string2	true if string1 comes before string2 based on ASCII value of their characters."
		echo "string1 > string2	true if string1 comes after string2 based on ASCII value of their characters."
		echo "exp1 -eq exp2		true if exp1 is numerically equal to exp2."
		echo "exp1 -ne exp2		true if exp1 is numerically not equal to exp2."
		echo "exp1 -lt exp2		true if exp1 is numerically less than exp2."
		echo "exp1 -gt exp2		true if exp1 is numerically greater than exp2."
		echo "exp1 -le exp2		true if exp1 is numerically less than or equal to exp2."
		echo "exp1 -ge exp2		true if exp1 is numerically greater than or equal to exp2."
		echo "( exp )			true if exp is true."
		echo "! exp			true if exp is false."
		echo "exp1 && exp2	true if exp1 and exp2 are both true."
		echo "exp1 || exp2	true if either exp1 or exp2 is true."
		echo "http://zsh.sourceforge.net/Doc/Release/Conditional-Expressions.html"
	fi
}

# if [[ "$(ssh-add -l)" == "The agent has no identities." ]]; then
# 	echo "\033[1;31mDon't forget to run ssh-add, you fool"
# fi

commit() {
	# echo -n "$(security find-generic-password -a gpg -s gpg -w)" | pbcopy
	if [[ "$1" == "-m" ]]; then
		shift
	fi
	local message="$1"
	shift

	git commit --no-verify -m "$message" "$@"
}

get-vscode-command() {

	if [[ -z "$1" ]]; then
		echo "usage: get-vscode-command command-name [path-to-launch.json]"
		return 
	fi

	local launchFile="${2:=.vscode/launch.json}"

	local cmd="$(jq -r '.configurations[] | select(.name == "'"$1"'") | (if .env == null then "" else ([.env | to_entries[] | "\(.key)=\"\(.value)\""] | join(" ")) + " " end) + (.program | sub("\\$\\{workspaceFolder\\}"; ".")) + " \"" + (.args | join("\" \"")) + "\""' "$launchFile")"
	echo "$cmd";
	echo -n "$cmd" | pbcopy
	echo "(copied to clipboard)"
}

_get-vscode-command() {
	integer ret=1
	local -a args=("${(@f)$(jq -r '.configurations[].name' .vscode/launch.json)}")
	_describe 'commands' args && ret=0
}

compdef _get-vscode-command get-vscode-command

# export PYENV_ROOT=~/.pyenv

# eval "$(pyenv init --path)"

eval $(thefuck --alias)

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[white]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[white]%})"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✔"

source ~/.git-prompt.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm use v23.1.0

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/mike/google-cloud-sdk/path.zsh.inc' ]; then . '/home/mike/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/mike/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/mike/google-cloud-sdk/completion.zsh.inc'; fi

# echo "checking for redis server"
# if ! sudo service redis-server status; then
# 	sudo service redis-server start
# fi

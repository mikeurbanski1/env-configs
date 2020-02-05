# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export PATH="/Users/mikeurbanski/Library/Python/3.7/bin:$PATH:/Applications/Postgres.app/Contents/Versions/11/bin"
export NVM_DIR=~/.nvm

# Path to your oh-my-zsh installation.
export ZSH="/Users/mikeurbanski/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(brew git docker docker-compose docker-machine kubectl python aws)

source $ZSH/oh-my-zsh.sh

# For some reason, plugin autocompletion doesn't work unless a new zsh is launched. This launches a new one once.
# The downside is that every terminal appears as an active command.
if [[ -z $__EXEC_ZSH_AGAIN ]]; then
	export __EXEC_ZSH_AGAIN=NO  # This makes this statement not repeat infinitely.
	# echo "Launching new zsh"
	zsh
fi

# The workaround above causes the AWS plugin to set the prompt twice. This resets it.
RPROMPT='$(aws_prompt_info)'

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

source ~/zsh-git-prompt/zshrc.sh
PROMPT='%B%{$fg[white]%}!%! %{$fg[red]%}%1~ %b$(git_super_status)> %b'

setopt auto_cd
cdpath=(/Users/mikeurbanski/Documents/AWS /Users/mikeurbanski/)

# Set the right prompt; change on window resize.
# set_rps1()
# {
#     (( cols = $COLUMNS * 3/10 ))
#     RPROMPT=" %${cols}<..<%~%<<"
# }
# set_rps1


# TRAPWINCH ()
# {
#     set_rps1
# }

ZRC=~/.zshrc



#################################### Aliases ####################################

########## Misc. terminal ##########
alias SRC="source $ZRC"
alias small="open ~/Documents/Terminal\ settings/Basic\ -\ Small.terminal"
alias sublime="open -a Sublime\ Text"
alias chrome="open -a Google\ Chrome"
alias fullpath="realpath"

########## Python ##########
alias activate="venv_activate"
alias venv="virtualenv venv && venv_activate"

########## git ##########
alias status="git status"
alias newbranch="git checkout -b"
alias co="git checkout"
alias fp="git fetch && git pull"

########## curl ##########
alias cpost="curl -X POST"
alias cpostjson="curl -X POST -H \"Content-Type: application/json\" -d"
alias cdelete="curl -X DELETE"

alias trim="awk '{"'$1=$1}'";1'"

########## AWS ##########
alias tf="terraform"
alias REDACTED="aws-profile REDACTED"

########## Kubernetes ##########
alias kubectl-prod="kubectl --context='REDACTED'"
alias kubectl-stage="kubectl --context='REDACTED'"
alias kget="kubectl get"
alias kdelete="kubectl delete"
alias kapply="kubectl apply -f"
alias kgetservice="kubectl get service"
alias kgetpod="kubectl get pod"
alias kgeting="kubectl get ingress"
alias kgetpods="kubectl get pod"
alias kgetdepl="kubectl get deployment"
alias kgetall="kubectl get all"
alias kexec="kubectl exec"
alias klogs="kubectl logs"
alias ktail="klogs -f --tail=1"
alias kedit="kubectl edit"
alias kdesc="kubectl describe"
alias k="kubectl"
alias kcfg="kubectl config"
alias kctx="kubectl config use-context"
alias kconfpai="export KUBECONFIG=/Users/mikeurbanski/.kube/pai-config"
alias kpai="kconfpai" # when I am REALLY lazy
alias kconflocal="export KUBECONFIG=/Users/mikeurbanski/.kube/config"
alias login="kpai && ppl login"
KUBE_BASH=(--stdin --tty -- /bin/bash) # use with kexec to get interactive shell
KUBE_SH=(--stdin --tty -- /bin/sh)

# This allows `tree` to use colors
eval $(gdircolors)


#################################### Functions ####################################

########## Misc. terminal ##########

changenew() { # Change to the newest directory
	cd $(ls -1 -tr | tail -1)
}

newestdir() { # Print the name of the newest directory
	ls -1 -tr -d */ | tail -1
}

mc() { # Make a directory and change to it
	mkdir -p $1
	cd $1
}

setsecretvar() {
	read -rs "$1?Enter $1: "
}

mycd() {
	CD $*

	if [[ -n "$__ACTIVATED_VENV" ]]; then
		case $PWD/ in
			$__ACTIVATED_VENV/*) return;;
		esac
	fi

	if [[ "$AUTO_DEACTIVATE" == "true" && "$__VENV_ACTIVATED" == "true" ]]; then
		echo "Deactivated $__ACTIVATED_VENV"/venv
		deactiv
	fi

	if [[ "$AUTO_ACTIVATE" == "true" ]]; then
		venv_activate notsilent silent
	fi
}

function chpwd() {
	if [[ -n "$__ACTIVATED_VENV" ]]; then
		case $PWD/ in
			$__ACTIVATED_VENV/*) return;;
		esac
	fi

	if [[ "$AUTO_DEACTIVATE" == "true" && "$__VENV_ACTIVATED" == "true" ]]; then
		echo "Deactivated $__ACTIVATED_VENV"/venv
		deactiv
	fi

	if [[ "$AUTO_ACTIVATE" == "true" ]]; then
		venv_activate notsilent silent
	fi
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
	sort $1 >> .__tmp
	cat .__tmp > $1
	rm .__tmp
}

function encode() {
	echo -n "$1" | base64
}

function decode() {
	echo -n "$1" | base64 -D
}

function bastion() {
	if [[ "$1" == "REDACTED" ]]; then
		local HOST=$REDACTED
		local SSH_KEY=/Users/mikeurbanski/.ssh/REDACTED
		local SCP_KEY=/Users/mikeurbanski/.ssh/REDACTED
	else
		local HOST=$REDACTED
		local SSH_KEY=/Users/mikeurbanski/.ssh/REDACTED
		local SCP_KEY=/Users/mikeurbanski/.ssh/REDACTED
	fi

	ssh-add $SSH_KEY

	scp -i $SSH_KEY $SCP_KEY REDACTED@$HOST:/tmp
	ssh -i $SSH_KEY REDACTED@$HOST
	ssh -i $SSH_KEY REDACTED@$HOST rm /tmp/$(basename $SCP_KEY)
}

########## Command autocompletion ##########

_bastion() {

	integer ret=1
	local -a args
	args+=(
	    'prod:prod1'
	    'staging:staging1'
	)
	_describe 'bastion' args && ret=0
	return ret
}

compdef _bastion bastion

########## Python ##########

pyscript() {
	local CMD=$(echo $1 | sed -e 's/\//./g' | sed -e 's/.py//')
	shift
	python -m $CMD $*
}

if [[ -z "$__VENV_ACTIVATED" ]]; then
	__VENV_ACTIVATED="false"
fi

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

venv_activate notsilent silent # initial venv activation if in a python tree

if [[ -z "$AUTO_ACTIVATE" ]]; then
	export AUTO_ACTIVATE=true
fi

if [[ -z "$AUTO_DEACTIVATE" ]]; then
	export AUTO_DEACTIVATE=true
fi

########## Git ##########

commit() {
	if [[ "$1" == "-m" ]]; then
		shift
	fi
	
	git commit -m "$1"
}

add() {
	if [[ -n "$1" ]]; then
		git add $*
	else
		git add .
	fi
}

gitpush() {
	git push origin $(git branch | grep '*' | cut -b 3-)
}

########## AWS ##########

unset-aws() {
	unset AWS_ACCESS_KEY_ID
	unset AWS_SECRET_ACCESS_KEY
	unset AWS_SESSION_TOKEN
	unset AWS_DEFAULT_PROFILE
	unset AWS_PROFILE
}

aws-profile() {
	unset-aws

	if [[ "$1" == "prod" ]]; then
		export AWS_PROFILE=awsaml-REDACTED
		export AWS_DEFAULT_PROFILE=awsaml-REDACTED
	elif [[ "$1" == "ds" ]]; then
		export AWS_PROFILE=awsaml-REDACTED
		export AWS_DEFAULT_PROFILE=awsaml-REDACTED
	fi
}

aws-auth-simple() {
	if [[ -n "$1" ]]; then
		export AWS_PROFILE="$1"
	fi

	if [[ -z "$AWS_PROFILE" ]]; then
		echo "Using default AWS profile."
		export AWS_PROFILE=default
	else
		echo "Using $AWS_PROFILE"
	fi

	read -r "__OTP?Enter OTP: "

	if [[ "$1" == "REDACTED" ]]; then
		__SERIAL="$AWS_MFA_KEY_REDACTED"
	else
		__SERIAL="AWS_MFA_KEY_default"
	fi

	echo $__SERIAL

	__OUTPUT=`aws sts get-session-token --serial-number "$__SERIAL" --token-code $__OTP`

	export AWS_ACCESS_KEY_ID=`echo $__OUTPUT | grep AccessKeyId | cut -f 4 -d '"'`
	export AWS_SECRET_ACCESS_KEY=`echo $__OUTPUT | grep SecretAccessKey | cut -f 4 -d '"'`
	export AWS_SESSION_TOKEN=`echo $__OUTPUT | grep SessionToken | cut -f 4 -d '"'`

	echo $__OUTPUT
	
}

set_aws() {
	read -r "AWS_ACCESS_KEY_ID?Enter access key: "
	read -r -s "AWS_SECRET_ACCESS_KEY?Enter secret: "
	read -r "AWS_SESSION_TOKEN?Enter session token: "

	export AWS_ACCESS_KEY_ID
	export AWS_SECRET_ACCESS_KEY
	export AWS_SESSION_TOKEN
}

parse_aws() {
	while read LINE; do
		if [[ "$LINE" == *AccessKeyId* ]]; then
			echo $LINE
			export AWS_ACCESS_KEY_ID=`echo $LINE | cut -f 4 -d '"'`
		elif [[ "$LINE" == *SecretAccessKey* ]]; then
			echo $LINE
			export AWS_SECRET_ACCESS_KEY=`echo $LINE | cut -f 4 -d '"'`
		elif [[ "$LINE" == *SessionToken* ]]; then
			echo $LINE
			export AWS_SESSION_TOKEN=`echo $LINE | cut -f 4 -d '"'`
		fi
	done
}




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

autoload -U compinit && compinit

source $(brew --prefix nvm)/nvm.sh
eval $(thefuck --alias)




# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

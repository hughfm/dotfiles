# target: ~/.zshenv

export EDITOR='nvim'
export CLICOLOR=1
export FZF_DEFAULT_COMMAND='fd --type file --color=always --follow --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi"

export BAT_THEME=gruvbox-dark

export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export PATH=$PATH:"/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/MacGPG2/bin:/usr/local/sbin"
export PATH=$PATH:"/Applications/Postgres.app/Contents/Versions/latest/bin"

ENV_PRIVATE_PATH=$HOME/.env_private
[[ -f "$ENV_PRIVATE_PATH" ]] && source "$ENV_PRIVATE_PATH"

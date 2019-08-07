export EDITOR='nvim'
export CLICOLOR=1
export FZF_DEFAULT_COMMAND='ag -g ""'

export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export PATH=$PATH:"/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/MacGPG2/bin"
export PATH=$PATH:"/Applications/Postgres.app/Contents/Versions/9.4/bin"

ENV_PRIVATE_PATH=$HOME/.env_private
[[ -f "$ENV_PRIVATE_PATH" ]] && source "$ENV_PRIVATE_PATH"

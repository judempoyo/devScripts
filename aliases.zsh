#my aliases

alias pa='php artisan '
alias pas='php artisan serve'
alias crd='composer run dev'
alias nrd='npm run dev'
alias ni='npm install '
alias nrg='npm run generate'
alias nrb='npm run build'
alias update='sudo apt update && sudo apt upgrade -y'
alias i='sudo apt install '
alias ..='cd ..'
alias ...='cd ../..'

alias zz='z -l'          
alias zc='z -c'          
alias zf='z -I' 

alias pj="projet"
alias pjs="devps"
alias pjstop="devstop"
alias fp="findprojet"
alias lsp="lsprojets"


alias pjlaravel="projet $1 laravel"
alias pjnuxt="projet $1 nuxt"
alias pjphp="projet $1 php"

# Docker base
alias d='docker'
alias dc='docker compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'

# Containers
alias dlog='docker logs'
alias dlogf='docker logs -f'
alias dexec='docker exec -it'
alias dinspect='docker inspect'
alias dtop='docker top'

# Docker Compose
alias dcu='docker compose up'
alias dcud='docker compose up -d'
alias dcd='docker compose down'
alias dcb='docker compose build'
alias dcr='docker compose restart'
alias dcl='docker compose logs'
alias dclf='docker compose logs -f'
alias dcps='docker compose ps'

# cleanning
alias dstopall='docker stop $(docker ps -q)'
alias drmdead='docker rm $(docker ps -aq)'
alias drmc='docker container prune -f'
alias drmiunused='docker image prune -f'
alias dvolprune='docker volume prune -f'
alias dnetprune='docker network prune -f'
alias dclean='docker system prune -af --volumes'

# Inspection / debug
alias dip='docker inspect --format "{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}"'
alias dports='docker port'
alias dstats='docker stats'

# Build & registry
alias dbuild='docker build'
alias dtag='docker tag'
alias dpush='docker push'
alias dpull='docker pull'

# Run
alias drun='docker run --rm -it'

alias dlast='docker exec -it $(docker ps -lq) sh'

#my dev tools
alias devtools-code='cd $devtools && code .'
alias devtools-up='cd $devtools && dcud'
alias devtools-down='cd $devtools && dcd'

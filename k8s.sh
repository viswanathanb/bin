kn(){
    kubecolor get nodes \
    -o custom-columns='NAME:.metadata.name,STATUS:.status.conditions[?(@.type=="Ready")].status,ROLE:.metadata.labels.node-role\.kubernetes\.io/control-plane,AGE:.metadata.creationTimestamp,VERSION:.status.nodeInfo.kubeletVersion,INTERNAL-IP:.status.addresses[?(@.type=="InternalIP")].address,TAINTS:.spec.taints[*].key'
}

PROMPT='%F{green}%n%f@%F{blue}%m%f : %F{yellow}%~%f %# '

export PATH=/root/.local/bin:$PATH:/usr/local/go/bin
export PATH=$PATH:/root/bin
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

eval "$(direnv hook zsh)"

# source <(kubectl completion zsh)
source <(kubecolor completion zsh)
# source <(kubefwd completion zsh)
source <(talosctl completion zsh)
# source <(flux completion zsh)


alias gs="git status"
alias gl="git log --oneline --abbrev --graph --all"
alias scs="systemctl status"
alias scr="systemctl start"
alias sce="systemctl stop"
alias k=kubecolor

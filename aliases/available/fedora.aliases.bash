alias ycu="yum check-update"
alias yu="yum --skip-broken --changelog -y update"
alias yi="yum install"
alias yr="yum remove"
 
alias rpmg="rpm -qa|grep"
alias rpmq="rpm -q --qf '%{name}-%{version}-%{release}.%{arch}\n'"

alias sag="keychain -q ~/.ssh/id_dsa; . ~/.keychain/$(hostname)-sh"
alias sagk="keychain --stop all"


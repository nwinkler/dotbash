cite about-plugin
about-plugin 'Proxy Tools'

disable-proxy ()
{
	unset http_proxy
	unset https_proxy
	
	_npm-disable-proxy
	_ssh-disable-proxy
}

enable-proxy ()
{
	export http_proxy=$BASH_IT_HTTP_PROXY
	export https_proxy=$BASH_IT_HTTPS_PROXY
	
	_npm-enable-proxy
	_ssh-enable-proxy
}

show-proxy ()
{
	echo ""
	echo "Environment Variables"
	echo "====================="
	env | grep "proxy"
	
	_bash-it-show-proxy
	_npm-show-proxy
	_git-global-show-proxy
	_ssh-show-proxy
}

proxy-help ()
{
	echo ""
	echo "bash-it uses the variables BASH_IT_HTTP_PROXY and BASH_IT_HTTPS_PROXY to set the shell's"
	echo "proxy settings when you call 'enable-proxy'. These variables are best defined in a custom"
	echo "script in bash-it's custom script folder ($BASH_IT/custom),"
	echo "e.g. $BASH_IT/custom/proxy.env.bash"
	
	_bash-it-show-proxy
}

_bash-it-show-proxy ()
{
	echo ""
	echo "bash-it Environment Variables"
	echo "============================="
	echo "(These variables will be used to set the proxy when you call 'enable-proxy')"
	echo ""
	env | grep -e "BASH_IT.*PROXY"	
}

_npm-show-proxy ()
{
	if $(command -v npm &> /dev/null) ; then
		echo ""
		echo "npm"
		echo "==="
		echo "npm HTTP  proxy: " `npm config get proxy`
		echo "npm HTTPS proxy: " `npm config get https-proxy`
	fi
}

_npm-disable-proxy ()
{
	if $(command -v npm &> /dev/null) ; then
		npm config delete proxy
		npm config delete https-proxy
	fi
}

_npm-enable-proxy ()
{
	if $(command -v npm &> /dev/null) ; then
		npm config set proxy $BASH_IT_HTTP_PROXY
		npm config set https-proxy $BASH_IT_HTTPS_PROXY
	fi
}

_git-global-show-proxy ()
{
	if $(command -v git &> /dev/null) ; then
		echo ""
		echo "Git (Global Settings)"
		echo "====================="
		echo "Git (Global) HTTP  proxy: " `git config --global --get http.proxy`
		echo "Git (Global) HTTPS proxy: " `git config --global --get https.proxy`
	fi
}

_git-global-disable-proxy ()
{
	if $(command -v git &> /dev/null) ; then
		git config --global --unset-all http.proxy
		git config --global --unset-all https.proxy
	fi
}

_git-global-enable-proxy ()
{
	if $(command -v git &> /dev/null) ; then
		_git-global-disable-proxy
		
		git config --global --add http.proxy $BASH_IT_HTTP_PROXY
		git config --global --add https.proxy $BASH_IT_HTTPS_PROXY
	fi
}

git-show-proxy ()
{
	if $(command -v git &> /dev/null) ; then
		echo "Git Project Proxy Settings"
		echo "====================="
		echo "Git HTTP  proxy: " `git config --get http.proxy`
		echo "Git HTTPS proxy: " `git config --get https.proxy`
	fi
}

git-disable-proxy ()
{
	if $(command -v git &> /dev/null) ; then
		git config --unset-all http.proxy
		git config --unset-all https.proxy
	fi
}

git-enable-proxy ()
{
	if $(command -v git &> /dev/null) ; then
		git-disable-proxy
		
		git config --add http.proxy $BASH_IT_HTTP_PROXY
		git config --add https.proxy $BASH_IT_HTTPS_PROXY
	fi
}

_ssh-show-proxy ()
{
	if [ -f ~/.ssh/config ] ; then
		echo ""
		echo "SSH Config Enabled"
		echo "=================="
		awk '
		    $1 == "Host" { 
		        host = $2; 
		        next; 
		    } 
		    $1 == "ProxyCommand" { 
		        $1 = ""; 
		        printf "%s\t%s\n", host, $0 
		    }
		' ~/.ssh/config | column -t
	
		echo ""
		echo "SSH Config Disabled"
		echo "==================="
		awk '
		    $1 == "Host" { 
		        host = $2; 
		        next; 
		    } 
		    $0 ~ "^#.*ProxyCommand.*" { 
		        $1 = "";
		        $2 = ""; 
		        printf "%s\t%s\n", host, $0 
		    }
		' ~/.ssh/config | column -t
	fi
}

_ssh-disable-proxy ()
{
	if [ -f ~/.ssh/config ] ; then
		sed -e's/^.*ProxyCommand/#	ProxyCommand/' -i ""  ~/.ssh/config
	fi
}


_ssh-enable-proxy ()
{
	if [ -f ~/.ssh/config ] ; then
		sed -e's/#	ProxyCommand/	ProxyCommand/' -i ""  ~/.ssh/config
	fi
}

# Planned additional functionality:
# Documentation

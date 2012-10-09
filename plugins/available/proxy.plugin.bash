cite about-plugin
about-plugin 'Proxy Tools'

disable-proxy ()
{
	about 'Disables proxy settings for Bash, npm and SSH'
	group 'proxy'
	
	unset http_proxy
	unset https_proxy
	echo "Disabled proxy environment variables"
	
	npm-disable-proxy
	ssh-disable-proxy
}

enable-proxy ()
{
	about 'Enables proxy settings for Bash, npm and SSH'
	group 'proxy'
	
	export http_proxy=$BASH_IT_HTTP_PROXY
	export https_proxy=$BASH_IT_HTTPS_PROXY
	echo "Enabled proxy environment variables"
	
	npm-enable-proxy
	ssh-enable-proxy
}

show-proxy ()
{
	about 'Shows the proxy settings for Bash, Git, npm and SSH'
	group 'proxy'
	
	echo ""
	echo "Environment Variables"
	echo "====================="
	env | grep "proxy"
	
	bash-it-show-proxy
	npm-show-proxy
	git-global-show-proxy
	ssh-show-proxy
}

proxy-help ()
{
	about 'Provides an overview of the bash-it proxy configuration'
	group 'proxy'
	
	echo ""
	echo "bash-it uses the variables BASH_IT_HTTP_PROXY and BASH_IT_HTTPS_PROXY to set the shell's"
	echo "proxy settings when you call 'enable-proxy'. These variables are best defined in a custom"
	echo "script in bash-it's custom script folder ($BASH_IT/custom),"
	echo "e.g. $BASH_IT/custom/proxy.env.bash"
	
	bash-it-show-proxy
}

bash-it-show-proxy ()
{
	about 'Shows the bash-it proxy settings'
	group 'proxy'
	
	echo ""
	echo "bash-it Environment Variables"
	echo "============================="
	echo "(These variables will be used to set the proxy when you call 'enable-proxy')"
	echo ""
	env | grep -e "BASH_IT.*PROXY"	
}

npm-show-proxy ()
{
	about 'Shows the npm proxy settings'
	group 'proxy'
	
	if $(command -v npm &> /dev/null) ; then
		echo ""
		echo "npm"
		echo "==="
		echo "npm HTTP  proxy: " `npm config get proxy`
		echo "npm HTTPS proxy: " `npm config get https-proxy`
	fi
}

npm-disable-proxy ()
{
	about 'Disables npm proxy settings'
	group 'proxy'
	
	if $(command -v npm &> /dev/null) ; then
		npm config delete proxy
		npm config delete https-proxy
		echo "Disabled npm proxy settings"
	fi
}

npm-enable-proxy ()
{
	about 'Enables npm proxy settings'
	group 'proxy'
	
	if $(command -v npm &> /dev/null) ; then
		npm config set proxy $BASH_IT_HTTP_PROXY
		npm config set https-proxy $BASH_IT_HTTPS_PROXY
		echo "Enabled npm proxy settings"
	fi
}

git-global-show-proxy ()
{
	about 'Shows global Git proxy settings'
	group 'proxy'
	
	if $(command -v git &> /dev/null) ; then
		echo ""
		echo "Git (Global Settings)"
		echo "====================="
		echo "Git (Global) HTTP  proxy: " `git config --global --get http.proxy`
		echo "Git (Global) HTTPS proxy: " `git config --global --get https.proxy`
	fi
}

git-global-disable-proxy ()
{
	about 'Disables global Git proxy settings'
	group 'proxy'
	
	if $(command -v git &> /dev/null) ; then
		git config --global --unset-all http.proxy
		git config --global --unset-all https.proxy
		echo "Disabled global Git proxy settings"
	fi
}

git-global-enable-proxy ()
{
	about 'Enables global Git proxy settings'
	group 'proxy'
	
	if $(command -v git &> /dev/null) ; then
		git-global-disable-proxy
		
		git config --global --add http.proxy $BASH_IT_HTTP_PROXY
		git config --global --add https.proxy $BASH_IT_HTTPS_PROXY
		echo "Enabled global Git proxy settings"
	fi
}

git-show-proxy ()
{
	about 'Shows current Git project proxy settings'
	group 'proxy'
	
	if $(command -v git &> /dev/null) ; then
		echo "Git Project Proxy Settings"
		echo "====================="
		echo "Git HTTP  proxy: " `git config --get http.proxy`
		echo "Git HTTPS proxy: " `git config --get https.proxy`
	fi
}

git-disable-proxy ()
{
	about 'Disables current Git project proxy settings'
	group 'proxy'
	
	if $(command -v git &> /dev/null) ; then
		git config --unset-all http.proxy
		git config --unset-all https.proxy
		echo "Disabled Git project proxy settings"
	fi
}

git-enable-proxy ()
{
	about 'Enables current Git project proxy settings'
	group 'proxy'
	
	if $(command -v git &> /dev/null) ; then
		git-disable-proxy
		
		git config --add http.proxy $BASH_IT_HTTP_PROXY
		git config --add https.proxy $BASH_IT_HTTPS_PROXY
		echo "Enabled Git project proxy settings"
	fi
}

ssh-show-proxy ()
{
	about 'Shows SSH config proxy settings (from ~/.ssh/config)'
	group 'proxy'
	
	if [ -f ~/.ssh/config ] ; then
		echo ""
		echo "SSH Config Enabled in ~/.ssh/config"
		echo "==================================="
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
		echo "SSH Config Disabled in ~/.ssh/config"
		echo "===================================="
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

ssh-disable-proxy ()
{
	about 'Disables SSH config proxy settings'
	group 'proxy'
	
	if [ -f ~/.ssh/config ] ; then
		sed -e's/^.*ProxyCommand/#	ProxyCommand/' -i ""  ~/.ssh/config
		echo "Disabled SSH config proxy settings"
	fi
}


ssh-enable-proxy ()
{
	about 'Enables SSH config proxy settings'
	group 'proxy'
	
	if [ -f ~/.ssh/config ] ; then
		sed -e's/#	ProxyCommand/	ProxyCommand/' -i ""  ~/.ssh/config
		echo "Enabled SSH config proxy settings"
	fi
}

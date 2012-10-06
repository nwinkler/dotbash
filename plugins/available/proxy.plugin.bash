cite about-plugin
about-plugin 'Proxy Tools'

disable-proxy ()
{
	unset http_proxy
	unset https_proxy
	
	_npm-disable-proxy
	_git-global-disable-proxy
}

enable-proxy ()
{
	export http_proxy=$BASHIT_HTTP_PROXY
	export https_proxy=$BASHIT_HTTPS_PROXY
	
	_npm-enable-proxy
	_git-global-enable-proxy
}

show-proxy ()
{
	echo "Environment Variables"
	echo "====================="
	env | grep "proxy"
	
	_npm-show-proxy
	_git-global-show-proxy
}

_npm-show-proxy ()
{
	echo "npm"
	echo "==="
	echo "npm HTTP  proxy: " `npm config get proxy`
	echo "npm HTTPS proxy: " `npm config get https-proxy`
}

_npm-disable-proxy ()
{
	npm config delete proxy
	npm config delete https-proxy
}

_npm-enable-proxy ()
{
	npm config set proxy $BASHIT_HTTP_PROXY
	npm config set https-proxy $BASHIT_HTTPS_PROXY
}

_git-global-show-proxy ()
{
	echo "Git (Global Settings)"
	echo "====================="
	echo "Git (Global) HTTP  proxy: " `git config --global --get http.proxy`
	echo "Git (Global) HTTPS proxy: " `git config --global --get https.proxy`
}

_git-global-disable-proxy ()
{
	git config --global --unset-all http.proxy
	git config --global --unset-all https.proxy
}

_git-global-enable-proxy ()
{
	_git-global-disable-proxy
	
	git config --global --add http.proxy $BASHIT_HTTP_PROXY
	git config --global --add https.proxy $BASHIT_HTTPS_PROXY
}

git-show-proxy ()
{
	echo "Git Project Proxy Settings"
	echo "====================="
	echo "Git HTTP  proxy: " `git config --get http.proxy`
	echo "Git HTTPS proxy: " `git config --get https.proxy`
}

git-disable-proxy ()
{
	git config --unset-all http.proxy
	git config --unset-all https.proxy
}

git-enable-proxy ()
{
	git-disable-proxy
	
	git config --add http.proxy $BASHIT_HTTP_PROXY
	git config --add https.proxy $BASHIT_HTTPS_PROXY
}

# Planned additional functionality:
# .ssh/config

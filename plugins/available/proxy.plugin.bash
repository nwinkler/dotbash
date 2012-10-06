cite about-plugin
about-plugin 'Proxy Tools'

disable-proxy ()
{
	unset http_proxy
	unset https_proxy
	
	_npm-disable-proxy
}

enable-proxy ()
{
	export http_proxy=$BASHIT_HTTP_PROXY
	export https_proxy=$BASHIT_HTTPS_PROXY
	
	_npm-enable-proxy
}

show-proxy ()
{
	echo "Environment Variables"
	echo "====================="
	env | grep "proxy"
	
	_npm-show-proxy
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

# Planned additional functionality:
# .ssh/config
# Git proxy

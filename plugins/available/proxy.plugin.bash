cite about-plugin
about-plugin 'Proxy Tools'

disable-proxy ()
{
	unset http_proxy
	unset https_proxy
}

enable-proxy ()
{
	export http_proxy=$BASHIT_HTTP_PROXY
	export https_proxy=$BASHIT_HTTPS_PROXY
}

show-proxy ()
{
	env | grep "proxy"
}

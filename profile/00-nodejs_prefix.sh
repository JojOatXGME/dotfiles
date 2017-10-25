# 00-nodejs_prefix.sh
# ==================
# Let npm install executables in the home directory

node_default_prefix="$HOME/.npm-global"
node_actual_prefix="$(npm config get prefix 2> /dev/null)"

if command -v npm >/dev/null && ! npm config list | grep -wq "^prefix"
then
	npm config set prefix "$node_default_prefix"
	node_actual_prefix=""
fi

if [ -n "$node_actual_prefix" ] &&
   [ "$node_actual_prefix" != "$node_default_prefix" ]
then
	PATH="$PATH:$node_actual_prefix/bin:$node_default_prefix/bin"
	export PATH
else
	PATH="$PATH:$node_default_prefix/bin"
	export PATH
fi

unset node_actual_prefix
unset node_default_prefix

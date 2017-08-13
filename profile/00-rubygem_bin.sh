# 00-rubygem_bin.sh
# ==================
# Add local executables of ruby gem to PATH

gem_dir="$(ruby -rubygems -e 'puts Gem.user_dir' 2> /dev/null)"
if [ -n "$gem_dir" ]; then
	PATH="$PATH:$gem_dir/bin"
	export PATH
fi
unset gem_dir

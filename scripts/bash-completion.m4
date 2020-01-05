m4_dnl This file defines bash completions using the https://github.com/scop/bash-completion framework.
m4_define(`m4_APPNAME_US', m4_translit(m4_APPNAME, `-', `_'))m4_dnl
m4_define(`m4_COMPLETION_FUNCTION_NAME', `_complete_'m4_APPNAME_US)m4_dnl
m4_dnl
m4_dnl
m4_COMPLETION_FUNCTION_NAME`'() {
	local cur prev words cword split
	local subcommands="help version enumerate enrol generate"
	local opts
	_init_completion -s || return

	case "$prev" in
		help|version|enumerate|--help)
			return
			;;
		--file|-!(-*)f)
			_filedir
			return
			;;
		--device|-!(-*)d)
			COMPREPLY=($("${words[0]}" enumerate | grep -v '^!' | cut -f 2))
			return
			;;
	esac

	case "${words[1]}" in
		generate)
			opts="-f --file"
			;;
		enrol)
			opts="-f -d -p -o --file --device --passphrase --obfuscate-device-info"
			;;
	esac

	if [[ "$prev" == "m4_APPNAME" ]]; then
		COMPREPLY=($(compgen -W "$subcommands" -- "$cur"))
		[[ $COMPREPLY == *= ]] && compopt -o nospace
	else
		COMPREPLY=($(compgen -W "$opts" -- "$cur"))
	fi
}

complete -F m4_COMPLETION_FUNCTION_NAME m4_APPNAME
#!/usr/bin/env bash

_bash-it-comp-enable-disable()
{
	local enable_disable_args="alias plugin completion"
	COMPREPLY=( $(compgen -W "${enable_disable_args}" -- ${cur}) )
}

_bash-it-comp()
{
	local cur prev opts
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"
	prev="${COMP_WORDS[COMP_CWORD-1]}"
	opts="help show enable disable"
		
	case "${prev}" in
		show)
			local show_args="plugins aliases completions"
			COMPREPLY=( $(compgen -W "${show_args}" -- ${cur}) )
			return 0
			;;
		help)
			local help_args="plugins aliases"
			COMPREPLY=( $(compgen -W "${help_args}" -- ${cur}) )
			return 0
			;;
		enable)
			_bash-it-comp-enable-disable
			return 0
			;;
		disable)
			_bash-it-comp-enable-disable
			return 0
			;;
	esac
	
	COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
	
	return 0
}

complete -F _bash-it-comp bash-it

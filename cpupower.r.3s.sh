#!/usr/bin/env bash
run_as_root="pkroot -d" # gksu; pkroot; gnomesu -c;
this_script_path="$HOME/.config/argos/""$(basename "$0")"
status=$(cpupower frequency-info  -p | grep -o -P '(?<=").*(?=")' | tr [:lower:] [:upper:])
performance_icon="cpu-performance-symbolic"
powersave_icon="cpu-powersave-symbolic"
get_status_icon_name(){
	if [ "$status" = "POWERSAVE" ]
	then
        echo $powersave_icon
	elif [  "$status" = "PERFORMANCE" ]
	then
		echo $performance_icon
	fi
}

_cpupower="$(which cpupower)"
_cpupower_powersave="$_cpupower frequency-set -g powersave"
_cpupower_performance="$_cpupower frequency-set -g performance"
cpupower_powersave="\"$run_as_root \\\"$_cpupower_powersave\\\"; $this_tlp_script_path\""
cpupower_performance="\"$run_as_root \\\"$_cpupower_performance\\\"; $this_tlp_script_path\""

active_mode_icon=$(get_status_icon_name)
status=$(cpupower frequency-info  -p | grep -o -P '(?<=").*(?=")' | tr [:lower:] [:upper:])
echo "| iconName=$active_mode_icon"
echo "---"
echo "Governor:"
echo "$status | terminal=false iconName=$active_mode_icon"
echo "---"
echo "Performance | iconName=$performance_icon bash=$cpupower_performance terminal=false"
echo "Powersave | iconName=$powersave_icon bash=$cpupower_powersave terminal=false"

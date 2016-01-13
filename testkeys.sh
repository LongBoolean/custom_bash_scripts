#! /bin/bash
#testkeys.sh
#author: unknown (found it online somewhere)
#description: View keypress events

xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'

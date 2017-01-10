#! /bin/bash
#Simple GraphVis "IDE" of sorts 
#Author: Nicholas Peterson
#notes: script uses eog to view images, if you don't use gnome replace with 
#       desired application instead.
#
#       "graphviz_error.png" and "graphviz_template.gv" must both be inside
#       ~/bin/ for the script to function as intended.

lastModified="0"
filename=""
graphType="dot"
if [ -n "$1" ]; then
    filename=$1
else
    echo "Please enter the path to the graphviz file you want to work with."
    echo -n "filename: " 
    read filename
fi
if [ -e "$filename" ]; then :
else
    echo "File does not exist, do you want to create a new file? (y/N)"
    echo -n "choice: "
    read choice
    if [ "$choice" == "y" ]; then
        cp ~/bin/graphviz_template.gv "$filename"
    else
        echo "Exiting"
        exit 0
    fi
fi
if [ -n "$2" ]; then
    graphType=$2
else
    echo ""
    echo "Please enter the desired graph type you want graphviz to use."
    echo "Options include: dot, neato, twopi, circle, fdp, sfdp, patchwork."
    #note: circle, and sfdp don't seem to work at the moment. They probably need 
    #      different flags or something. Also, patchwork looks weird in my case.
    echo -n "choice: " 
    read graphType
fi

#create png if it does not currently exist
if [ -e "$filename" ]; then
    {
        if [ -e "$filename.png" ]; then
            sleep 1 #note: errors seem to pop up in eog if sleep is not present
            eog "$filename.png"
        else
            cp ~/bin/graphviz_error.png $filename.png 
            sleep 1
            eog "$filename.png"
        fi
    } & 
fi

while true 
do
    trap ' ' INT
    if [ -e "$filename" ]; then
        #regenerate graphviz image if dot file is updated
        modified="$(stat -c %Y $filename)"
        if [ "$lastModified" -ne "$modified" ]; then
            lastModified="$modified"
            clear
            echo Running GraphViz...
            bash -c "$graphType $filename -O -Tpng"
            error=$?
            if [ $error -eq "0" ]; then
                echo No errors.
            else
                cp ~/bin/graphviz_error.png $filename.png 
            fi
        fi
    else
        #check to make sure the file really doesn't exist
        #fixes weird bug that cause the script to quit too early 
        sleep 1
        if [ -e "$filename" ]; then :
        else
            echo GraphViz.sh: $filename does not exist.
            break;
        fi
    fi
    trap - INT
    sleep 1 

done

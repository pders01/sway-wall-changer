#!/bin/bash

source settings.sh
setting_repo_dl=$SETTING_REPO_DL
config_path=$CONFIG_PATH


if [[ setting_repo_dl -eq True ]]
	then
        echo "Do you want to clone a repo containing wallpapers? You can disable this function in settings.sh [y/N]"
        read repo_dl
		case "$repo_dl" in
		    [yY][eE][sS]|[yY]) 
			echo "Please enter your repo url:"
			read repo_url
            dir_name=${repo_url##*/} 
            dir_name=${dir_name%.*}
            git clone $repo_url
            cd $dir_name
            ;;
		    *)
			;;
		esac
fi

echo "You're in $(pwd)"

sxiv * &

prompt="Please select a wallpaper:"
options=( $(find -maxdepth 1 -print0 | xargs -0) )

PS3="$prompt "
select opt in "${options[@]}" "Quit" ; do 
    if (( REPLY == 1 + ${#options[@]} )) ; then
        exit

    elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
        echo "$(pwd)/${opt:2}"
        sed -i "s|exec swaybg -i.*|exec swaybg -i $(pwd)/${opt:2}|g" $config_path
        break

    else
        echo "Invalid option. Try another one."
    fi
done    

# here you'll have to adjust setting the wallpaper in whatever DE or WM your using

echo $selected_wallpaper








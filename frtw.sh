#!/bin/bash

source settings.sh
setting_repo_dl=$SETTING_REPO_DL
config_path=$CONFIG_PATH
working_dir=$1

if [[ -n "$working_dir" ]]
    then
        cd "$working_dir" || exit
        working_dir="$(pwd)"
    elif [[ $setting_repo_dl -eq true ]]
        then
            printf "Do you want to clone a repo containing wallpapers?\n \
                  You can disable this function in settings.sh [y/N]"
            read -r repo_dl
            case "$repo_dl" in
                [yY][eE][sS]|[yY]) 
                echo "Please enter your repo url:"
                read -r repo_url
                dir_name=${repo_url##*/} 
                dir_name=${dir_name%.*}
                git clone "$repo_url"
                cd "$dir_name" || exit
                ;;
                *)
                ;;
            esac
fi

echo "You're in $(pwd)"

sxiv ./* &

unset options i
while IFS= read -r -d $'\0' f; do
  options[i++]="$f"
done < <(find "$working_dir" -maxdepth 1 -type f -name "*.jpg" -print0 )

select opt in "${options[@]}" "Stop the script"; do
  case $opt in
    *.jpg)
      echo "${opt}"
      sed -i "s|exec swaybg -i.*|exec swaybg -i ${opt}|g" "$config_path"
      break
      ;;
    "Quit")
      echo "You chose to stop"
      break
      ;;
  esac
done



# here you'll have to adjust setting the wallpaper in whatever DE or WM your using








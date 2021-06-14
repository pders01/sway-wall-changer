# sway-wall-changer
Bash script that that enables you to change your wallpaper from the command line.
I focused on JPGs but you can easily adjust that. 

## dependencies

* sxiv

## usage 

```
./frtw.sh ~/Pictures/Wallpaper 
```

repo_dl may be broken atm
## settings

```
SETTING_REPO_DL=1 || ''                     # use this setting to prevent the the downloading part
CONFIG_PATH=~/.config/sway/config.d/theme   # you'll have to manually modify this to match your
                                              configuration; I use sway and use this file to specify
                                              my background-image
```



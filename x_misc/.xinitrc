setxkbmap -option grp:switch,grp:lwin_toggle,grp_led:scroll us,bg -variant ,bas_phonetic
setxkbmap -option 'caps:ctrl_modifier'
xrdb ~/.Xresources
exec i3
unclutter -idle 2 &

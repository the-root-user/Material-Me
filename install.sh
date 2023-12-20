#!/bin/bash
echo ""
echo "┌────────────────────────────────────────┐"
# │
echo ""
echo "    Material  -  A Material You theme     "
echo ""
echo "    @therootuser_  "
# echo ""
# echo "  Fork of Nova-Pengi theme"
echo ""
echo "└────────────────────────────────────────┘"
echo ""
sleep 0.6

if [[ $EUID -eq 0 ]]; then
    sleep 0.5; echo -e "[-] Please execute the script as normal user (without sudo). "
    exit
fi

echo "┌─ Installing.."
if [ -d aurorae/Material-Me ]; then
    sleep 0.2; echo -e "├── aurorae theme "
    if ! [ -d $HOME/.local/share/aurorae/themes/ ]; then
        mkdir -p $HOME/.local/share/aurorae/themes/
    fi
    cp aurorae/Material* $HOME/.local/share/aurorae/themes/ -r
fi

if [ -f color-schemes/MaterialMe.colors ]; then
    sleep 0.2; echo -e "├── color scheme "
    if ! [ -d $HOME/.local/share/color-schemes/ ]; then
        mkdir -p $HOME/.local/share/color-schemes/
    fi
    cp color-schemes/MaterialMe.colors $HOME/.local/share/color-schemes/MaterialMe.colors
fi

if [ -f Kwrite-MaterialMe.theme ]; then
    # sleep 0.2; echo -e "├── editor theme "
    if ! [ -d $HOME/.local/share/org.kde.syntax-highlighting/themes/ ]; then
        mkdir -p $HOME/.local/share/org.kde.syntax-highlighting/themes/
    fi
    cp Kwrite-MaterialMe.theme $HOME/.local/share/org.kde.syntax-highlighting/themes/Kwrite-MaterialMe.theme
fi

kvantum="false"
if [ -d Kvantum/Material-Me ]; then
    sleep 0.2; echo -e "├── kvantum theme "
    if ! [ -d $HOME/.config/Kvantum/ ]; then
        mkdir -p $HOME/.config/Kvantum/
    fi
    cp Kvantum/Material-Me $HOME/.config/Kvantum/ -r
    kvantum="true"
fi

if [ -d desktoptheme/Material-Me ]; then
    sleep 0.2; echo -e "├── desktop theme "
    if ! [ -d $HOME/.local/share/plasma/desktoptheme/ ]; then
        mkdir -p $HOME/.local/share/plasma/desktoptheme/
    fi
    cp desktoptheme/Material-Me $HOME/.local/share/plasma/desktoptheme/ -r
fi

if [ -d look-and-feel/Material-Me ]; then
    sleep 0.2; echo -e "├── login/splash theme "
    if ! [ -d $HOME/.local/share/plasma/look-and-feel/ ]; then
        mkdir -p $HOME/.local/share/plasma/look-and-feel/
    fi
    cp look-and-feel/Material-Me $HOME/.local/share/plasma/look-and-feel/ -r
fi

if [ -f konsole/Material-Me.profile ]; then
    sleep 0.2; echo -e "├── konsole theme "
    if ! [ -d $HOME/.local/share/konsole/ ]; then
        mkdir -p $HOME/.local/share/konsole/
    fi
    cp konsole/Material-Me.profile $HOME/.local/share/konsole/Material-Me.profile
    if [ -f konsole/Material-Me.colorscheme ]; then
        cp konsole/Material-Me.colorscheme $HOME/.local/share/konsole/Material-Me.colorscheme
    fi
fi

if [ -d wallpapers/Material-Me ]; then
    sleep 0.2; echo -e "├── wallpapers "
    if ! [ -d $HOME/.local/share/wallpapers/ ]; then
        mkdir -p $HOME/.local/share/wallpapers/
    fi
    cp wallpapers/* $HOME/.local/share/wallpapers/ -r
fi

if ! [ -d $HOME/.local/share/icons/WhiteSur ]; then
    sleep 0.5; echo -e "├─ Icon theme installation aborted."
    echo -e "│   WhiteSur icon theme not found, please install it."
else
    if [ -d WhiteSur ]; then
        sleep 0.2; echo -e "├── icon theme "
        cp WhiteSur $HOME/.local/share/icons/ -r > /dev/null
        if [ -d WhiteSur/actions ]; then
            cp WhiteSur/actions $HOME/.local/share/icons/WhiteSur-dark -r
        fi
        if [ -d WhiteSur/places/symbolic ]; then
            cp WhiteSur/places/symbolic $HOME/.local/share/icons/WhiteSur-dark/places -r
        fi
    fi
fi

if [[ $1 = 'sddm' ]]; then
    if [ -d sddm/Material-Me ]; then
        sleep 0.2; echo -e "├── sddm theme "
        if ! [[ $EUID -eq 0 ]]; then
            echo -e "│      Please provide "
        fi
        if ! [ -d /usr/share/sddm/themes/ ]; then
            sudo mkdir -p /usr/share/sddm/themes/
        fi
        sudo cp sddm/Material* /usr/share/sddm/themes/ -r
    fi
elif [[ $1 = '' ]]; then
    sleep 0.2; echo -e "│\n├─ If you want to install sddm theme, execute "
    echo -e "│    $0 sddm"
fi

sleep 0.5
echo -e "│\n└─ Installation done."

sleep 1
echo " "
echo -ne "┌─ Do You want to apply the theme? "
read REPLY;
if [[ "$REPLY" =~ ^[y/Y]$ ]]; then
    echo -ne "├─ Applying theme"
    sleep 0.3; echo -ne ".";
    lookandfeeltool -a Material-Me 2> /dev/null
    sleep 0.3; echo -ne ".";
    if [[ "$kvantum" == "true" ]]; then
    echo -e "[General]\ntheme=Material-Me" > $HOME/.config/Kvantum/kvantum.kvconfig; fi
    sleep 0.3; echo -ne ". ";
    sleep 0.5; echo -e "Applied."
else
    echo -ne "├─ Ok"
    sleep 0.3; echo -ne ".. "
    sleep 0.3; echo -ne "OK! "
    sleep 0.5; echo -e "I'm not tampering with your settings. "
fi
sleep 1
echo -e "│\n└─ Job done, Bye."

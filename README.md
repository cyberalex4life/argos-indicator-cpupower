# argos-indicator-cpupower
![Cpupower Argos Based Governor Indicator]()  ![Cpupower Argos Based Governor Indicator]()

#### Installation
Install [Argos](https://extensions.gnome.org/extension/1176/argos/) Gnome-Shell extension.

Create directory `~/.local/share/icons` if it does not exist:
```
! [ -d "~/.local/share/icons" ] && mkdir --parents ~/.local/share/icons || true
```

Then:
```
git clone https://github.com/cyberalex4life/argos-indicator-cpupower.git
cd argos-indicator-cpupower
cp -v icons/* ~/.local/share/icons/
cp -v cpupower.r.3s.sh ~/.config/argos/
sudo cp org.freedesktop.policykit.pkexec.cpupower.policy /usr/share/polkit-1/actions/
sudo cp pkroot /usr/local/bin/
```
**Note!**
Further info to be added soon...

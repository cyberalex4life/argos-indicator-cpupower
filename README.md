# argos-indicator-cpupower
Gnome Shell Indicator for switching CPU governors using Argos API. Only Intel P-State is coded currently.

![Cpupower Argos Based Governor Indicator](https://github.com/cyberalex4life/argos-indicator-cpupower/blob/master/screenshots/cpupower_1.jpg)  ![Cpupower Argos Based Governor Indicator](https://github.com/cyberalex4life/argos-indicator-cpupower/blob/master/screenshots/cpupower_2.jpg)

#### Requirements
- [Argos](https://extensions.gnome.org/extension/1176/argos/) Gnome Shell extension.
- cpupower (linux-tools-common): `sudo apt install linux-tools-common`
- one of the following:
    - [pkroot](https://github.com/cyberalex4life/pkroot) - minimum already provided
    - gksu: `sudo apt install gksu`
    - gnomesu - OpenSuSE only

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

# copy icons to location
cp -v icons/* ~/.local/share/icons/

# copy 'cpupower.r.3s.sh' to argos folder
cp -v cpupower.r.3s.sh ~/.config/argos/

# copy policy
sudo cp org.freedesktop.policykit.pkexec.cpupower.policy /usr/share/polkit-1/actions/

# copy pkroot to a PATH location
sudo cp pkroot /usr/local/bin/
```
#### Uninstall
```
# remove icons
rm ~/.local/share/icons-to-delete/{cpu-performance-symbolic.png,cpu-powersave-symbolic.png}

# remove 'cpupower.r.3s.sh'
rm ~/.config/argos/cpupower.r.3s.sh

# remove polkit policy and pkroot
sudo rm /usr/share/polkit-1/actions/org.freedesktop.policykit.pkexec.cpupower.policy
sudo rm /usr/local/bin/pkroot
```

Then uninstall Argos if you don't need it anymore.

**Note!**
- To make the indicator ask for password when switching video cards, you can either fully install
['pkroot'](https://github.com/cyberalex4life/pkroot) or edit '**org.freedesktop.policykit.pkexec.cpupower.policy**' such that these lines:

    ```
    <defaults>
        <allow_any>yes</allow_any>
        <allow_inactive>yes</allow_inactive>
        <allow_active>yes</allow_active>
    </defaults>
    ```
    look like this:
    ```
    <defaults>
        <allow_any>auth_admin</allow_any>
        <allow_inactive>auth_admin</allow_inactive>
        <allow_active>auth_admin</allow_active>
    </defaults>
    ```

- You can also modify second line from '**cpupower.r.3s.sh**':
    ```
    run_as_root="pkroot -d" # gksu; pkroot; gnomesu -c;
    ```
    into:
    ```
    run_as_root="gksu" # gksu; pkroot; gnomesu -c;
    ```
    to use '**gksu**' in Ubuntu or Debian based distro's.

    'gnomesu -c' is ment for OpenSuSE, though the script might not be ready for anything other than Ubuntu's **nvidia-prime**.

    In general "*run_as_root*" has to support the following syntax:
    ```
    run_as_root "<command_or_list_of_commands>"
    ```
    where **""** is the way commands are coded (and **\\\\\\"** is nothing but an escape sequence).

# argos-indicator-cpupower
Gnome Shell Indicator for switching CPU governors using Argos API. Only Intel P-State is coded currently.

![Cpupower Argos Based Governor Indicator](https://github.com/cyberalex4life/argos-indicator-cpupower/blob/master/screenshots/cpupower_1.jpg)  ![Cpupower Argos Based Governor Indicator](https://github.com/cyberalex4life/argos-indicator-cpupower/blob/master/screenshots/cpupower_2.jpg)

#### Requirements
- [Argos](https://extensions.gnome.org/extension/1176/argos/) Gnome Shell extension.
- cpupower (linux-tools-common): `sudo apt install linux-tools-common`
- one of the following:
    - [pkroot](https://github.com/cyberalex4life/pkroot) - minimum already provided in this repository
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
- To make the indicator ask for password when switching governors, you can either fully install
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

    'gnomesu -c' is meant for OpenSuSE.

    In general "*run_as_root*" has to support the following syntax:
    ```
    run_as_root "<command_or_list_of_commands>"
    ```
    where **""** is the way commands are coded (and **\\\\\\"** is nothing but an escape sequence).

- To further modify position and execution timings read:

    #### [Filename format](https://github.com/p-e-w/argos#filename-format) (for Argos plugins)


    A plugin file may be named anything (it only needs to be executable), but if its name has the special form

    ```
    NAME.POSITION.INTERVAL[+].EXTENSION
    ```

    where

    * `POSITION` consists of an integer (optional) + one of `l` (left), `c` (center) or `r` (right), and
    * `INTERVAL` consists of an integer + one of `s` (seconds), `m` (minutes), `h` (hours) or `d` (days)

    then

    * the dropdown menu button is placed in the panel at `POSITION`, and
    * the plugin is re-run and its output re-rendered every `INTERVAL`, and
    * if `INTERVAL` is followed by `+`, the plugin is additionally re-run each time the dropdown menu is opened.

    `POSITION` may be omitted entirely (in which case the button is placed before all other buttons on the right-hand side of the panel) while `INTERVAL` can be left empty. For example, a script named `plugin.10s.sh` is updated every 10 seconds, the button belonging to `plugin.1c..sh` is positioned just right of the GNOME Shell clock, and `plugin.l.1m.sh` is displayed left of the "Activities" button and updated every minute.


#### Other indicators:
- [argos-indicator-tlp](https://github.com/cyberalex4life/argos-indicator-tlp) -  for switching tlp daemon power modes (AC/battery)
- [argos-indicator-nvidia-prime](https://github.com/cyberalex4life/argos-indicator-nvidia-prime) - for managing NVidia Prime

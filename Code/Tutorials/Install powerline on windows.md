# Installing powerline on Windows 10

## Installing WSL
**Unfortunately, there is no way to get powerline on windows.**
So open the windows store and install ubuntu

Open the `Turn windows features on and off` prompt and check the ☑ `Windows subsystem for linux` and the ☑ `Virtal machine platform`
Accept everything you are asked and restart your computer.

## Installation of powerline
Now, open ubuntu. You may have to register.

When done, run:
```bash
$ sudo apt-get update
$ sudo apt-get upgrade
$ sudo apt install python3-pip
```

(Note that you can press `[rmb]` to paste text and python3 may have to be installed)

Next we'll install powerline with pip:
```bash
$ pip install powerline
```

## Configuring bash
Run:
```bash
$ nano ~/.bashrc
```
and, at the end of the file, add:
```bash
# Powerline configuration
if [ -f /usr/local/lib/python3.8/dist-packages/powerline/bindings/bash/powerline.sh ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  source /usr/local/lib/python3.8/dist-packages/powerline/bindings/bash/powerline.sh
fi
```
(Note for me the powerline package is located in `/usr/local/lib/python3.8/dist-packages/powerline/`
Replace by the output of `python3 -c "import site; print(site.getsitepackages())[0]"`.)


To run, powerline needs to use vim.
Check if it is installed by typing `vim --version`.
If not, enter:
```bash
$ sudo apt install --yes vim
```

After checking, open `nano ~/.vimrc` and paste
```bash
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

set laststatus=2
```

I won't go any further, but you can find additionnal details [here](https://www.ricalo.com/blog/install-powerline-windows/#edit-your-powerline-configuration)

Anyway, there you are, if you've done everything correctly, if you restart ubuntu, powerline should start automatically.
If not, check if your paths are corrects. Sometimes in `.bashrc` the code doesn't execute because you got a wrong path.

## Use a terminal
*This is an additional step, you can just skip this.*
Download the [Windows Terminal](https://github.com/microsoft/terminal/releases/) and install it.

This shouldn't take a long time. Then, open your new terminal and open the settings clicking on the `V` down arrow and in default profile, select `Ubuntu`.
You can even get further by clicking on the `Ubuntu` profile and change the settings such as the name or the window title.

> Thank you for reading, have a nice day!
> If you got questions or problems, contact me on GitHub [(tt-thoma)](https://github.com/tt-thoma) or on Discord [(tt_thoma#6939)](https://www.discord.com/app/channels/@me)

**Sources**:
* [Enable WSL](https://www.configserverfirewall.com/windows-10/windows-subsystem-for-linux-2/)
* [Install pip in WSL - www.youtube.com](https://www.youtube.com/watch?v=mfIRe_NMHsY)
* [Install powerline on WSL](https://www.ricalo.com/blog/install-powerline-windows/)
* [Get the `site-packages` directories](https://stackoverflow.com/questions/122327/how-do-i-find-the-location-of-my-python-site-packages-directory)
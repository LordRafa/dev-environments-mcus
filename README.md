# MCUs Development Environment on Docker

This project will help you to deploy a docker container with PlatformIO, the Raspberry PI Pico SDK and the Arduino CLI in your linux machine.

A handy .desktop file is provided to easily start Visual Studio Code and attach it to the container.

USB and serial devices will be available on the container, which means that debugging and flashing tools can be run directly whiting the container. In order to allow this several udev rules will be installed in the local machine to grant proper permissions.

There are several advantages in using this Development Environment:
* MCUs toolchain will be executed in a sandbox, which reduces the risk of messing up things on the host.
* Image toolchain will be updated automatically each Sunday, hence you just need to do a docker pull to get the latest toolchain.
* Easy installation of multiple MCUs toolchain with a single command.
* Visual Studio Code extensions that you install inside the container remains in the container, which makes easy to customize different dev environments with different extensions.

## How to use

In order to use this app you need to install Visual Studio Code and make sure that it is available on the PATH (running **code** on the terminal must open VSCode).

First download the [latest](https://github.com/LordRafa/dev-environments-mcus/releases/latest) release and untar it.

Run **./install.sh** and follow any further instruction.

After the installer finish you will find the MCU Development Environment on your applications list.

The folder **mcu-projects** will be created in you home. It can be used to share the projects between the container and the host.

Enjoy it!!!

In case you want to remove everything that was installed you can run **./uninstall.sh**, which will remove everything but the **mcu-projects** folder.

## Useful links

![workflow](https://github.com/LordRafa/dev-environments-mcus/actions/workflows/cd.yml/badge.svg)

[Dockerhub Project Page](https://hub.docker.com/r/lordrafa/dev-environments-mcus)

## Attibutions

Thanks to the following people to share their work:

* "IC SMD16SQ filled.svg" was created by <a title="W.Rebel, CC BY-SA 3.0 &lt;https://creativecommons.org/licenses/by-sa/3.0&gt;, via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:IC_SMD16SQ_filled.svg">W.Rebel, as CC BY-SA 3.0 <https://creativecommons.org/licenses/by-sa/3.0>, and share via Wikimedia Commons</a>

* The entrypoint is based on Khalifah Shabazz's download-vs-code-server.sh available at [Github Gist](https://gist.github.com/b01/0a16b6645ab7921b0910603dfb85e4fb)

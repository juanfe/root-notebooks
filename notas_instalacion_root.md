

Root v6-16-00

Para la versión de root v6-16-00
Seguí las instrucciones de:

* https://github.com/root-project/root/blob/master/README/INSTALL

* https://github.com/root-project/root/blob/master/README/README

* https://root.cern.ch/build-prerequisites

* https://root.cern.ch/building-root#variables

* https://root.cern.ch/building-root#options

Para la instalación en Debian:

Yo instalé root en el directorio ~/root/v6-18-04

Con el virtualenv jupyter bajo python3, para correrlo, correr el script:

$ ~/jupyter.sh

https://root.cern.ch/how/how-create-rootbook

Lo estoy instalando en un ubuntu bionic min

debootstrap --arch amd64 --variant=minvar bionic jupyter http://archive.ubuntu.com/ubuntu/
o
debootstrap --arch amd64 --variant=buoildd bionic jupyter http://archive.ubuntu.com/ubuntu/

hay que añadir universe al los paquetes oficiales en /etc/apt/source.list:

deb http://us.archive.ubuntu.com/ubuntu bionic main universe

tocaría probar una de las dos anteriores porque no recuerdo el variant de minvar, el de buildd
lo encontré en una página.

Yo creé el usuario jupyter, y lo añadía a los sudoers

Hice una configuración en sudoer para poder ejecutar ciertos comandos en bootstrap
basicamente añadí a /etc/sudoer:

jupyter ALL = NOPASSWD: /usr/bin/apt-get, /usr/bin/dpkg, /usr/bin/su, /usr/bin/pip, /home/jupyter/root/bin/root

Lo anterior no aplicaría en docker creo.

Una vez se tenga hay que instalar los paquetes:

sudo apt-get install vim git dpkg-dev cmake g++ gcc binutils libx11-dev libxpm-dev \
libxft-dev libxext-dev

sudo apt-get install python-dev python-pip

sudo pip install jupyter metakernel zmq

Para instalar root en /usr/local/bin, se necesita instalarlo con el método Fixed Location build,
pero no lo voy a hacer, ahora voy a intentar con el método Location independent build



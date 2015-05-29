# Cloud Workshop

## Requirements

Virtualbox and Vagrant must be installed before setting up the workshop.

On OS X this can be done easily with `brew`:

```
$ brew install caskroom/cask/brew-cask
$ brew cask install virtualbox
$ brew cask install vagrant
```

## Setup

To setup your environment for the workshop, run `vagrant up` in the root of the project.
This downloads quite a lot of stuff so is smart to do on a fast network.

## Nice to know

To stop the virtual machine started with `vagrant up`, you can do `vagrant suspend`. Then to start it again, you can do `vagrant resume`.

When you are finished with the workshop, you can use `vagrant destroy` to remove all traces of the virtual machine.

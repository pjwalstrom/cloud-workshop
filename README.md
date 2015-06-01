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

To make it easier to access the web apps inside the VM, add the following to your `etc/hosts`:

```
19.168.12.34    localdocker
```

With this you can just open `http://localdocker:<port>`.


## Nice to know

To get into the virtual machine, run `vagrant ssh`. The project is mounted onto `/vagrant` inside the
VM, so just go there before running any commands.

To stop the virtual machine started with `vagrant up`, you can do `vagrant suspend`. Then to start it again,
you can do `vagrant resume`. When you are finished with the workshop, you can use `vagrant destroy` to remove
all traces of the virtual machine.


## Tasks

* Run only the backend with in-memory db
  * `docker run ...`
  * access the web app to see that it works (`curl localdocker:9000/person`)
  * list the docker containers
  * kill the docker container
  * start the container in background
  * view the docker log
  * get into the running container
* Run frontend/backend with in-memory db
  * `docker-compose ...`
  * view the logs of all containers
  * stop the containers 
* Run frontend/backend with PostgreSQL
  * `docker-compose -f docker-compose.postgres.yml ...`
  * try to scale backend
* Run frontend/backend with Consul/PostgreSQL
  * start helper containers (`/vagrant/helpers/start_helper_containers.s`)
  * `docker-compose -f docker-compose.consul.yml ...`
  * try to scale backend
* Work with a docker server in the cloud (Digital Ocean)
  * first load the `env_for_digital_ocean.sh` into current shell
  * `docker-machine ...`
  * create a new machine
  * list current machines
  * run docker commands against the new machine
  * start up the application on this machine using `docker-compose`
  * ssh to the machine and run docker
  * destroy this machine
* Run the application on Finn's test Mesos setup
  *

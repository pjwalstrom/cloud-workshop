# Cloud Workshop

## Requirements

Virtualbox and Vagrant must be installed before setting up the workshop.

On OS X this can be done easily with `brew`:

```
$ brew install caskroom/cask/brew-cask
$ brew cask install virtualbox
$ brew cask install vagrant
```

Accounts on [Docker Hub](https://registry.hub.docker.com) and [GitHub](https://github.com) is also necessary.


## Setup

To setup your environment for the workshop, fork this project and clone it locally. Then run
`vagrant up` in the root of the project. This downloads quite a lot of stuff so is smart to
do on a fast network.

To make it easier to access the web apps inside the VM, add the following to your `etc/hosts`:

```
192.168.12.34    localdocker
```

With this you can just open `http://localdocker:<port>`.


## Nice to know

To get into the virtual machine, run `vagrant ssh`. The local project is mounted onto `/vagrant` inside the
VM, so just go there before running any commands (`cd /vagrant`).

To stop the virtual machine started with `vagrant up`, you can do `vagrant suspend`. Then to start it again,
you can do `vagrant resume`. When you are finished with the workshop, you can use `vagrant destroy` to remove
all traces of the virtual machine.


## Tasks

* Run only the backend with in-memory db
    * `docker run ...`
        * check the available images with `docker images` to find the backend image
        * the container should be put in the background (-d)
        * the container's exposed port (see `Dockerfile`) should be mapped onto port 9000 on the VM
        * PJ: docker run -d=true -p=9000:33333 no.finn.workshop.cloud/backend
    * access the web app to see that it works (`curl localdocker:9000/person`)
    * list all running docker containers
    * PJ: docker ps
    * view the docker log for backend
    * docker logs 06f08e2f1a
    * get into the running backend container
    * docker exec -it  06f08e2f1a44 /bin/s
    * kill the backend docker container
    * docker kill 06f08e2f1a44
* Run frontend/backend with in-memory db
    * `docker-compose ...`
    * PJ: docker-compose up -d
        * put them in the background
    * view the logs of both containers (docker logs...)
    * stop both containers (docker kill...)
* Run frontend/backend with PostgreSQL
    * `docker-compose -f docker-compose.postgres.yml ...`
    * docker-compose -f docker-compose.postgres.yml up -d
    * try to scale backend
    * docker-compose scale backend=2 frontend=1
    * look at the logs to see if the second backend is used
    * curl 192.168.12.34:8000
    * what happens and why?
    * servlet initialisert
    * docker-compose kill
    * docker-compose rm
* Run frontend/backend with Consul/PostgreSQL
    * start helper containers (`/vagrant/helpers/start_helper_containers.sh`)
    * `docker-compose -f docker-compose.consul.yml ...`
    * docker-compose -f docker-compose.consul.yml up -d
    * try to scale backend
    * docker-compose scale backend=2 
    * look at the logs to see if the second backend is used
    * docker-compose logs backend
    * what happens and why?
* Work with a docker server in the cloud (Digital Ocean)
    * first load the `helpers/env_for_digital_ocean.sh` into current shell
    * `docker-machine ...`
        * use the Digital Ocean API key you got in mail
    * create a new machine
    * docker-machine create  --digitalocean-access-token  76e90400907b9166e9474387b8ae5cdf30b0342b9a40600c58963de2f4c8c7e9 --driver=digitalocean foo 
    * list current machines
    * docker-machine ssh foo
    * run docker commands against the new machine
    * eval "$(docker-machine env foo)"
    * ./gradlew build
    * start up frontend/backend with PostgreSQL on this machine using `docker-compose`
    * ssh to the machine and run docker
    * destroy this machine
    * docker-machine rm -f foo

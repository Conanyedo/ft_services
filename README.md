# Ft_Services

This project is an introduction to Kubernetes, we will discover cluster management, deployment with Kubernetes, virtualizing a network and do "clustering". 

## Description

The project consists of setting up an infrastructure of different services. To do this, you
must use Kubernetes. You will need to set up a multi-service cluster.
Each service will have to run in a dedicated container.
Each container must bear the same name as the service concerned and for performance
reasons, containers have to be build using Alpine Linux.
Also, they will need to have a Dockerfile written by you which is called in the setup.sh.
You will have to build yourself the images that you will use. It is forbidden to take
already build images or use services like DockerHub.

# Compenents
- `MetalLB` a Load Balancer that manages external access to its services. It is the only entrance to the cluster.
- `Nginx` server listening on ports 80 and 443. Allowing access to `/wordpress` redirection `IP:WPPORT` and `/phpmyadmin` reverse proxy to `IP:PMAPORT`.
- `WordPress` website listening on port 5050, which will work with a `MySQL` database running in a separate container.
- `PhpMyAdmin` listening on port 5000 and linked with the `MySQL` database.
- `FTPs` server listening on port 21.
- `Grafana` platform that monitor all containers, listening on port 3000, linked with an `InfluxDB` database.

# Technologies
- `Docker` an open-source project that automates the deployment of applications within software containers.
- `Kubernetes` an open-source system for automating the deployment, scaling, and handling of containerized applications.
- `Minikube` a tool that lets you run kubernetes locally. minikube runs a single-node kubernetes cluster on your personal computer.
- `VirtualBox` a virtualization software for x86/amd64 architectures.
- `Alpine Linux`  a Linux distribution based on  BusyBox, which aims to be lightweigth and secure by default.


## Usage
- git clone the repository
- `cd` into the directory and run `./setup.sh`

```bash
./setup.sh
```

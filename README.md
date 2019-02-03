# Features
This image contains pytorch, jupyter notebook, tensorboardx, and other useful python packages (See Dockerfile).  
Once instantiated, it'll run a jupyter notebook server for you (See start.sh). 

Default workdir is /workspace which is the root folder for jupyter notebook.  
You can mount the folder in your host os to /workspace.  

You can run this image with your own user/group. So that the files created won't change the owner/group to root.  

# Requirements
You'll need nvidia-docker v2 to run with gpu support.  
And for the driver issue please refer to FAQs.  

# Example Usage

```bash
$ NV_GPU=0,1 nvidia-docker run -it \
--name testorch \
-u $(id -u ${USER}):$(id -g ${USER}) \
-v $PWD:/workspace \
jxcodetw/jupyter-pytorch

# arguments
# NV_GPU controls gpu isolation
# --name [your custom name]
# -u save file with permission as current user
# $PWD mount current directory to jupyter's startup folder (/workspace)
```

# FAQs

In this FAQ, there are the solutions I used but not necessarily the best approaches :p.

## Which Nvidia driver version to use?
This image inherited from pytorch/pytorch:latest. You should check the cuda version they used.
https://hub.docker.com/r/pytorch/pytorch  
I guess they build the image from this file in their source code repository.  
https://github.com/pytorch/pytorch/blob/master/docker/pytorch/Dockerfile

By the time this image is created they use **nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04**
https://hub.docker.com/r/nvidia/cuda/  

And some CUDA version might need specific version of driver to work.  
For your information, the output from my nvidia-smi is:
```bash
NVIDIA-SMI 410.78       Driver Version: 410.78       CUDA Version: 10.0
```

## How to get token for jupyter notebook?
you just run with -it flags and you will attach to the container and see the output from jupyter notebook.  
After copying the token, press Ctrl+P, Ctrl+Q to detach from the container.

If you start the container with -dit flags then you should print the logs to get the token.  
```bash
$ docker logs [container name or id]
```

## How do I know the container's IP address?
To access the notebook you'll need to know the ip of the container and connect to the 8888 port.  
```bash
$ docker inspect -f \
'{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' \
[container name or id]
```
Then you can access the jupyter notebook via http://172.x.x.x/?token=asdfasdfasdf...asdf

If you run the container on your remote server and you want to access to it on your local machine.  
You can use ssh tunnels:
```bash
ssh -L [local_port]:172.x.x.x:8888 [user]@[server-ip]
# if you want to learn more what it is. There's a tons of tutorial on the int.ernet
```
Then open your browser to http://localhost:[local_port]/?token=asdfadsfasdf...asdf

## How do I set the visible GPUs in container?
Reference: https://github.com/NVIDIA/nvidia-docker/wiki/nvidia-docker#gpu-isolation
```bash
$ NV_GPU=0,1 nvidia-docker ...

# For example, if you have two gpus on your computer
$ NV_GPU=0 nvidia-docker ... # first container
$ NV_GPU=1 nvidia-docker ... # second container
```

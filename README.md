# Usage

```bash
$ nvidia-docker run -it \
--name testorch \
-u $(id -u ${USER}):$(id -g ${USER}) \
-v $PWD:/workspace \
jxcodetw/jupyter-pytorch

# arguments
# --name [your custom name]
# -u save file with permission as current user
# $PWD mount current directory to jupyter's startup folder (/workspace)
```

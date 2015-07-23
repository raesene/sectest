SecTest
========

A Docker build focused on security testing...

There's quite a few of these around now, this one is mine :)

using this is fairly easy

docker run -i -t --name <container_name> raesene/sectest /bin/bash 

will give you an interactive shell with tools installed the <container_name> should be a name for the instance (for example the name of a test you're doing).  If you exit the shell you can then restart the conainer with

docker start -a -i <container_name>


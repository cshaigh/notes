docker pull alpine

docker run --interactive --name=myfiglet --tty alpine sh

## INSIDE CONTAINER

apk add figlet
exit

## /INSIDE CONTAINER

# list recently exited container
docker container list --all

<#

CONTAINER ID        IMAGE                          COMMAND                  CREATED             STATUS                     PORTS               NAMES
c525bc0a7d86        alpine                         "sh"                     5 minutes ago       Exited (0) 2 minutes ago                       myfiglet

#>

# commit this change to custom repository
docker commit --author "Chris Haigh <cshaigh1981@gmail.com>" --message "Added figlet" myfiglet devopshaigh/myfiglet
<#

    sha256:e37977bcc2dc58e40afaff2fc2f8486cfbce15cf40a5bfc0b5679b9d55574eb9

#>

# verify history
docker history --human devopshaigh/myfiglet
<#

    IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
    e37977bcc2dc        4 minutes ago       sh                                              1.94MB              Added figlet
    3f53bb00af94        3 weeks ago         /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B
    <missing>           3 weeks ago         /bin/sh -c #(nop) ADD file:2ff00caea4e83dfad…   4.41MB

#>

# test our new container's figlet functionality
docker run --tty devopshaigh/myfiglet figlet "Hello World!"

# why not make an alias too...?

# cmd / bash
alias figlet=docker run --tty devopshaigh/myfiglet figlet

# can then test using an alias
figlet "Hello World!"

# NEXT let's do this again with a Dockerfile
# (see .\Dockerfile)
docker build --tag devopshaigh/myfiglet:built .
<#

    Sending build context to Docker daemon  5.632kB
    Step 1/2 : FROM alpine
    ---> 3f53bb00af94
    Step 2/2 : RUN apk add figlet
    ---> Using cache
    ---> 534f26bf7260
    Successfully built 534f26bf7260
    Successfully tagged devopshaigh/myfiglet:built
    SECURITY WARNING: You are building a Docker image from Windows against a non-Windows Docker host. All files and directories added to build
    context will have '-rwxr-xr-x' permissions. It is recommended to double check and reset permissions for sensitive files and directories.

#>

# confirm this image is in your image list
docker image list
<#

    REPOSITORY                                         TAG                 IMAGE ID            CREATED             SIZE
    devopshaigh/myfiglet                                 built               534f26bf7260        19 minutes ago      6.35MB

#>

# push up to docker hub
docker push devopshaigh/myfiglet:built
<#

    The push refers to repository [docker.io/devopshaigh/myfiglet]
    ab7e9e7e2eb6: Pushed
    7bff100f35cb: Mounted from library/bash
    built: digest: sha256:f340cb86241de966fbfde06ddba1d86356e801f01706799c6ec85bb7e5f29cb8 size: 739

#>

# TODO: find this on docker hub

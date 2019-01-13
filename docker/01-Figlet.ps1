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
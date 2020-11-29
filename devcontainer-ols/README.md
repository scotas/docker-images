# VS Code Remote Project for Scotas OLS

<table style="width: 100%; border-style: none;"><tr>
<td style="width: 140px; text-align: center;"><a href="https://aka.ms/vscode-remote/download/extension"><img width="128px" src="https://microsoft.github.io/vscode-remote-release/images/remote-extensionpack.png" alt="Visual Studio Code logo"/></a></td>
<td>
<strong>Visual Studio Code Remote Development</strong><br />
<i>Open your code in the cloud, in a local container, on a remote machine, or in WSL and take advantage of VS Code's full feature set.
</td>
</tr></table>

A **development container** is a running [Docker](https://www.docker.com) container with a well-defined tool/runtime stack and its prerequisites. The [VS Code Remote - Containers](https://aka.ms/vscode-remote/download/containers) extension allows you to clone a repository or open any folder mounted into (or already inside) a dev container and take advantage of VS Code's full development feature set.

## Required Docker Images

- oracle/database:18.4.0-xe is required before running this project, built it using [Oficial Oracle Docker images](https://github.com/oracle/docker-images/tree/master/OracleDatabase/SingleInstance)

```console
$ docker image ls|grep oracle
oracle/database                                                    18.4.0-xe                  6acb249d39ba        4 months ago        5.87GB
```

## Using Docker Extension on Dev Container

To use Docker Extension for VSCode when using this project you have to check that the group id of docker is equal to the enviroment variable defined in [docker-compose.yml](.devcontainer/docker-compose.yml#L14) file *DOCKER_GID: 999*

## Persistent volume for your Oracle Datafiles

Among with the dev container an Oracle RDBMS XE database is started if you want to re-use RDBMS datafiles across other containers check mount volume defined on [docker-compose.yml](.devcontainer/docker-compose.yml#L44):

- /home/data/db/xe-18c:/opt/oracle/oradata

```console
root@pocho:~# chown 54321:54321 /home/data/db/xe-18c
root@pocho:~# ls -ltra /home/data/db/xe-18c
total 8
drwxr-xr-x 11 root   root     4096 jul  2 19:29 ..
drwxr-xr-x  2 oracle oinstall 4096 jul  2 19:29 .
```

## Sources included in this image

By default this dev container project is using tag *v2.0.5* when building the image, you can change to other tagged release by changing *BRANCH: "v2.0.5"* argument in [docker-compose.yml](.devcontainer/docker-compose.yml#L11) file.

# Known caveats

If you get this message when finishing the build process *Error: EACCES: permission denied, mkdir '/tmp/vsch/extensionsCache' just push button Retry on showed dialog.


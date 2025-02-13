# README

## Description
It is a project conversation history. A user should be able to:

* leave a comment
* change the status of the project

The project conversation history should list comments and changes in status.

## Features
* Rails 7
* Ruby 3.2.1
* Dockerfile and Docker Compose configuration
* PostgreSQL database
* Rubocop for linting
* Rspec & Factorybot
* Slim view engine
* GitHub Actions for
  * tests
  * lint

## Screenshots
![Alt text](/screenshots/login.png?raw=true "Login screen")
![Alt text](/screenshots/projects.png?raw=true "Projects list screen")
![Alt text](/screenshots/edit_project.png?raw=true "Edit status of project screen")
![Alt text](/screenshots/show_project.png?raw=true "Show project screen")
![Alt text](/screenshots/add_comment.png?raw=true "Add new comment screen")


## Requirements

Please ensure you have docker & docker-compose

https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/How-to-install-Docker-and-docker-compose-on-Ubuntu

https://dockerlabs.collabnix.com/intermediate/workshop/DockerCompose/How_to_Install_Docker_Compose.html

Check your docker compose version with:
```
% docker compose version
Docker Compose version v1.27.4
```

## Initial setup
```
$ cp .env.example .env
$ cd docker
$ docker-compose --env-file ../.env build
```

## Running the Rails app
```
$ docker-compose --env-file ../.env up
```

## Running the Rails console
When the app is already running with `docker-compose` up, attach to the container:
```
$ docker-compose exec app bin/rails c
```
When no container running yet, start up a new one:
```
$ docker-compose run --rm app bin/rails c
```

## Seeds
```
Already will run within the docker and the credentials are:

email: manjaree@gmail.com   password: 12345678
email: say@gmail.com   password: 12345678
```
## Author

**Mohamed Nabil**

- <https://www.linkedin.com/in/mohamed-nabil-a184125b>
- <https://github.com/mohamednabil00000>
- <https://leetcode.com/mohamednabil00000/>

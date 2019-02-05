# Containerised Ansible Tower

A docker image that runs Ansible Tower in standable mode.

## How to use

### Run in detached mode

`docker run -d -p 443:443 shawnxlw/cat`

### Run in detached mode with data persistance (recommended)

`docker run -d -p 443:443 -v cat_db:/var/lib/postgresql/9.6/main -v cat_license:/etc/tower/license shawnxlw/cat`

## Logins

URL: https://localhost

Username: admin

Password: redhat

## Release notes

5/2/19: Initial release

* Ansible Tower: v3.4.1

* Ansible: v2.7
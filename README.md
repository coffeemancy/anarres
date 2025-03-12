# anarres

Superliminal configuration of my workstations with ansible.

The author's current target systems are running [EndevaourOS][endevaouros] "Mercury" (2025) on x86.

## usage

This repo uses [`ansible`][ansible] to manage configuration on the Arch-based Linux system
it's running on (i.e. localhost).

The recommended approach is to:

1. Install [`pipx`][pipx]
1. Use `pipx` to install [`ansible`][ansible]

This bootstrapping can be achieved with the below commands:

```bash
sudo pacman -S python-pipx
pipx install --include-deps ansible --pip-args "-c constraints.txt"
```

Then, the playbook can be applied as a specified user (i.e. "user" below):

```bash
ansible-playbook anarres.yml -b -i inv -u user
```

## development and testing

Development and testing entails running `ansible` inside of `docker` containers using `docker-compose`.
These tests are also run on PRs via Github Actions (located in `.github/workflows` directory).

Setting up the recommended development environment entails:

1. Installing [`pyenv`][pyenv]
1. Using `pyenv install` to install python
1. Installing [`poetry`][poetry] via `pipx`
1. Installing dependencies with `poetry` into a virtualenv

> [!NOTE]
> When `ansible` is run on localhost, it actually will install `pyenv` and `poetry`,
> and install python(s) with `pyenv`. 

With `pyenv` and `poetry` installed, the below commands should set up a dev env:

```bash
pyenv exec python -m venv .venv
source .venv/bin/activate
poetry install
```

[ansible]: https://github.com/ansible/ansible
[endeavouros]: https://endeavouros.com/
[pipx]: https://github.com/pypa/pipx 
[poetry]: https://github.com/python-poetry/poetry


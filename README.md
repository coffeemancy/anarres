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

Customizations can be made in the vars file `vars.yaml`.

Then, the playbook can be applied as a specified user (i.e. "user" below):

```bash
ansible-playbook anarres.yaml -K -i inv -u user --extra-vars "@vars.yaml"
```

## development and testing

Development and testing entails:

1. Making local changes
1. Checking "PR tests" pass locally (equivalent to Github Actions workflows which run on PRs)
1. Open Pull Request on Github from a dev branch into `main`
1. Once PR tests pass, merging PR to `main` 

Setting up the recommended development environment entails:

1. Installing [`pyenv`][pyenv]
1. Using `pyenv install` to install python
1. Installing [`poetry`][poetry] via `pipx`
1. Installing dependencies with `poetry` into a virtualenv

> [!NOTE]
> Using the playbook in this repo, when `ansible-playbook` is run against localhost, it actually will
> install `pyenv` and `poetry`, and install python(s) with `pyenv`. 

With `pyenv` and `poetry` installed, the below commands should set up a dev env:

```bash
pyenv exec python -m venv .venv
source .venv/bin/activate
poetry install
```

### running PR-equivalent tests locally

With a working dev env, local equivalents to tests run on Pull Requests via Github Action can be run locally:

```bash
./tests/pr-tests.sh
```

These tests are intended to cover the same checks as defined in the `.github/workflows/pr-*.yaml` files.

For convenience, it is recommended to set these up as a commit (or push) hook, e.g. with:

```bash
ln -s ../../tests/pr-tests.sh .git/hooks/pre-commit
```

[ansible]: https://github.com/ansible/ansible
[endeavouros]: https://endeavouros.com/
[pipx]: https://github.com/pypa/pipx 
[poetry]: https://github.com/python-poetry/poetry

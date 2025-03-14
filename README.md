# anarres

Superliminal configuration of my workstations with ansible.

The author's current target systems are running [EndevaourOS][endeavouros] "Mercury" (2025) on x86.

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

Customizations can be made in the vars file `vars.yaml`. An example in `examples/var.yamls` is provided, which
can be copied into the checkout directory and modified.

Then, the playbook can be applied as a specified user (i.e. "user" below):

```bash
ansible-playbook anarres.yaml -K -i inv -u user -e @vars.yaml"
```

This will prompt for a "become password" to `sudo` for installing system packages.

Alternatively, a password file or script can be used to supply the become password. An example script
in `examples/become.pass` is provided, which can be copied and modified as needed and used:

```bash
ansible-playbook anarres.yaml -i inv -u user -e "@vars.yaml" --become-pass-file become.pass
```

### ansible-vault

Additionally, an ansible vault can be used to encrypt the (partial) contents of `vars.yaml`, which requires
supplying a vault password when appyling the playbook. An example script in `examples/vault.pass` is provided,
which can be copied and modified as necessary.

An encrypted vault can be created from a (partial) `vars.yaml` file as follows:

```bash
ansible-vault encrypt --vault-pass-file vault.pass vars.yaml --output vault.yaml
```

Further [details about using `ansible-vault`][ansible-vault] is provided in upstream docs.

The below uses files/scripts for "become" and `ansible-vault`, with some vars in `vars.yaml` and others encrypted
in `vault.yaml`:

```bash
ansible-playbook anarres.yaml -i inv -u user -e "@vars.yaml" -e "@vault.yaml" \
  --become-pass-file become.pass --vault-pass-file vault.pass 
```

> ![INFO]
> As an alternative to running `ansible-playbook` directly, a helper script `anarres.sh` is provided, which
> builds the arguments automatically based on the prescence of `vars.yaml` and `vault.yaml`.

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

> [!NOTE]
> In general, actually applying the playbook with `ansible-playbook` should be done _outside_ of this virtualenv,
> since `pipx` is installed at the system level.

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
[ansible-vault]: https://docs.ansible.com/ansible/latest/cli/ansible-vault.html
[endeavouros]: https://endeavouros.com/
[pipx]: https://github.com/pypa/pipx
[poetry]: https://github.com/python-poetry/poetry

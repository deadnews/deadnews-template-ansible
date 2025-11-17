.PHONY: all clean default install update check pc lint test molecule

default: check


install:
	uv sync
	uv run ansible-galaxy install -r requirements.yml

update:
	uv sync --upgrade
	uv run galaxy-update requirements.yml
	prek auto-update

check: pc
pc:
	prek run -a

lint:
	uv run ansible-lint

test:
	uv run pytest

test-ci:
	uv run pytest -rP -p no:warnings -m docker --molecule roles

# make molecule ROLE=<role>
molecule:
	pushd roles/$(ROLE) && uv run molecule test -s $(ROLE); popd

# make molecule-vg ROLE=<role>
molecule-vg:
	pushd roles/$(ROLE) && uv run molecule test -s $(ROLE)_vagrant; popd

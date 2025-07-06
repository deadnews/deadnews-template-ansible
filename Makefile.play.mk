.PHONY: all clean test
.ONESHELL:

ping:
	uv run ansible-playbook playbooks/ping.yml

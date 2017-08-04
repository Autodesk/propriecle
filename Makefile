test:
	pep8 propriecle
	pylint --rcfile=/dev/null propriecle
	vulture propriecle propriecle.py

.PHONY: test

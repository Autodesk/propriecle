test:
	pep8 propriecle
	pylint --rcfile=/dev/null propriecle
	vulture propriecle propriecle.py

version:
	cp version propriecle/version

package: version
	python setup.py sdist

.PHONY: test

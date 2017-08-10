test: testenv
	coverage erase
	pep8 propriecle || true
	pylint --rcfile=/dev/null propriecle || true
	vulture propriecle propriecle.py
	bandit -r propriecle propriecle.py
	test -z $(TRAVIS) && (./scripts/integration) || true
	coverage report -m
	coverage erase

testenv:
	test -z $(TRAVIS) && (test -d .ci-env || ( mkdir .ci-env && virtualenv .ci-env )) || true
	test -z $(TRAVIS) && \
		(echo "Non Travis" && .ci-env/bin/pip install -r requirements.txt -r requirements-dev.txt --upgrade) || \
		(echo "Travis" && pip install -r requirements.txt -r requirements-dev.txt)

version:
	cp version propriecle/version

package: version
	python setup.py sdist

.PHONY: test package version testenv

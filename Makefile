test: testenv
	pep8 propriecle
	pylint --rcfile=/dev/null propriecle
	vulture propriecle propriecle.py

testenv:
	test -z $(TRAVIS) && (test -d .ci-env || ( mkdir .ci-env && virtualenv .ci-env )) || true
	test -z $(TRAVIS) && \
		(echo "Non Travis" && .ci-env/bin/pip install -r requirements.txt -r requirements-dev.txt --upgrade) || \
		(echo "Travis" && pip install -r requirements.txt -r requirements-dev.txt)

version:
	cp version propriecle/version

package: version
	python setup.py sdist

.PHONY: test

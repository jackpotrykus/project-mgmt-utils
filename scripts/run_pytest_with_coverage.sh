#!/usr/local/bin/bash


usage ()
{
	cat << EOF
+-----------------------------+
X run_pytest_with_coverage.sh X
+-----------------------------+

Usage:
	[-t] test directory
	[-p] python package scope to use in coverage
EOF
}

parse_args ()
{
	while getopts p:t:w:v: flag
	do
		echo "Hello again"
		case "${flag}" in
			p) PYTHON_PACKAGE=${OPTARG};;
			t) TEST_DIRECTORY=${OPTARG};;
			w) WRITE_FILEPATH=${OPTARG};;
			v) VENV_DIRECTORY=${OPTARG};;
		esac
	done
}


run_tests ()
{
	local res=$(python -m pytest $1 --cov $2 --cov-report term-missing)
	if [ ! -z "$3" ]; then
		echo "$res" > "$3"
	else
		echo "$res"
	fi
}

main ()
{
	parse_args $@
	if [ -z $TEST_DIRECTORY ] || [ -z $PYTHON_PACKAGE ]; then usage; fi
	if [ ! -z $VENV_DIRECTORY ]; then source "$VENV_DIRECTORY/bin/activate"; fi
	run_tests $TEST_DIRECTORY $PYTHON_PACKAGE $WRITE_FILEPATH
}

main $@

function gen_pigar ()
{
	pigar -p "requirements.txt" -P $1 $2
}

function usage ()
{
	cat <<EOF
USAGE
=====

./gen_requirements.txt <project_dir>
EOF
}

function main ()
{
	if [ $# -ne 1 ]; then
		usage
	else
		pigar -p "requirements.txt" -P $1 -o ">="
		pigar -p "dev_requirements.txt" -P $1 -o "=="
	fi
}

main $1

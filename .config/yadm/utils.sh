#! /bin/bash

# check that all args passed to this function are commands on the $PATH
check_prerequisites() {
	prerequisites=("$@")
	missing=0
	echo "Checking prerequisite(s)..."
	for p in "${prerequisites[@]}"; do
		echo -n "$p ..."
		if command -v "$p" >/dev/null; then
			echo "✔ "
		else
			echo "❌"
			((missing++))
		fi
	done
	if [ $missing -gt 0 ]; then
		echo "Missing $missing prerequisite(s)..."
		echo "Install them and try again!"
		exit 1
	fi
	echo "All Prerequisites Detected!"
}

user_confirmation() {
	question=$1
	while true; do
		read -rp "$question (y/n)" user_input
		if [ "$user_input" == "y" ]; then
			return 0
		elif [ "$user_input" == "n" ]; then
			return 1
		else
			echo "Please input 'y' or 'n'. Press Ctrl+C to force exit"
		fi
		sleep 0.5
	done
}

error_handler() {
	echo "Bootstrap encountered an error! Exiting..."
	exit 1
}

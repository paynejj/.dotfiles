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

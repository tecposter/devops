#!/bin/bash

function is_installed {
	dpkg-query -W -f='${Status}' $1 2>/dev/null | grep -c "ok installed"
}

#!/bin/bash
#Moving on my-project/scripts
mv *.sh my-project/scripts/

mv *.py *.sh *.bash my-project/scripts/



if [ ! -d "scripts" ]; then
	echo "create directory scripts..."
	mkdir scripts
	if [ $? -ne 0 ]; then
		echo "error creating directory scripts" 
		exit 1
	fi
fi

echo "move scripts"
for script in *.sh; do
	if [ -f "$scripts" ]; then
		mv "$scripts" "scripts/"
		echo "movement to: $scripts"
	fi
done 

echo "all scripts is moving on scripts"

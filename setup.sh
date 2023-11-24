#!/usr/bin/env bash

# Run this script to rename the project with your own name.

# Check for required input
if [ $# -eq 0 ]; then
    echo "Usage: ./setup.sh <project_name>"
    exit 1
fi

PROJECT_NAME=$1

# Find all occurences of cl-example inside the .asd files with the new name.
echo "Renaming system cl-example to cl-${PROJECT_NAME}..."
find . -type f -name "*.asd" -exec sed -i '' "s/cl-example/cl-${PROJECT_NAME}/g" {} \;

# Find all occurences of example inside the .lisp files with the new name.
echo "Renaming package example to ${PROJECT_NAME}..."
find . -type f -name "*.lisp" -exec sed -i '' "s/example/${PROJECT_NAME}/g" {} \;

# Rename the files accordingly.
echo "Renaming files..."
mv cl-example.asd cl-${PROJECT_NAME}.asd
mv cl-example.test.asd cl-${PROJECT_NAME}.test.asd
mv src/example.lisp src/${PROJECT_NAME}.lisp

# Ask to nuke the .git folder.
echo "Do you want to reset the .git folder? [y/N]"
read -r response

if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
    rm -rf .git
    git init
    echo "Done."
else
    echo "Don't forget to remove the .git folder yourself!"
fi

# Ask to remove this script.
echo "Do you want to remove this script? [y/N]"
read -r response

if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
    rm setup.sh
    echo "Done."
else
    echo "Don't forget to remove this script yourself!"
fi

echo "Done. Only thing left is to update the README.org file."

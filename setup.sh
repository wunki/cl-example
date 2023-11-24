#!/usr/bin/env bash

# Ask for the project name and store it in a variable.
echo "What is the name of the project? Please use the name without the cl- prefix."
read -r PROJECT_NAME

# What is your full name?
echo "What is your full name?"
read -r AUTHOR_NAME

# What is your email address?
echo "What is your email address?"
read -r AUTHOR_EMAIL

# Replace the ${PROJECT_NAME} placeholder in all org files with the title cased project name.
TITLE_CASED_PROJECT_NAME=$(echo "${PROJECT_NAME}" | perl -pe 's/(^|_)./uc($&)/ge;s/_/ /g')
echo "Replacing placeholders in all template files..."
find . -type f -name "*.org" -exec sed -i '' "s/\${PROJECT_NAME}/${TITLE_CASED_PROJECT_NAME}/g" {} \;
find . -type f -name "*.org" -exec sed -i '' "s/\${AUTHOR_NAME}/${AUTHOR_NAME}/g" {} \;
find . -type f -name "*.org" -exec sed -i '' "s/\${AUTHOR_EMAIL}/${AUTHOR_EMAIL}/g" {} \;

# Update the LICENSE file with the current year and the author name and email.
CURRENT_YEAR=$(date +"%Y")
sed -i '' "s/\${AUTHOR_NAME}/${AUTHOR_NAME}/g" LICENSE
sed -i '' "s/\${AUTHOR_EMAIL}/${AUTHOR_EMAIL}/g" LICENSE
sed -i '' "s/\${CURRENT_YEAR}/${CURRENT_YEAR}/g" LICENSE

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
mv README.template.org README.org

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

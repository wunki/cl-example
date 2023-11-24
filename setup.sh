#!/usr/bin/env bash

# Function to escape special characters
escape_input() {
    local input=$1
    echo "$input" | sed -e 's/[\/&]/\\&/g'
}

# Function to get user input
get_input() {
    local prompt=$1
    local var_name=$2
    echo "$prompt"
    read -r $var_name
}

# Function to update placeholders with supplied extension.
update_placeholders() {
    local extension=$1
    find . -type f -name "*.$extension" -exec sed -i '' \
        -e "s/\${TITLE_CASED_PROJECT_NAME}/$TITLE_CASED_PROJECT_NAME/g" \
        -e "s/\${PROJECT_NAME}/$PROJECT_NAME/g" \
        -e "s/\${PROJECT_DESCRIPTION}/$ESCAPED_PROJECT_DESCRIPTION/g" \
        -e "s/\${PROJECT_WEBSITE}/$ESCAPED_PROJECT_WEBSITE/g" \
        -e "s/\${AUTHOR_NAME}/$AUTHOR_NAME/g" \
        -e "s/\${AUTHOR_EMAIL}/$AUTHOR_EMAIL/g" {} \;
}

# Function to update the LICENSE file.
update_license() {
    sed -i '' \
        -e "s/\${AUTHOR_NAME}/$AUTHOR_NAME/g" \
        -e "s/\${AUTHOR_EMAIL}/$AUTHOR_EMAIL/g" \
        -e "s/\${CURRENT_YEAR}/$CURRENT_YEAR/g" LICENSE
}

# Function to rename files.
rename_files() {
    mv cl-example.asd cl-${PROJECT_NAME}.asd
    mv cl-example.test.asd cl-${PROJECT_NAME}.test.asd
    mv src/example.lisp src/${PROJECT_NAME}.lisp
    mv README.template.org README.org
    mv NOTES.template.org NOTES.org
}

# Get inputs
get_input "What is the name of the project? Please use the name without the cl- prefix." PROJECT_NAME
get_input "What's a short description of the project?" PROJECT_DESCRIPTION
get_input "What's the website of the project?" PROJECT_WEBSITE
get_input "What is your full name?" AUTHOR_NAME
get_input "What is your email address?" AUTHOR_EMAIL

# Escape special characters in inputs
ESCAPED_PROJECT_DESCRIPTION=$(escape_input "$PROJECT_DESCRIPTION")
ESCAPED_PROJECT_WEBSITE=$(escape_input "$PROJECT_WEBSITE")

# Convert project name to title case
TITLE_CASED_PROJECT_NAME=$(echo "${PROJECT_NAME}" | perl -pe 's/(^|_)./uc($&)/ge;s/_/ /g')

# Update placeholders
echo "Replacing placeholders in all template files..."
update_placeholders org
update_placeholders asd
update_placeholders lisp

# Update the LICENSE file with the current year and author details
CURRENT_YEAR=$(date +"%Y")
update_license

# Renaming system and package names
echo "Renaming system cl-example to cl-${PROJECT_NAME}..."
echo "Renaming package example to ${PROJECT_NAME}..."

# Rename the files
echo "Renaming files..."
rename_files

# Reset .git folder
echo "Do you want to reset the .git folder? [y/N]"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
    rm -rf .git && git init && echo "Git repository reset."
fi

# Remove this script
echo "Do you want to remove this script? [y/N]"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
    rm setup.sh && echo "Setup script removed."
fi

echo "Setup complete. Please update the README.org file as needed."

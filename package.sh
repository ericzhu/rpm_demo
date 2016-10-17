#!/bin/bash

# example of using arguments to a script
echo ================================================
echo ========= GENERATE EVM INSTALLATION RPM ========
echo ================================================

export SOURCE_DIR=$1
export TRAGET_DIR=$2
export SPEC_TEMPLATE_FILE_NAME=spec_template.tpl
export SPEC_FILE_NAME=evm.spec
export SOURCE_DIRECTORY=evm
export TEMP_FOLER_NAME=temp
export EVM_PACKAGE_FILE_NAME=evm.tar.gz
export PACKAGE_NAME=evm
export PACKAGE_VERSION=1.0
export BUILD_DIRECTORY=rpmbuild

# ------------------------------------------------
# Collect the artifacts (ears) and package them into a zip file
# ------------------------------------------------



# ------------------------------------------------
# Clean working directory
# ------------------------------------------------

printf 'CLEAN BUILDING ENVIRONMENT - START\n'

if [ -f ~/spec_template.tpl ]; then
    printf '%s\n' "Removing specification template file ..."
    rm ~/spec_template.tpl
fi

cp spec_template.tpl ~
cd ~

if [ -f "$SPEC_FILE_NAME" ]; then
    printf '%s\n' "Removing specification file ($SPEC_FILE_NAME) ..."
    rm "$SPEC_FILE_NAME"
fi

if [ -d "$BUILD_DIRECTORY" ]; then
    printf '%s\n' "Removing build directory ($BUILD_DIRECTORY) ..."
    rm -rf "$BUILD_DIRECTORY"
fi

printf 'CLEAN BUILDING ENVIRONMENT - END\n\n\n'


# ------------------------------------------------
# Create rpm build directories
# ------------------------------------------------

printf 'PREPARE BUILDING ENVIRONMENT - START\n'

mkdir "$BUILD_DIRECTORY"
cd "$BUILD_DIRECTORY"
mkdir BUILD RPMS SOURCES SPECS SRPMS
cd ..

# ------------------------------------------------
# Create specification file from template
# ------------------------------------------------

sed -e "s/\${NAME}/$PACKAGE_NAME/" -e "s/\${VERSION}/$PACKAGE_VERSION/" -e "s/\${SOURCE}/$EVM_PACKAGE_FILE_NAME/" $SPEC_TEMPLATE_FILE_NAME >$SPEC_FILE_NAME

tar -zcvf "$EVM_PACKAGE_FILE_NAME" "$SOURCE_DIRECTORY/"
cp "$EVM_PACKAGE_FILE_NAME" "$BUILD_DIRECTORY/SOURCES"

printf 'PREPARE BUILDING ENVIRONMENT - END\n\n\n'


# ------------------------------------------------
# Copy zip file to build folder
# ------------------------------------------------
cp "$EVM_PACKAGE_FILE_NAME" "$BUILD_DIRECTORY/BUILD/"

# ------------------------------------------------
# Copy specification file to spec folder
# ------------------------------------------------
cp "$SPEC_FILE_NAME" "$BUILD_DIRECTORY/SPECS/"

# ------------------------------------------------
# Run build command to generate the RPM
# ------------------------------------------------
rpmbuild -v -bb rpmbuild/SPECS/evm.spec

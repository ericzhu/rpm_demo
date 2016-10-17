#!/bin/bash

# example of using arguments to a script
echo ================================================
echo ========= GENERATE EVM INSTALLATION RPM ========
echo ================================================

export SOURCE_DIR=$1
export TRAGET_DIR=$2

export SPEC_TEMPLATE_FILE_NAME=spec_template.tpl
export SPEC_FILE_NAME=evm.spec

export TEMP_FOLER_NAME=temp



echo "Source directory : $SOURCE_DIR"
echo "Target directory : $TRAGET_DIR"
echo "Template file    : $SPEC_TEMPLATE_FILE"

rm $SPEC_FILE_NAME


# Collect the artifacts (ears) and package them into a zip file



# Create rpm build directories
mkdir rpmbuild
cd rpmbuild
mkdir BUILD RPMS SOURCES SPECS SRPMS
cd ..

# Create specification file from specification template
sed -e "s/\${VERSION}/1-TEST-VERSION/" -e "s/\${word}/dog/" $SPEC_TEMPLATE_FILE_NAME >$SPEC_FILE_NAME

tar -zcvf evm.tar.gz evm/

# Copy zip file to build folder

# Run build command to generate the RPM

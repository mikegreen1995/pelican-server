#!/usr/bin/env bash


echo "Performing environment setup..."
ORIGINAL_DIRECTORY="`pwd`"
LOCAL_DIRECTORY="`dirname ${0}`"
cd ${LOCAL_DIRECTORY}
VENV_DIR=venv
if [[ ! -d "$VENV_DIR" ]]; then
    echo "$VENV_DIR directory not detected. Creating virtual environment..."
    virtualenv ${VENV_DIR}
fi
source ${VENV_DIR}/bin/activate
pip3 install -r requirements.txt


echo "Running tests..."
if pytest ; then
    echo "Tests completed successfully."
else
    echo "Tests failed. Launch aborted."
    exit 1
fi


echo "Launching Pelican Server..."
python3 src/pelicanserver.py


echo "Performing environment teardown..."
deactivate
cd ${ORIGINAL_DIRECTORY}
echo "Pelican Server terminated."

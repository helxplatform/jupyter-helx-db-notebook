#!/usr/bin/bash

set -x

echo "Executing in directory " `pwd`

HOME_PATH="/home/jovyan"
USER_PATH="/home/${USER_NAME}"

# Create a soft link
function make_soft_link() {
    echo "Making softlink from /home/${USER_PATH} to /home/${HOME_PATH} in " `pwd`
    ln -s ${USER_PATH} ${HOME_PATH}
    echo "RESULT=$?"
}

if [ -d "$USER_PATH" ]; then
    make_soft_link
fi


# Start the notebook
cd ${USER_PATH}
/usr/local/bin/start-notebook.sh --NotebookApp.token= --ip="*" --NotebookApp.base_url=${NB_PREFIX} --NotebookApp.allow_origin="*" --NotebookApp.notebook_dir="${USER_PATH}"

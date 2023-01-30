#!/usr/bin/bash

set -x

HOME_PATH="/home/jovyan"
USER_PATH="/home/${USER_NAME}"

# Create a soft link
function make_soft_links() {
    pwd
    ls -al

    echo "Making softlink from /home/${USER_PATH} to /home/${HOME_PATH} in " `pwd`
    ln -s ${USER_PATH} ${HOME_PATH}
    echo "Link1 result=$?"

    chmod 777 ${HOME_PATH}
    echo "chmod1 result=$?"

    echo "Making softlink from /home/${HOME_PATH} to /home/${USER_PATH} in " `pwd`
    ln -s ${HOME_PATH} ${USER_PATH}
    echo "Link2 result=$?"

    chmod 777 ${USER_PATH}
    echo "chmod2 result=$?"
}

echo "Executing in directory " `pwd`
echo "Executing as user $USER"

if [ -d "${USER_PATH}" ]; then
    echo "Executing chmod 775 on ${USER_PATH}"
    chmod 775 ${USER_PATH}
    echo "${USER_PATH} chmod result=$?"

    echo "Executing chown on ${USER_PATH}"
    chown 1000:jovyan ${USER_PATHH}
    echo "${USER_PATH} chown result=$?"

    make_soft_links
else
    echo "Warning: $USER_PATH does not exist, not making soft links."
fi

# Start the notebook from directory ${USER_PATH}
cd ${USER_PATH}
/usr/local/bin/start-notebook.sh --NotebookApp.token= --ip="*" --NotebookApp.base_url=${NB_PREFIX} --NotebookApp.allow_origin="*" --NotebookApp.notebook_dir="${USER_PATH}"

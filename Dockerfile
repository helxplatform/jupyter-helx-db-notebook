FROM jupyter/scipy-notebook:x86_64-lab-3.5.1

ARG NB_USER="jovyan"
ARG NB_UID="30000"
ARG NB_GID="1136"
ARG CONDA_ENV=/opt/conda
ARG HOME_DIR=/home/jovyan

# Configure environment
ENV CONDA_DIR=/opt/conda \
    SHELL=/bin/bash \
    NB_USER="${NB_USER}" \
    NB_UID=${NB_UID} \
    NB_GID=${NB_GID} \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8

ENV PATH="${CONDA_DIR}/bin:${PATH}" \
    HOME="/home/${NB_USER}"

USER root

COPY start-jupyter-datascience-db.sh /usr/local/bin
COPY etc-jupyter_notebook_config.py /etc/jupyter/jupyter_notebook_config.py
COPY jovyan-jupyter_notebook_config.py /home/jovyan/.jupyter/jupyter_notebook_config.py
COPY jovyan-jupyter_server_config.py /home/jovyan/.jupyter/jupyter_server_config.py

RUN chmod 755 /usr/local/bin/start-jupyter-datascience-db.sh && \
    chmod 644 /etc/jupyter/jupyter_notebook_config.py && \
    chmod 644 /etc/jupyter/jupyter_server_config.py

RUN conda install --yes --prefix $CONDA_ENV -c conda-forge \
       'ipython' \
       'ipywidgets' \
       'ipython-sql' \
       'psycopg2-binary' \
       'sqlalchemy' \
       'tensorflow' \
       'scikit-learn'

RUN conda install 'pip' && \
    /opt/conda/bin/pip3 install 'jupyter-server-terminals' && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "${HOME}" && \
    fix-permissions "/home/${NB_USER}" && \
    fix-permissions "/home/$USER"

USER ${NB_USER}

ENTRYPOINT /usr/local/bin/start-jupyter-datascience-db.sh

#ENTRYPOINT [start-notebook.sh, "--NotebookApp.token=", "--ip='*'", "--NotebookApp.base_url=${NB_PREFIX}" "--NotebookApp.allow_origin='*']"

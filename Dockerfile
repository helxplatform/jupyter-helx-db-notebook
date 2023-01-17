FROM jupyter/scipy-notebook:x86_64-lab-3.5.1

ARG NB_USER="jovyan"
ARG NB_UID="30000"
ARG NB_GID="1136"

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

RUN pip install \
       'ipython-sql' \
       'psycopg2-binary' \
       'jupyter-server-terminals' \
       'sqlalchemy' \
       'tensorflow' \
       'scikit-learn' && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "${HOME}" && \
    fix-permissions "/home/${NB_USER}"

USER $NB_USER


#ENTRYPOINT [start-notebook.sh, "--NotebookApp.token=", "--ip='*'", "--NotebookApp.base_url=${NB_PREFIX}" "--NotebookApp.allow_origin='*']"

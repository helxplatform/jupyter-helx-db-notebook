FROM jupyter/scipy-notebook

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
    #\JULIA_PKGDIR=/opt/julia

ENV PATH="${CONDA_DIR}/bin:${PATH}" \
    HOME="/home/${NB_USER}"

USER root

RUN mamba install --quiet --yes \
       'ipython-sql' \
       'psycopg2' \
       'sqlalchemy' \
       'otter-grader' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    #fix-permissions "${JULIA_PKGDIR}" && \
    fix-permissions "${HOME}" && \
    #fix-permissions "/etc/jupyter" && \
    fix-permissions "/home/${NB_USER}"

USER $NB_USER


CMD start-notebook.sh --NotebookApp.token= --ip='*' --NotebookApp.base_url=${NB_PREFIX} --NotebookApp.allow_origin='*'

ARG SCIPY_NOTEBOOK_IMAGE_TAG=x86_64-lab-latest
FROM jupyter/scipy-notebook:$SCIPY_NOTEBOOK_IMAGE_TAG

ARG NB_USER="jovyan"
ARG NB_UID="30000"
ARG NB_GID="0"
ARG CONDA_ENV=/opt/conda
ARG HOME_DIR=/home/$NB_USER

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
    fix-permissions "/home" && \
    fix-permissions "/etc/jupyter" && \
    chmod g+w /etc/passwd /etc/group
COPY root /

WORKDIR /
USER $NB_USER
CMD ["/init.sh"]

ARG BASE_IMAGE_TAG=latest
FROM containers.renci.org/helxplatform/jupyter/datascience-notebook:$BASE_IMAGE_TAG

USER root
RUN pip install \
       'ipython-sql' \
       'psycopg2-binary' \
       'jupyter-server-terminals' \
       'sqlalchemy' \
       'tensorflow' \
       'scikit-learn' && \
    fix-permissions "${CONDA_DIR}" /home

WORKDIR /
USER $NB_USER

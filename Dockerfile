ARG BASE_IMAGE_TAG=202341141954
FROM containers.renci.org/helxplatform/jupyter/helx-notebook:$BASE_IMAGE_TAG

USER root
RUN pip install \
       'ipython-sql' \
       'psycopg2-binary' \
       'jupyter-server-terminals' \
       'sqlalchemy' \
       'tensorflow' \
       'scikit-learn' && \
    fix-permissions "${CONDA_DIR}"

WORKDIR /
USER $NB_USER

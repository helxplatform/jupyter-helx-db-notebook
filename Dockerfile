ARG BASE_IMAGE_TAG=latest
FROM containers.renci.org/helxplatform/jupyter/datascience-notebook:$BASE_IMAGE_TAG

USER root
RUN pip install \
       'ipython-sql' \
       'psycopg2-binary' \
       'jupyter-server-terminals' \
       'sqlalchemy' \
       'scikit-learn' && \
    fix-permissions "${CONDA_DIR}"
# Removed tensorflow from installation above.  A 500+MB package adds a lot of bloat if not used.
#       'tensorflow' \

WORKDIR /
USER $NB_USER

FROM harvardat/atg-jupyter-general:a6ce412

ARG conda_env=datafest_2021
COPY --chown=${NB_UID}:${NB_GID} ${conda_env}.yml /tmp/
RUN cd /tmp/ && \
     conda env create -p $CONDA_DIR/envs/${conda_env} -f ${conda_env}.yml && \
     conda clean --all -f -y

RUN $CONDA_DIR/envs/${conda_env}/bin/python -m ipykernel install  --name=${conda_env} && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

ENV PATH $CONDA_DIR/envs/${conda_env}/bin:$PATH
ENV CONDA_DEFAULT_ENV ${conda_env}

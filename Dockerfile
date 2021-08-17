FROM jupyter/minimal-notebook

USER root

RUN apt-get -y update
RUN apt-get -y install libgl1-mesa-glx

# Update conda
RUN conda update --quiet --yes conda

# Add extra conda channels
RUN conda config --append channels conda-forge \
    --append channels anaconda-fusion \
    --append channels jmcmurray

RUN conda install --quiet --yes \
    'mkl-service' \
    'rpy2' \
    && \
    conda clean --al -f -y

COPY requirements.txt . 
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Activate ipywidgets extension in the environment that runs the notebook server, and do some clean-up
RUN jupyter nbextension enable --py widgetsnbextension --sys-prefix && \
    npm cache clean --force && \
    rm -rf "/home/${NB_USER}/.cache/yarn" && \
    rm -rf "/home/${NB_USER}/.node-gyp" && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install facets which does not have a pip or conda package at the moment
WORKDIR /tmp
RUN git clone https://github.com/PAIR-code/facets.git && \
    jupyter nbextension install facets/facets-dist/ --sys-prefix && \
    rm -rf /tmp/facets && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Import matplotlib the first time to build the font cache.
ENV XDG_CACHE_HOME="/home/${NB_USER}/.cache/"

RUN MPLBACKEND=Agg python -c "import matplotlib.pyplot" && \
    fix-permissions "/home/${NB_USER}"

# Set cache directory for numba so that the package "mne" can work
ENV NUMBA_CACHE_DIR="/home/${NB_USER}/.cache/"

USER $NB_UID

WORKDIR $HOME
 

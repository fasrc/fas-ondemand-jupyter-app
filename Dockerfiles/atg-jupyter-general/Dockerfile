FROM jupyter/minimal-notebook

USER root

RUN apt-get -y update
RUN apt-get -y install libgl1-mesa-glx

RUN conda install --quiet --yes \
    'altair' \
    'arviz' \
    'bokeh' \
    'beautifulsoup4' \
    'control' \
    'dash' \
    'filterpy' \
    'gensim' \
    'holoviews' \
    'ipytest' \
    'IPython' \
    'ipywidgets' \
    'jupyterlab' \
    'matplotlib' \
    'mkl-service' \
    'mesa' \
    'mne' \
    'mpmath' \
    'networkx' \
    'nltk' \
    'numba' \
    'numpy=1.18.5' \
    'openpyxl' \
    'opencv' \
    'pandas' \
    'peakutils' \
    'pillow' \
    'plotly' \
    'powerlaw' \
    'requests' \
    'rpy2' \
    'scikit-image' \
    'scikit-learn' \
    'scipy=1.4.1' \
    'seaborn' \
    'spacy' \
    'statsmodels' \
    'sympy' \
    'thinkx' \
    'xlrd' \
    'xlsxwriter' \
    && \
    conda clean --al -f -y && \
    # Activate ipywidgets extension in the environment that runs the notebook server
    jupyter nbextension enable --py widgetsnbextension --sys-prefix && \
    # Also activate ipywidgets extension for JupyterLab
    # Check this URL for most recent compatibilities
    # https://github.com/jupyter-widgets/ipywidgets/tree/master/packages/jupyterlab-manager
    jupyter labextension install @jupyter-widgets/jupyterlab-manager@^2.0.0 --no-build && \
    jupyter labextension install @bokeh/jupyter_bokeh@^2.0.0 --no-build && \
    jupyter labextension install jupyter-matplotlib@^0.7.2 --no-build && \
    jupyter lab build -y && \
    jupyter lab clean -y && \
    npm cache clean --force && \
    rm -rf "/home/${NB_USER}/.cache/yarn" && \
    rm -rf "/home/${NB_USER}/.node-gyp" && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
    
RUN pip install --upgrade pip && \
    pip install --no-cache-dir gap-stat gym progressbar2 pygam stochastic tensorflow-gpu

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
 

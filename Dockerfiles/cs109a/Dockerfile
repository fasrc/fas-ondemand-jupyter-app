FROM jupyter/minimal-notebook

RUN conda install --quiet --yes \
    'altair' \
    'arviz' \
    'bokeh' \
    'beautifulsoup4' \
    'dash' \
    'gensim' \
    'holoviews' \
    'ipytest' \
    'IPython' \
    'ipywidgets' \
    'jupyterlab' \
    'matplotlib' \
    'mkl-service' \
    'nltk' \
    'numpy' \
    'pandas' \
    'pip' \
    'pillow' \
    'plotly' \
    'requests' \
    'rpy2' \
    'scipy' \
    'scikit-image' \
    'scikit-learn' \
    'seaborn' \
    'spacy' \
    'statsmodels' \
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
    pip install --no-cache-dir gap-stat gym progressbar2 pygam
    
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

USER $NB_UID

WORKDIR $HOME
 

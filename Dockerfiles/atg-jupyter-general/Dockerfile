FROM jupyter/minimal-notebook

USER root

RUN apt-get -y update
RUN apt-get -y install libgl1-mesa-glx

# Update conda
RUN conda update --quiet --yes conda

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
    'ipympl' \
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
    'numpy' \
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
    'scipy' \
    'seaborn' \
    'spacy' \
    'statsmodels' \
    'sympy' \
    'thinkx' \
    'xlrd' \
    'xlsxwriter' \
    && \
    conda clean --al -f -y
# Activate ipywidgets extension in the environment that runs the notebook server, and do some clean-up
RUN jupyter nbextension enable --py widgetsnbextension --sys-prefix && \
    npm cache clean --force && \
    rm -rf "/home/${NB_USER}/.cache/yarn" && \
    rm -rf "/home/${NB_USER}/.node-gyp" && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
    
RUN pip install --upgrade pip && \
    pip install --no-cache-dir gap-stat gym progressbar2 pygam stochastic tensorflow-gpu keras mpl-interactions

# Add extra conda channels
RUN conda config --append channels conda-forge
RUN conda config --append channels anaconda-fusion
RUN conda config --append channels jmcmurray

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
 

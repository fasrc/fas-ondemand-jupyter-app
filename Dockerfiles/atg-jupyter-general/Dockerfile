FROM jupyter/minimal-notebook

USER root

RUN apt-get -y update
RUN apt-get -y install libgl1-mesa-glx

# Install dependencies of the pyjags package
RUN apt-get -y install pkg-config jags

# Install python packages using pip
RUN pip install --upgrade pip
RUN pip install --no-cache-dir tensorflow-gpu
RUN pip install --no-cache-dir altair arviz bokeh beautifulsoup4 control
RUN pip install --no-cache-dir dash filterpy gensim holoviews ipytest
RUN pip install --no-cache-dir IPython ipywidgets jupyterlab matplotlib
RUN pip install --no-cache-dir mesa mne mpmath networkx nltk
RUN pip install --no-cache-dir numba numpy openpyxl pandas peakutils
RUN pip install --no-cache-dir pillow plotly powerlaw requests
RUN pip install --no-cache-dir scikit-image scikit-learn scipy seaborn
RUN pip install --no-cache-dir spacy statsmodels sympy thinkx xlrd xlsxwriter
RUN pip install --no-cache-dir gap-stat gym progressbar2 pygam stochastic keras opencv-python pyjags csaps
RUN pip install --no-cache-dir certifi depfinder gdown imageio mamba theano urllib3

# Update conda
RUN conda update --quiet --yes conda

# Install python packages using conda
RUN conda install --quiet --yes -c conda-forge mkl-service rpy2 pymc3

# Install R packages
RUN conda install --quiet --yes 'r-aplpack' 'r-cluster' 'r-codetools' 'r-dbscan' 'r-factoextra' \
    'r-gam' 'r-ggplot2' 'r-splines2' 'r-teachingdemos'

RUN conda clean --al -f -y

# Add extra conda channels
RUN conda config --append channels conda-forge
RUN conda config --append channels anaconda-fusion
RUN conda config --append channels jmcmurray

# Activate ipywidgets extension in the environment that runs the notebook server
RUN jupyter nbextension enable --py widgetsnbextension --sys-prefix

RUN npm cache clean --force && \
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
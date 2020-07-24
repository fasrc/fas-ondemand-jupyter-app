FROM jupyter/minimal-notebook

RUN conda install --quiet --yes \
    'bokeh' \
    'control' \
    'filterpy' \
    'IPython' \
    'ipywidgets' \
    'matplotlib' \
    'mesa' \
    'mpmath' \
    'numba' \
    'numpy' \
    'openpyxl' \
    'pandas' \
    'powerlaw' \
    'requests' \
    'scikit-learn' \
    'scipy' \
    'seaborn' \
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
    
RUN export CPATH=$CPATH:/usr/local/cuda-10.0/targets/aarch64-linux/include
RUN export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/cuda-10.0/targets/aarch64-linux/lib
    
RUN pip install --upgrade pip && \
    pip install --no-cache-dir pycuda stochastic

# Import matplotlib the first time to build the font cache.
ENV XDG_CACHE_HOME="/home/${NB_USER}/.cache/"

RUN MPLBACKEND=Agg python -c "import matplotlib.pyplot" && \
    fix-permissions "/home/${NB_USER}"

USER $NB_UID

WORKDIR $HOME
 

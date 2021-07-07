# Courses (2020-21)

This is intended as a record of custom Jupyter applications for Fall 2020 and Spring 2021. All custom Jupyter applications were based on [jupyter/minimal-notebook](https://hub.docker.com/r/jupyter/minimal-notebook).
Note there were two `Dockerfile` variants, one used for Fall courses and the other used for Spring courses, both of which included all required dependencies. 

- [Courses (2020-21)](#courses-2020-21)
  - [APPHY286](#apphy286)
  - [ASTRON100](#astron100)
  - [CS109a and CS109b](#cs109a-and-cs109b)
  - [CS205](#cs205)
  - [Datafest](#datafest)
  - [ES91r](#es91r)
  - [ES143](#es143)
  - [ESE102](#ese102)
- [Packages](#packages)
- [Dockerfiles](#dockerfiles)
  - [Dockerfile Fall 2020](#dockerfile-fall-2020)
  - [Dockerfile Spring 2021](#dockerfile-spring-2021)

## APPHY286

**Course:** APPHY 286: Inference, Information Theory, Learning and Statistical Mechanics

**Term:** Fall 2020

**Branch commit:** [8f7f057](https://github.com/fasrc/fas-ondemand-jupyter-app/tree/8f7f0574fae069d1a010018b9a0606886da21a7f)

**Form:** memory:4 (allowed to choose 4-32 GB) cpu:1 (allowed to choose 1-16 cores) gpus:0

**Additional customization?** No

## ASTRON100

**Course:** ASTRON 100: Methods of Observational Astronomy

**Term:** Spring 2021

**Branch commit:** [6d977f9](https://github.com/fasrc/fas-ondemand-jupyter-app/tree/6d977f975df46e1257d2963ff1bf610664b14277)

**Form:** memory:16 cpu:8 gpus:0

**Additional customization?** Yes

In `template/script.sh.erb`:

```
export SINGULARITYENV_CONDA_ENVS_PATH=$CONDA_ENVS_PATH
export SINGULARITYENV_CONDA_PKGS_PATH=$CONDA_PKGS_PATH
export SINGULARITYENV_OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
```

## CS109a and CS109b

**Course:** CS109a and CS109b

**Term:** Fall 2020 (cs109a), Spring 2021 (cs109b)

**Branch commit:** [3931c76](https://github.com/fasrc/fas-ondemand-jupyter-app/tree/3931c76e8730eb83d0873f399fe5f0ba8f5dd794)

**Form:** memory:32 cpu:8 gpus:0

**Additional customization?** Yes

In `template/script.sh.erb`:

```
export SINGULARITYENV_OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
```

## CS205

**Course:** CS205: Computing Foundations for Computational Science

**Term:** Spring 2021

**Branch commit:** [8723f53](https://github.com/fasrc/fas-ondemand-jupyter-app/tree/8723f5331e6efb6ae7b8f11ba790b677c15b3c76)

**Form:** memory:8 cpu:1 (allowed to choose 1-64 cores) gpus:0 (allowed to choose 0-4 gpus)

**Additional customization?** Yes

In `template/script.sh.erb`:

```
export SINGULARITYENV_OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
```

## Datafest

**Course:** Harvard DataFest 2021 (19-22 January 2021)

**Term:** Spring 2021

**Branch commit:** [e08c876](https://github.com/fasrc/fas-ondemand-jupyter-app/tree/e08c876c5a8b48f1b4ff12d3c7d15ae01029d87b)

**Form:** memory:16 cpu:8 gpus:0

**Additional customization?** Yes

In `template/before.sh.erb`:

```
export CONTAINER_REPO=/n/holystore01/SINGULARITY/Academic-cluster/Spring_2021/
export COURSE=datafest
export LAST_DIGIT=$(id -n -u  | sed 's/\(.*\)\([0-9]\)\(_g_.*\)/\2/' )
export COURSE_SCRATCH_FOLDER=/n/holyscratch01/Academic-cluster/Spring_2021/g_87116/SCRATCH
```

In `template/script.sh.erb`:

```
export container_folder=${CONTAINER_REPO}/${COURSE}/${LAST_DIGIT}
```

## ES91r

**Course:** ES91r (SEAS)

**Term:** Fall 2020

**Branch commit:** [18274f6](https://github.com/fasrc/fas-ondemand-jupyter-app/tree/18274f61e646683cf7cda2e1913c27d33e76cf03)

**Form:** memory:8 (allowed to choose 2-32 GB) cpu:4 (allowed to choose 1-16 cores) gpus:0

**Additional customization?** No

## ES143

**Course:** ES143 (SEAS)

**Term:** Fall 2020

**Branch commit:** [4d79563](https://github.com/fasrc/fas-ondemand-jupyter-app/tree/4d795636d9efeb85ab29bd58b3d3cf7736d08e1d)

**Form:** memory:8 cpu:4 gpus:0

**Additional customization?** No

## ESE102

**Course:** ESE102: Data Analysis and Statistical Inference in the Earth and Environmental Sciences

**Term:** Spring 2021

**Branch commit:** [066bbd1](https://github.com/fasrc/fas-ondemand-jupyter-app/tree/066bbd11f02d21bcfe8e9ea1be5502e5194449d6)

**Form:** memory:8 cpu:4 gpus:0

**Additional customization?** No

# Packages

This is a list of distinct packages that were requested across all of the above courses (at least the ones requested via google form):

```
arviz
astropy
beautifulsoup4
bokeh
dash
gap-stat
gensim
holoviews
ipympl
ipytest
ipython
ipywidgets
jupyter
jupyterlab
keras
matplotlib
mkl-service
mne
mpl-interactions
networkx
nltk
numpy
opencv-python
pandas
peakutils
openpyxl
pillow
plotly
progressbar2
requests
scikit-image
scikit-learn
scipy
seaborn
skimage
spacy
statsmodels
sympy
tensorflow>=2.0.0
xlsxwriter
```

# Dockerfiles

## Dockerfile Fall 2020

```
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
    pip install --no-cache-dir gap-stat gym progressbar2 pygam stochastic tensorflow-gpu keras

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
 ```

 ## Dockerfile Spring 2021

 ```
 FROM jupyter/minimal-notebook

USER root

RUN apt-get -y update
RUN apt-get -y install libgl1-mesa-glx

# Install dependencies of the pyjags package
RUN apt-get -y install pkg-config jags

# Install python packages using pip
RUN pip install --upgrade pip
RUN pip install --no-cache-dir tensorflow-gpu tensorflow-addons tensorflow-datasets tf-keras-vis
RUN pip install --no-cache-dir pyjags csaps gridworld helpers iacs-cli gap-stat

# Update conda
RUN conda update --quiet --yes conda

# Add the conda-forge conda channel
RUN conda config --append channels conda-forge

# Install python packages using conda
RUN conda install --quiet --yes mkl-service rpy2 pymc3
RUN conda install --quiet --yes gym progressbar2 pygam
RUN conda install --quiet --yes altair arviz bokeh beautifulsoup4 control
RUN conda install --quiet --yes dash filterpy gensim holoviews ipytest
RUN conda install --quiet --yes IPython ipywidgets jupyterlab matplotlib
RUN conda install --quiet --yes mesa mne mpmath networkx nltk
RUN conda install --quiet --yes numba numpy openpyxl pandas peakutils
RUN conda install --quiet --yes pillow plotly powerlaw requests
RUN conda install --quiet --yes scikit-image scikit-learn scipy seaborn
RUN conda install --quiet --yes spacy statsmodels sympy thinkx xlrd xlsxwriter
RUN conda install --quiet --yes stochastic keras opencv
RUN conda install --quiet --yes certifi depfinder gdown imageio mamba theano urllib3

# Install R packages
RUN conda install --quiet --yes 'r-aplpack' 'r-cluster' 'r-codetools' 'r-dbscan' 'r-factoextra' \
    'r-gam' 'r-ggplot2' 'r-splines2' 'r-teachingdemos'

RUN conda clean --al -f -y

# Add extra conda channels
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
 ```
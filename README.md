# Jupyter Notebook for Deployment on the Academic cluster at FAS-RC

## WIP : this is still work in progress, not ready for production deployment 

This app has been derived by the template kindly provided by the OSC OpenOnDemand
Team. [OSC](https://github.com/OSC/bc_example_jupyter)

It launches a Jupyter Notebook server within a batch job.

## Prerequisites
This Batch Connect app requires the following software be available on **compute nodes** :

- [Jupyter Notebook](http://jupyter.readthedocs.io/en/latest/) We currently deploy the following version:
```sh
 $> jupyter --version
 jupyter core     : 4.6.3
 jupyter-notebook : 6.0.3
 qtconsole        : not installed
 ipython          : 7.15.0
 ipykernel        : 5.3.0
 jupyter client   : 6.1.3
 jupyter lab      : 2.1.3
 nbconvert        : 5.6.1
 ipywidgets       : 7.5.1
 nbformat         : 5.0.6
 traitlets        : 4.3.3
```

- [OpenSSL](https://www.openssl.org/) used to hash the Jupyter Notebook server password 

## Install

The master branch of this repo is automatically deployed by puppet to /var/www/ood/apps/sys/ on the ondemand nodes.

If you want to deploy that in your user development environment to make modifications, follow these instructions. 

```sh
# create the development folder if you still not have one
mkdir -pv $HOME/fasrc/dev/
cd $HOME/fasrc/dev/

# clone the repository in a subfolder for your version of the app
git clone https://github.com/fasrc/fas-ondemand-jupyter-app.git

# Change the working directory to this new directory
cd fas-ondemand-jupyter-app
```
You can now make your preferred modifications and run your version of the app from the sandbox control panel under the
*dev* menu on the ondemand dashboard

## Contributing

If you intend deploy your modified version as system wide app, please commit your changes to a branch first, and open a PR.

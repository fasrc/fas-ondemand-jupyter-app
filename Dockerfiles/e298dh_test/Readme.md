### Dockerfile for the docker image jupyter_e298dh_test at https://hub.docker.com/repository/docker/harvardat/jupyter_e298dh_test.

The Dockerfile is based on the requirements of English 298DH, a course that used FAS/SEAS JupyterHub in Spring 2020.

The requirements included:
- Python 3 jupyter kernel
- Packages:
    - numpy
    - matplotlib
    - pandas

To build the docker image, from the same directory as this Dockerfile, run `docker build -t jupyter_e298dh_test .`
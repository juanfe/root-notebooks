FROM rootproject/root-ubuntu18

# Run the following commands as super user (root):
USER root

RUN echo "/usr/local/lib/root" > /etc/ld.so.conf.d/cern_root.conf
# Install required packages for notebooks
#RUN apt-get update && apt-get install -y python-pip && pip install --upgrade pip && pip install \
#       jupyter \
#
RUN apt-get update && apt-get install -y python-pip && pip install --upgrade pip \
     && hash pip && pip -V && pip install jupyter metakernel zmq && rm -rf /var/lib/apt/lists/*

# Create a user that does not have root privileges 
ARG username=physicist
##RUN userdel builder && useradd --create-home --home-dir /home/${username} ${username}
RUN useradd --create-home --home-dir /home/${username} ${username}
ENV HOME /home/${username}

WORKDIR /home/${username}

# Add some example notebooks
ADD http://root.cern.ch/doc/master/notebooks/mp201_parallelHistoFill.C.nbconvert.ipynb mp201_parallelHistoFill.C.nbconvert.ipynb
#ADD http://root.cern.ch/doc/master/notebooks/tdf007_snapshot.py.nbconvert.ipynb tdf007_snapshot.py.nbconvert.ipynb

# Switch to our newly created user
USER ${username}


RUN mkdir /home/${username}/work
# Allow incoming connections on port 8888
EXPOSE 8888

ENV LD_LIBRARY_PATH /usr/local/lib/root

# Create the configuration file for jupyter and set owner
RUN root --notebook ; exit 0
RUN sed -i 's/*/0.0.0.0/g' /home/${username}/.rootnb/jupyter_notebook_config.py \
    && echo "c.NotebookApp.port = 8888" >> /home/${username}/.rootnb/jupyter_notebook_config.py

# Start ROOT with the --notebook flag to fire up the container
CMD ["root", "--notebook"]

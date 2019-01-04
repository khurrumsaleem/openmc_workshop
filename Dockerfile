FROM ubuntu:16.04

MAINTAINER Jonathan Shimwell

# This docker image contains all the dependencies required to run OpenMC.
# More details on OpenMC are available on the web page https://openmc.readthedocs.io

# build with
#     sudo docker build -t shimwell/openmc:latest .
# run with
#     docker run -it --rm -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY -e OPENMC_CROSS_SECTIONS=/openmc/nndc_hdf5/cross_sections.xml --privileged shimwell/openmc
# if you have no GUI in docker try running this xhost command prior to running the image
#     xhost local:root
# push to docker store with
#     docker login
#     docker push shimwell/openmc:latest
#



# Install additional packages

RUN apt-get --yes update && apt-get --yes upgrade

RUN apt-get --yes install gfortran g++ cmake libhdf5-dev git

RUN apt-get update
RUN apt-get install -y python3-pip python3-dev python3-tk

# Python Prerequisites Required
RUN pip3 install numpy
RUN pip3 install pandas
RUN pip3 install six
RUN pip3 install h5py
RUN pip3 install Matplotlib
RUN pip3 install uncertainties
RUN pip3 install lxml
RUN pip3 install scipy

# Python Prerequisites Optional
RUN pip3 install cython
RUN pip3 install vtk
RUN apt-get install --yes libsilo-dev
RUN pip3 install pytest
RUN pip3 install codecov
RUN pip3 install pytest-cov
RUN pip3 install pylint

# Python libraries used in the workshop
RUN pip3 install plotly
RUN pip3 install tqdm


# installs OpenMc from source (modified version which includes more MT numbers in the cross sections)
# RUN git clone https://github.com/mit-crpg/openmc && \
RUN git clone https://github.com/Shimwell/openmc.git && \
    cd openmc && \
    git checkout added_MT_gas_reactions_back && \
    mkdir bld && cd bld && \
    cmake .. -DCMAKE_INSTALL_PREFIX=.. && \
    make && \
    make install

RUN PATH="$PATH:/openmc/bld/bin/"
RUN cp /openmc/bld/bin/openmc /usr/local/bin

RUN cd openmc && python3 setup.py install

RUN cd openmc && python3 /openmc/scripts/openmc-get-nndc-data -b

# installs the Atom text editor
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:webupd8team/atom
RUN apt update
RUN apt install -y atom

RUN apt-get install -y firefox


RUN OPENMC_CROSS_SECTIONS=/openmc/nndc_hdf5/cross_sections.xml

RUN export OPENMC_CROSS_SECTIONS=/openmc/nndc_hdf5/cross_sections.xml

RUN apt-get --yes update
RUN apt-get --yes install hdf5-tools
RUN apt-get --yes install imagemagick
#RUN apt-get --yes install paraview
RUN apt-get --yes install wget

RUN wget https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=v5.6&type=binary&os=Linux&downloadFile=ParaView-5.6.0-osmesa-MPI-Linux-64bit.tar.gz

RUN git clone https://github.com/Shimwell/openmc_workshop.git

WORKDIR /openmc_workshop

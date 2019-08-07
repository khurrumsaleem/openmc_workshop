
sudo apt-get --yes update && sudo apt-get --yes upgrade
sudo apt-get update

sudo apt-get --yes install gfortran 
sudo apt-get --yes install g++ 
sudo apt-get --yes install cmake 
sudo apt-get --yes install libhdf5-dev

sudo apt-get install -y python3
sudo apt-get install -y python3-pip
sudo apt-get install -y python3-dev
sudo apt-get install -y python3-tk

sudo apt-get install --yes imagemagick
sudo apt-get install --yes hdf5-tools
sudo apt-get install --yes paraview
sudo apt-get install --yes eog
sudo apt-get install --yes wget
sudo apt-get install --yes libsilo-dev
sudo apt-get install --yes git

sudo apt-get --yes install dpkg
sudo apt-get --yes install libxkbfile1
sudo apt-get --yes install -f
sudo apt-get install libblas-dev 
sudo apt-get install liblapack-dev

pip3 install numpy --user
pip3 install pandas --user
pip3 install six --user
pip3 install h5py --user
pip3 install Matplotlib --user
pip3 install uncertainties --user
pip3 install lxml --user
pip3 install scipy --user
pip3 install cython --user
pip3 install vtk --user
pip3 install pytest --user
pip3 install codecov --user
pip3 install pytest-cov --user
pip3 install pylint --user
pip3 install plotly --user
pip3 install tqdm --user

# Clone and install NJOY2016
cd ~
git clone https://github.com/njoy/NJOY2016 #/opt/NJOY2016
cd NJOY2016
mkdir build
cd build
cmake -Dstatic=on .. && make 2>/dev/null
sudo make install

sudo rm /usr/bin/python
sudo ln -s /usr/bin/python3 /usr/bin/python

# MOAB Variables
MOAB_BRANCH='Version5.1.0'
MOAB_REPO='https://bitbucket.org/fathomteam/moab/'
MOAB_INSTALL_DIR=$HOME/MOAB/

# DAGMC Variables
DAGMC_BRANCH='develop'
DAGMC_REPO='https://github.com/svalinn/dagmc'
DAGMC_INSTALL_DIR=$HOME/DAGMC/
set -ex


# MOAB Install
cd ~
mkdir MOAB
cd MOAB
git clone -b $MOAB_BRANCH $MOAB_REPO
mkdir build 
cd build
cmake ../moab -DENABLE_HDF5=ON -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=$MOAB_INSTALL_DIR
make
# make test Install
# cmake ../moab -DBUILD_SHARED_LIBS=OFF
make install
# rm -rf /MOAB/moab
#needs setting in bashrc
LD_LIBRARY_PATH=$MOAB_INSTALL_DIR/lib:$LD_LIBRARY_PATH


# DAGMC Install
cd ~
mkdir DAGMC
cd DAGMC
git clone -b $DAGMC_BRANCH $DAGMC_REPO
mkdir build
cd build
# cmake ../dagmc -DBUILD_TALLY=ON -DCMAKE_INSTALL_PREFIX=$DAGMC_INSTALL_DIR -DMOAB_DIR=$MOAB_INSTALL_DIR -DBUILD_SHARED_LIBS=OFF -DBUILD_STATIC_EXE=ON
cmake ../dagmc -DBUILD_TALLY=ON -DCMAKE_INSTALL_PREFIX=$DAGMC_INSTALL_DIR -DMOAB_DIR=$MOAB_INSTALL_DIR 
make install
# rm -rf $HOME/DAGMC/dagmc
#needs setting in bashrc
LD_LIBRARY_PATH=$DAGMC_INSTALL_DIR/lib:$LD_LIBRARY_PATH

FC=mpif90
CC=mpicc

cd ~
git clone https://github.com/mit-crpg/openmc 
cd openmc
mkdir build
cd build 
cmake -Ddagmc=ON -Ddebug=on ..
make 
make install

PATH="$PATH:~/software/openmc/openmc/build/bin/"
sudo cp ~/software/openmc/openmc/build/bin/openmc /usr/local/bin

cd ~/software/openmc/openmc/ 
sudo python3 setup.py install

cd openmc && python3 ~/software/openmc/openmc/scripts/openmc-get-nndc-data -b

cd ~/software/openmc/
git clone https://github.com/openmc-dev/data.git
cd data

echo 'export PYTHONPATH=$PYTHONPATH:~/software/openmc/openmc/scripts/ ' >> ~/.bashrc 
PYTHONPATH=$PYTHONPATH:~/software/openmc/openmc/scripts/ 

cd ~/software/openmc/data
cp ~/software/openmc/openmc/scripts/openmc-ace-to-hdf5 .
cp ~/software/openmc/openmc/scripts/openmc-get-photon-data .
python3 convert_nndc71.py -b


OPENMC_CROSS_SECTIONS=/openmc/nndc_hdf5/cross_sections.xml
echo 'export OPENMC_CROSS_SECTIONS=/openmc/nndc_hdf5/cross_sections.xml' >> ~/.bashrc 

wget https://update.code.visualstudio.com/1.31.1/linux-deb-x64/stable
sudo dpkg -i stable 

cd ~/software
git clone https://github.com/pyne/pyne.git
cd ~/software/pyne
python3 setup.py install --user

PATH="/home/neutronics/.local/bin:${PATH}"
echo 'export PATH="/home/neutronics/.local/bin:${PATH}"' >> ~/.bashrc 


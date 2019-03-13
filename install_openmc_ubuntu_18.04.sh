
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

sudo apt-get --yes install imagemagick
sudo apt-get --yes install hdf5-tools
sudo apt-get --yes install paraview
sudo apt-get --yes install eog
sudo apt-get --yes install wget
sudo apt-get install --yes libsilo-dev
sudo apt-get install --yes git
sudo apt-get install --yes python3-pip
sudo apt-get --yes install dpkg
sudo apt-get --yes install libxkbfile1
sudo apt-get --yes install -f
sudo apt-get install libblas-dev liblapack-dev

pip3 install numpy
pip3 install pandas
pip3 install six
pip3 install h5py
pip3 install Matplotlib
pip3 install uncertainties
pip3 install lxml
pip3 install scipy
pip3 install cython
pip3 install vtk
pip3 install pytest
pip3 install codecov
pip3 install pytest-cov
pip3 install pylint
pip3 install plotly
pip3 install tqdm

mkdir software/ ; cd software ; mkdir openmc ; cd openmc
git clone https://github.com/mit-crpg/openmc 
cd ~/software/openmc/openmc
mkdir build ; cd build 
cmake .. -DCMAKE_INSTALL_PREFIX=.. 
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


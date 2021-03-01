#/opt/parallelcluster/pyenv/bin/pyenv install 3.7.6
#/opt/parallelcluster/pyenv/bin/pyenv global 3.7.6
sudo apt update
sudo apt upgrade
sudo apt-get install -y python3.7
sudo apt-get install -y python3.7-dev
sudo apt-get install -y cmake libboost-all-dev
sudo apt-get install -y python3-pip
sudo apt-get install -y python3-setuptools
sudo apt-get install cython
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1
#python3.7 -m pip install cython --upgrade
#pip3 install cython --upgrade
pip install cython --upgrade
cd /home/ubuntu
git clone https://github.com/facebookresearch/cc_net.git
cd cc_net 
mkdir third_party
cd third_party
wget -O - https://kheafield.com/code/kenlm.tar.gz |tar xz
mkdir kenlm/build
cd kenlm/build
cmake ..
make -j2
cd ..
sudo python setup.py install
cd ..
cd ..
sudo ln -s /data data
{ # try

    sudo make install 
} || { # catch
    pip install sentencepiece
    python setup.py install
}
#TODO: find a fix for the RealMemory config (later)
 

#EXECUTE WORKAROUND!
#https://github.com/aws/aws-parallelcluster/issues/1517#issuecomment-561775124nano 
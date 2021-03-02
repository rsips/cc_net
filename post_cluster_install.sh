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
git clone https://github.com/rsips/cc_net.gitpyth
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

. "/etc/parallelcluster/cfnconfig"
case "${cfn_node_type}" in
    MasterServer)
        # Update slurm conf to expect memory capacity of ComputeFleet based on input
        # Should be 64 Gbs of real memory for a m5.4xlarge partition
        # However we lose around 800mb on average with overhead.
        # Take off 2GB to be safe
        REAL_MEM="250000"
        SLURM_CONF_FILE="/opt/slurm/etc/slurm.conf"
        REAL_MEM_LINE="NodeName=DEFAULT RealMemory=${REAL_MEM}"
        INCLUDE_CLUSTER_LINE="include slurm_parallelcluster_nodes.conf"
        # Get line of INCLUDE_CLUSTER_LINE
        include_cluster_line_num=$(grep -n "${INCLUDE_CLUSTER_LINE}" "${SLURM_CONF_FILE}" | cut -d':' -f1)
        # Prepend with REAL_MEM_LINE
        sed -i "${include_cluster_line_num}i${REAL_MEM_LINE}" /opt/slurm/etc/slurm.conf
        # Restart slurm database with changes to conf file
        systemctl restart slurmctld
    ;;
    ComputeFleet)
    ;;
    *)
    ;;
esac


#TODO: find a fix for the RealMemory config (later)
 

#EXECUTE WORKAROUND!
#https://github.com/aws/aws-parallelcluster/issues/1517#issuecomment-561775124nano 
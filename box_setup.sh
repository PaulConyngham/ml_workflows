#! /bin/bash


# NOTE: THIS WORKS BEST WITH A VM INSTANTIATED WITH UBUNTU 18.04 LTS
# CENTOS HAD AN OUTDATED GCC VERSION WHICH BROKE TENSORFLOW BUT IS KEPT HERE FOR REFERENCE

# CENTOS ONLY
#sudo yum install bzip2 -y
#sudo yum install tmux -y
#sudo yum install htop -y
#sudo yum install wget -y


if [ -z "$STY" ]; then exec screen -dm -S dsScrn /bin/bash "$0"; fi

# MOUNT THE DISK
sudo mkfs.ext4 -m 0 -F -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/sdb
sudo mkdir -p /mnt/disks/work
sudo mount -o discard,defaults /dev/sdb /mnt/disks/work
sudo chmod -R a+w /mnt/disks/work
sudo chmod -R 777 /mnt/disks/work

ln -s /mnt/disks/work work

# SET BUCKET PERMISSIONS
#TO DO

sudo apt-get install gcc -y
sudo apt-get install g++ -y
sudo apt install make -y

# GET MINICONDA
set +e
curl "https://repo.continuum.io/miniconda/Miniconda3-4.6.14-Linux-x86_64.sh" -o Miniconda_Install.sh
if [ $? -ne 0 ]; then
    curl "https://repo.anaconda.com/miniconda/Miniconda3-4.6.14-Linux-x86_64.sh" -o Miniconda_Install.sh
fi
set -e

bash Miniconda_Install.sh -b -f -p ~/miniconda/
echo ". ~/miniconda/etc/profile.d/conda.sh" >> ~/.bashrc
sudo chmod 777 ~/miniconda/etc/profile.d/conda.sh
#source ~/.bashrc
. ~/miniconda/etc/profile.d/conda.sh

# SET UP VIRTUALENV
conda env create -f dspy.yaml
conda activate dspy

#gsutil cp gs://wx-personal/James/tooling/startup/dspy.yaml dspy.yaml
#gsutil cp gs://wx-personal/James/tooling/gcp/dp2.sh dp2.sh

exec $SHELL



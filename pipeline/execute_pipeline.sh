#!/usr/bin/env bash
# usage ./execute_pipeline.sh [pipeline name] [sync type]
set -e

sudo yum groupinstall "Development Tools" -y
sudo yum install git -y

wget https://repo.continuum.io/miniconda/Miniconda3-4.5.4-Linux-x86_64.sh -O ~/miniconda.sh
bash ~/miniconda.sh -b -f -p $HOME/miniconda
export PATH="$HOME/miniconda/bin:$PATH"

pip install -r requirements.txt

python run_task.py $1 $2


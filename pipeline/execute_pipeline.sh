#!/usr/bin/env bash
set -e

sudo yum groupinstall "Development Tools" -y
sudo yum install git -y
git clone https://github.com/edwardez/BangumiN.git && cd BangumiN
# for now we'll use code from develop branch, in the future we should use the master branch
git checkout origin/develop && cd pipeline

wget https://repo.continuum.io/miniconda/Miniconda3-4.5.4-Linux-x86_64.sh -O ~/miniconda.sh
bash ~/miniconda.sh -b -f -p $HOME/miniconda
export PATH="$HOME/miniconda/bin:$PATH"

pip install -r requirements.txt

python run_task.py $1 $2
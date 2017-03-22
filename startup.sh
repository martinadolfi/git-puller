#!/bin/bash
if [ ! -e $MYDIR ]
then
	echo "Creating $MYDIR directory"
	mkdir -p $MYDIR
else
	echo "Folder $MYDIR exists"
fi
if [ ! -e ~/.ssh/id_rsa.pub ]
then
	echo "Creating ssh key"
	mkdir -p /home/root/.ssh
	chmod 700 /home/root/.ssh
	ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
else
	echo "Key exists"
fi
echo "Public Key"
cat ~/.ssh/id_rsa.pub
cd $MYDIR
if [ ! -e $MYDIR/.git ]
then
	echo "Repo does not exists... cloning..."
	git clone -b $BRANCH $REPO $MYDIR
	git checkout $BRANCH
else
	echo "Repo exists, pulling..."
	git pull
	git checkout $BRANCH
fi

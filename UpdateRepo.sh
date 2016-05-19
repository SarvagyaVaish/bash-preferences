#!/bin/bash  

if [[ `git status --porcelain` ]]; then
	echo "Repo has local changes. Terminating.. "

else
	CurrentBranch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
	echo "---------------------------------"
	echo "Current branch is: $CurrentBranch"
	echo "---------------------------------"

	echo "----------------------"
	echo "Updating Github remote"
	echo "----------------------"
	git checkout remotes/github/master
	git fetch github --prune
	git pull github master

	echo "-------------------"
	echo "Updating SVN remote"
	echo "-------------------"
	git checkout remotes/trunk
	git svn rebase

	echo "--------------------"
	echo "Reset hard on master"
	echo "--------------------"
	git checkout master
	git reset --hard github/master

	echo "--------------------------------"
	echo "Switching back to $CurrentBranch"
	echo "--------------------------------"
	git checkout $CurrentBranch

fi

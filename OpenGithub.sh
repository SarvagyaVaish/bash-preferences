#!/bin/bash

## ====================================
## This is an adaptation of @jasonneylon's script.
## Source: http://jasonneylon.wordpress.com/2011/04/22/opening-github-in-your-browser-from-the-terminal/
## Original Script: https://gist.github.com/carmat/8728901
## ====================================

function url() {
	"C:/Program Files (x86)/Google/Chrome/Application/chrome.exe" $1
}

giturl=$(git config --get remote.github.url)
if [ "$giturl" == "" ] ; then
	echo "Not a git repository or no remote.github.url set"
	exit 1
fi

giturl=${giturl/git\@github\.com\:/https://github.com/}
branch="$(git symbolic-ref HEAD 2>/dev/null)" ||
branch="(unnamed branch)"     # detached HEAD
branch=${branch##refs/heads/}

if [ "$1" = "" ]; then ## default => current branch
	giturl=${giturl/\.git/\/tree/}
	giturl=$giturl$branch
	url $giturl

elif [ "$1" = "h" ]; then ## h => help
	echo ""
	echo "========================================"
	echo "Did you know that 'GH' can be used as is?"
	echo "There are also some other options, listed below:"
	echo "    [h]                      => View help"
	echo "    [c]                      => View commits"
	echo "    [c {SHA}]                => View specific commit from commit SHA"
	echo "    [b]                      => View branches"
	echo "    [pr]                     => View current branch compared to master"
	echo "    [pr branch]              => View current branch compared to specified branch"
	echo "    [i]                      => View issues"
	echo "    [w]                      => View wiki"
	echo "    [s]                      => View settings"
	echo "    [p]                      => View pulse"
	echo "    [g]                      => View graphs"
	echo "    [n]                      => View network"
	echo "========================================"
	echo ""

elif [ "$1" = "c" ]; then ## c => commits
	if [ "$2" ]; then
		giturl=${giturl/\.git/\/commit/$2}
	else
		giturl=${giturl/\.git/\/commits/}
		giturl=$giturl$branch
	fi
	url $giturl

elif [ "$1" = "b" ]; then ## branches
	giturl=${giturl/\.git/\/branches}
	url $giturl

elif [ "$1" = "pr" ]; then ## pull requests
	if [[ -z "$2" ]]; then
		# if a branch has not been specified, compare with master
		giturl=${giturl/\.git/\/compare/$branch}
	else
		# if a branch has been specified, compare with current branch
		giturl=${giturl/\.git/\/compare/$2...$branch}
	fi
	url $giturl

elif [ "$1" = "i" ]; then ## issues
	giturl=${giturl/\.git/\/issues}
	url $giturl

elif [ "$1" = "w" ]; then ## wiki
	giturl=${giturl/\.git/\/wiki}
	url $giturl

elif [ "$1" = "s" ]; then ## settings
	giturl=${giturl/\.git/\/settings}
	url $giturl

elif [ "$1" = "p" ]; then ## pulse
	giturl=${giturl/\.git/\/pulse}
	url $giturl

elif [ "$1" = "g" ]; then ## graphs
	giturl=${giturl/\.git/\/graphs}
	url $giturl

elif [ "$1" = "n" ]; then ## network
	giturl=${giturl/\.git/\/network}
	url $giturl

else
	echo ""
	echo "Not a valid option."
fi

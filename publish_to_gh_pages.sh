#!/bin/sh

echo "Deleting old publication"
rm -rf public
mkdir public
git worktree prune
rm -rf .git/worktrees/public/

echo "Checking out gh-pages branch into public"
git worktree add -B gh-pages public upstream/gh-pages

echo "Removing existing files"
rm -rf public/*

echo "Generating site"
hugo

echo "Copying CNAME to public"
cp CNAME public/

echo "Updating gh-pages branch"
cd public &&
git init &&
git checkout -B gh-pages &&
git remote add origin git@github.com:timani/timani.co.za.git &&
 git add --all && git commit -m "Publishing to gh-pages (publish.sh)"
echo "Pushing to github"
git branch
git remote -v
git push origin gh-pages

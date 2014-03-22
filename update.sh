#!/bin/sh -e
# 
# This script updates the assets
# 

tmpdir=tmp
archive=$tmpdir/archive.tar.gz
mkdir -p tmp

curl http://www.heise.de/extras/socialshareprivacy/jquery.socialshareprivacy.tar.gz > $archive
tar xf $archive -C $tmpdir

# images
rm -f vendor/assets/images/social_share_privacy/*
cp -v $tmpdir/socialshareprivacy/images/*               vendor/assets/images/social_share_privacy/

# stylesheets
sed 's/url(images\/\([^)]*\))/image-url("social_share_privacy\/\1")/' $tmpdir/socialshareprivacy/socialshareprivacy.css > vendor/assets/stylesheets/social_share_privacy.css.scss

# javascripts
target=vendor/assets/javascripts/social_share_privacy/
cp -vR $tmpdir/jquery.socialshareprivacy.js $target/index.js
cp -vR $tmpdir/socialshareprivacy/lang/* $target/

#rm -rf $tmpdir

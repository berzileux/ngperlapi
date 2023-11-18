FROM nginx/perl:latest

MAINTAINER "berlabs" <berzileux.berlabs@gmail.com>

# install your additional perl modules tha is not part of the default
# RUN ["cpanm", "a", "b", ...]
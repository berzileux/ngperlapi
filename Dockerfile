FROM nginx/perl:latest

MAINTAINER "freeperls" <berzileux@gmail.com>

# install your additional perl modules tha is not part of the default
# RUN ["cpanm", "a", "b", ...]
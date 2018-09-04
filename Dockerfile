FROM continuumio/miniconda3
MAINTAINER Susanna Kiwala <ssiebert@wustl.edu>

LABEL \
    description="Image for pVACtools" \
    version="1.0.2"

#pVACtools
RUN pip install pvactools==1.0.2

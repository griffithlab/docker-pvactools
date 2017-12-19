FROM continuumio/miniconda3
MAINTAINER Susanna Kiwala <ssiebert@wustl.edu>

LABEL \
    description="Image for pVACtools"

#pVACtools
RUN pip install -e git+git://github.com/griffithlab/pVACtools@master#egg=pvacseq

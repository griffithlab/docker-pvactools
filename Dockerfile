#License Agreements
#pVACtools is licensed under [NPOSL-3.0](http://opensource.org/licenses/NPOSL-3.0).

#By using the IEDB software, you are consenting to be bound by and become a "Licensee" for the use of IEDB tools and are consenting to the terms and conditions of the Non-Profit Open Software License ("Non-Profit OSL") version 3.0

#Please read these two license agreements [here](http://tools.iedb.org/mhci/download/) before proceeding. If you do not agree to all of the terms of these two agreements, you must not install or use the product. Companies (for-profit entities) interested in downloading the command-line versions of the IEDB tools or running the entire analysis resource locally, should contact us (license@iedb.org) for details on licensing options.

#Citing the IEDB
#All publications or presentations of data generated by use of the IEDB Resource Analysis tools should include citations to the relevant reference(s), found [here](http://tools.iedb.org/mhci/reference/).


FROM python:3.7-buster
MAINTAINER Susanna Kiwala <ssiebert@wustl.edu>

LABEL \
    description="Image for pVACtools without IEDB or BLAST" \
    version="3.1.2"

RUN apt-get update && apt-get install -y \
    tcsh \
    gcc \
    build-essential \
    zlib1g-dev \
    gawk

#pVACtools 3.1.2
RUN mkdir /opt/mhcflurry_data
ENV MHCFLURRY_DATA_DIR=/opt/mhcflurry_data
RUN pip install protobuf==3.20.0
RUN pip install tensorflow==2.2.2
RUN pip install pvactools==3.1.2
RUN mhcflurry-downloads fetch

CMD ["/bin/bash"]

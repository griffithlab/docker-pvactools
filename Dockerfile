#License Agreements
#pVACtools is licensed under [NPOSL-3.0](http://opensource.org/licenses/NPOSL-3.0).

#By using the IEDB software, you are consenting to be bound by and become a "Licensee" for the use of IEDB tools and are consenting to the terms and conditions of the Non-Profit Open Software License ("Non-Profit OSL") version 3.0

#Please read these two license agreements [here](http://tools.iedb.org/mhci/download/) before proceeding. If you do not agree to all of the terms of these two agreements, you must not install or use the product. Companies (for-profit entities) interested in downloading the command-line versions of the IEDB tools or running the entire analysis resource locally, should contact us (license@iedb.org) for details on licensing options.

#Citing the IEDB
#All publications or presentations of data generated by use of the IEDB Resource Analysis tools should include citations to the relevant reference(s), found [here](http://tools.iedb.org/mhci/reference/).


FROM python:3.7-buster
MAINTAINER Susanna Kiwala <ssiebert@wustl.edu>

LABEL \
    description="Image for pVACtools with IEDB" \
    version="4.0.1_mhci_3.1.4_mhcii_3.1.8"

RUN apt-get update && apt-get install -y \
    tcsh \
    gcc \
    build-essential \
    zlib1g-dev \
    gawk \
    vim

RUN mkdir /opt/iedb
COPY LICENSE /opt/iedb/.

#IEDB MHC I 3.1.4
WORKDIR /opt/iedb
RUN wget https://downloads.iedb.org/tools/mhci/3.1.4/IEDB_MHC_I-3.1.4.tar.gz
RUN tar -xzvf IEDB_MHC_I-3.1.4.tar.gz
WORKDIR /opt/iedb/mhc_i
RUN ./configure
COPY netmhccons_1_1_python_interface.3.1.1.py /opt/iedb/mhc_i/method/netmhccons-1.1-executable/netmhccons_1_1_executable/netmhccons_1_1_python_interface.py
WORKDIR /opt/iedb
RUN rm IEDB_MHC_I-3.1.4.tar.gz

#IEDB MHC II 3.1.8
WORKDIR /opt/iedb
RUN wget https://downloads.iedb.org/tools/mhcii/3.1.8/IEDB_MHC_II-3.1.8.tar.gz
RUN tar -xzvf IEDB_MHC_II-3.1.8.tar.gz
WORKDIR /opt/iedb/mhc_ii
RUN python ./configure.py -k netmhciipan -k smm -k nn
WORKDIR /opt/iedb
RUN rm IEDB_MHC_II-3.1.8.tar.gz

#pVACtools 4.0.1
RUN mkdir /opt/mhcflurry_data
ENV MHCFLURRY_DATA_DIR=/opt/mhcflurry_data
RUN pip install protobuf==3.20.0
RUN pip install tensorflow==2.2.2
RUN pip install pvactools==4.0.1
RUN mhcflurry-downloads fetch

CMD ["/bin/bash"]

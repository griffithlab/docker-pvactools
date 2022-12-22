#License Agreements
#pVACtools is licensed under [NPOSL-3.0](http://opensource.org/licenses/NPOSL-3.0).

#By using the IEDB software, you are consenting to be bound by and become a "Licensee" for the use of IEDB tools and are consenting to the terms and conditions of the Non-Profit Open Software License ("Non-Profit OSL") version 3.0

#Please read these two license agreements [here](http://tools.iedb.org/mhci/download/) before proceeding. If you do not agree to all of the terms of these two agreements, you must not install or use the product. Companies (for-profit entities) interested in downloading the command-line versions of the IEDB tools or running the entire analysis resource locally, should contact us (license@iedb.org) for details on licensing options.

#Citing the IEDB
#All publications or presentations of data generated by use of the IEDB Resource Analysis tools should include citations to the relevant reference(s), found [here](http://tools.iedb.org/mhci/reference/).


FROM griffithlab/pvactools:3.1.1-slim
MAINTAINER Susanna Kiwala <ssiebert@wustl.edu>

LABEL \
    description="Image for pVACtools. Includes IEDB MHC Class I and MHC Class II tools as well as BLAST." \
    version="3.1.1_mhci_3.1.2_mhcii_3.1.6_blast_2.12.0"

#BLAST
WORKDIR /opt
RUN wget https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.12.0/ncbi-blast-2.12.0+-x64-linux.tar.gz
RUN tar zxvpf ncbi-blast-2.12.0+-x64-linux.tar.gz
RUN rm ncbi-blast-2.12.0+-x64-linux.tar.gz
RUN mkdir /opt/blastdb
ENV BLASTDB=/opt/blastdb
WORKDIR /opt/blastdb
RUN perl /opt/ncbi-blast-2.12.0+/bin/update_blastdb.pl --passive --decompress refseq_select_prot

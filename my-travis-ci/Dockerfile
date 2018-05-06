FROM steinwaywhw/ats-base
MAINTAINER Steinway Wu "https://github.com/steinwaywhw"

WORKDIR /tmp

ADD ./*.sh /tmp/
RUN chmod +x *.sh 

ARG ATSVER 

ENV HOME=/root
ENV CC=gcc

ENV ATSVER=$ATSVER
ENV ATSHOME=${HOME}/ats-lang-anairiats-${ATSVER}
ENV ATSHOMERELOC=ATS-${ATSVER}

ENV PATSHOME=${HOME}/ATS-Postiats
ENV PATSCONTRIB=${HOME}/ATS-Postiats-contrib
ENV PATSHOME_contrib=${HOME}/ATS-Postiats-contrib

ENV PATH=${PATH}:${PATSHOME}/bin

WORKDIR ${HOME}
RUN git clone https://github.com/ats-lang/ATS-Postiats-release/ ${HOME}/ATS-Postiats

WORKDIR /tmp
RUN (cd ${HOME}     && /tmp/install_ats1.sh)
RUN (cd ${PATSHOME} && /tmp/install_ats2.sh)
RUN (cd ${HOME}     && /tmp/install_contrib.sh)
RUN (cd ${PATSHOME} && /tmp/install_utilities.sh)

WORKDIR /tmp
RUN rm -rf *
CMD patscc -vats

FROM centos:7

COPY compile-iscloc.sh /compile-iscloc.sh

ENV SLBM_VERSION=3.0.4 \
    QETC=/usr/src/iscloc/etc/ \
    SLBMROOT=/usr/src/slbm/ \
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$SLBMROOT/lib \
    RSTT_SUPPORT=false

RUN \
  rpm --rebuilddb && yum clean all && \
  yum install -y \
    wget \
    tar \
    make \
    automake \
    gcc \
    gcc-c++ \
    postgresql \
    postgresql-devel \
    lapack-devel \
    lapack \
    blas \
    blas-devel \
    ncurses-devel && \
  curl --progress-bar --ipv4 --connect-timeout 8 --retry-delay 10 --max-time 120 --retry 128 --ftp-ssl --disable-epsv --ftp-pasv -o /tmp/iscloc.tgz ftp://anonymous@isc-mirror.iris.washington.edu/pub/iscloc/ISCloc.tar.gz && \
  mkdir -p /usr/src/iscloc && \
  tar zxf /tmp/iscloc.tgz -C /usr/src/iscloc --strip-components=1 && rm -f /tmp/iscloc.tgz && \
  sed -i 's|/export/home/istvan/ISClocRelease2.2.6|/usr/src/iscloc|g' /usr/src/iscloc/etc/iscloc/config.txt && \
  wget -q -O /tmp/slbm.tgz http://www.sandia.gov/rstt/downloads/SLBM_Root.${SLBM_VERSION}.Linux.tar.gz && \
  mkdir -p /usr/src/slbm && \
  tar zxf /tmp/slbm.tgz -C /usr/src/slbm --strip-components=1 && rm -f /tmp/slbm.tgz && \
  cd /usr/src/slbm && make clean_objs && make geotess && make cc && make c && /usr/src/slbm/environment_variables.sh && \
  /compile-iscloc.sh && rm -f /compile-iscloc.sh && \
  yum remove -y wget make automake gcc gcc-c++ postgresql-devel lapack-devel blas-devel ncurses-devel && \
  yum clean all && \
  rm -rf /var/cache/yum

COPY container-files /

ENTRYPOINT ["/bootstrap.sh"]

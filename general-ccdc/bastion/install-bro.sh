#!/bin/sh 

# Installs Bro on Redhat or Debian Linux.
if [ "$(id -u)" -ne "0" ] ; then
  echo "must be root to install Bro"
fi

# Defaults
flavor=redhat
prefix=/opt/bro
src=src

# Parse command line.
while getopts "edf:p:s:h?" opt ; do
  case "$opt" in
    h|\?)
      printf "usage: %s -f flavor [-ed] [-p prefix]\n" $(basename $0)
      exit 0
      ;;
    e)
      set -e
      ;;
    d)
      set -x
      ;;
    f)
      flavor=$OPTARG
      ;;
    p)
      prefix=$OPTARG
      ;;
    s)
      src=$OPTARG
      ;;
  esac
done

# Remove parsed arguments.
shift $(expr $OPTIND - 1)

# Verify parameters.
if [ "$flavor" = "redhat" -a "$flavor" = "debian" ] ; then
  echo "missing Linux flavor"
  exit 1
fi

# Don't install twice.
if [ -f "$prefix/bin/bro" ] ; then
  echo "bro already intalled in $prefix"
  exit 1
fi

# Install Bro dependencies.
if [ "$flavor" = "redhat" ] ; then
  yum install git cmake make gcc gcc-c++ flex bison libpcap-devel \
    openssl-devel python-devel swig zlib-devel file-devel
elif [ "$flavor" = "debian" ] ; then
  apt-get install git cmake make gcc g++ flex bison libpcap-dev \
    libssl-dev python-dev swig zlib1g-dev libmagic-dev
fi

# Install Bro.
mkdir -p "$src"
cd "$src"
git clone --recursive git://git.bro.org/bro.git
cd bro
./configure --prefix=$prefix
make
make install

# Append a crontab entry.
entry="0-59/5 * * * * $prefix/bin/broctl cron > /dev/null"
(crontab -l; echo "$entry" ) | crontab -

# Tweak capture performance.
sysctl -w net.core.rmem_max=8388608
sysctl -w net.core.wmem_max=8388608
sysctl -w net.core.rmem_default=65536
sysctl -w net.core.wmem_default=65536
sysctl -w net.ipv4.tcp_rmem='4096 87380 8388608'
sysctl -w net.ipv4.tcp_wmem='4096 65536 8388608'
sysctl -w net.ipv4.tcp_mem='8388608 8388608 8388608'
sysctl -w net.ipv4.route.flush=1

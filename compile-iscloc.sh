#!/usr/bin/env bash
set -eu
export TERM=xterm
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$SLBMROOT/lib
# Bash Colors
green=`tput setaf 2`
bold=`tput bold`
reset=`tput sgr0`
# Logging Functions
log() {
  if [[ "$@" ]]; then echo "${bold}${green}[LOG `date +'%T'`]${reset} $@";
  else echo; fi
}

edit_config() {
  log "Updating \$QETC"
  sed -i 's|/export/home/istvan/TESTENV/etc/|'$QETC'|g' /usr/src/iscloc/etc/iscloc/config.txt
  sed -i 's|/export/home/istvan/SLBM_Root.3.0.2.Linux/models/rstt.2.3.geotess|'$SLBMROOT'/models/rstt201404.geotess|g' /usr/src/iscloc/etc/iscloc/config.txt
}
compile-isclock() {
  log "Compiling normal iscloc"
  sed -i 's|use_RSTT_PgLg = 1|use_RSTT_PgLg = 0|g' /usr/src/iscloc/etc/iscloc/config.txt
  cd /usr/src/iscloc/src
  make serial_nodb
  cp iscloc_nodb /usr/bin/iscloc
  log "iscloc compiled"
}
compile-isclock-rstt() {
  log "Compiling RSTT version of iscloc"
  sed -i 's|use_RSTT_PgLg = 0|use_RSTT_PgLg = 1|g' /usr/src/iscloc/etc/iscloc/config.txt
  cd /usr/src/iscloc/rstt_src
  make serial_nodb
  cp iscloc_rstt_nodb /usr/bin/iscloc_rstt
  log "iscloc_rstt compiled"
}
edit_config
compile-isclock
compile-isclock-rstt

log "ISCloc Compilation finished."

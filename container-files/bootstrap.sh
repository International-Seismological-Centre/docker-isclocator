#!/usr/bin/env bash
set -eu
export TERM=xterm
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$SLBMROOT/lib
IN_FILE=$1
OUT_FILE=$2
LOC="iscloc"
# Bash Colors
green=`tput setaf 2`
bold=`tput bold`
reset=`tput sgr0`
# Logging Functions
log() {
  if [[ "$@" ]]; then echo "${bold}${green}[OK `date +'%T'`]${reset} $@";
  else echo; fi
}

run_iscloc() {
  if [[ ${RSTT_SUPPORT} == "true" ]]; then
    log "Starting ISC Locator with RSST support"
    LOC="iscloc_rstt"
    echo "update_db=0 isf_infile=${IN_FILE} isf_outfile=${OUT_FILE}" | ${LOC} isf
    log "RSTT ISC Locator finished. File saved in location: ${OUT_FILE}"
  else
    log "Starting ISC Locator"
    echo "update_db=0 isf_infile=${IN_FILE} isf_outfile=${OUT_FILE}" | ${LOC} isf
    log "ISC Locator finished. File saved in location: ${OUT_FILE}"
  fi
}

run_iscloc

CMSREP_SERVER=cmsrep.cern.ch
CMSREP_IB_SERVER=cmsrep.cern.ch
CMSBUILD_OPTS_FILE="etc/build_options.sh"
BUILD_OPTS=""
MULTIARCH_OPTS=""
export CMS_PYTHON_TO_USE="python"
if which python3 >/dev/null 2>&1 ; then export CMS_PYTHON_TO_USE="python3" ; fi

#called with $BUILD_OPTS $MULTIARCH_OPTS
function cmsbuild_args()
{
  arg=""
  [ "$1" != "" ] && arg="${arg} --build-options $1"
  [ "$2" != "" ] && arg="${arg} --vectorization $2"
  [ "${arg}" = "" ] || echo "${arg}"
}

function cmssw_default_target()
{
  case $1 in
    *SKYLAKE*|*SANDYBRIDGE*|*HASWELL*|*MULTIARCHS*) echo auto ;;
    *) echo default ;;
  esac
}

function cmsbuild_argsX()
{
  case $1 in
    CMSSW_*_SKYLAKEAVX512* ) echo --vectorization haswell,skylake-avx512 ;;
    CMSSW_*_SANDYBRIDGE* ) echo --vectorization sandybridge ;;
    CMSSW_*_HASWELL* ) echo --vectorization haswell ;;
    CMSSW_*_MULTIARCHSV4* ) echo --vectorization x86-64-v4 ;;
    CMSSW_*_MULTIARCHSV3* ) echo --vectorization x86-64-v3 ;;
    CMSSW_*_MULTIARCHS* ) echo --vectorization x86-64-v3 ;;
    * ) ;;
  esac
}

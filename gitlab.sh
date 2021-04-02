git clone --recursive https://github.com/skvark/opencv-python
cd opencv-python

export MB_PYTHON_VERSION=3.9
export OPENCV_VERSION=4.2.0
export ENABLE_CONTRIB=0
export ENABLE_HEADLESS=0

source multibuild/common_utils.sh
source multibuild/manylinux_utils.sh
source multibuild/configure_build.sh
source multibuild/library_builders.sh
export PYTHON_EXE=$(cpython_path $MB_PYTHON_VERSION)/bin/python
export PATH="$(dirname $PYTHON_EXE):$PATH"

mkdir -p wheelhouse
(cd opencv; git checkout $OPENCV_VERSION)
(cd opencv_contrib; git checkout $OPENCV_VERSION)
pip wheel -vv -w wheelhouse .
auditwheel repair wheelhouse/opencv*.whl

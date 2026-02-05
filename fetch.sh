#!/bin/sh -ex
# Now need uv to install the python package
curl -LsSf https://astral.sh/uv/0.9.29/install.sh | sh
BRANCH=v26.01.x
# Version v26.01
# https://github.com/spdk/spdk/commit/2ef883ef96e79c3cc16da02f667a7a58c2453f2f
COMMIT=2ef883ef96e79c3cc16da02f667a7a58c2453f2f
git clone -b $BRANCH https://github.com/spdk/spdk --recursive spdk.src
( cd spdk.src ; git checkout $COMMIT )
rsync -rv --exclude=.git spdk.src/* .
# This patch is a backport of
# - https://github.com/spdk/spdk/commit/b1c54ce34d1d5cbd619c64f8432edc1737baad0e
#
# It needs to be applied EARLY before debuild (for the scripts/pkgdep.sh call)
# which it why it is being singled out for special treatment.  It will be dropped
# whenever we rebase of an upstream version that already includes it.
patch -p1 < 0001-pkgdep-pin-pip-version-to-26.patch
rm -rf spdk.src fetch.sh 0001-pkgdep-pin-pip-version-to-26.patch

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
rm -rf spdk.src fetch.sh

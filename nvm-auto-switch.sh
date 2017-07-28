#!/bin/sh

# The MIT License (MIT)
#
# Copyright (c) 2016 Lalit Kapoor
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

if [ "$(command -v nvm)" == "" ]; then
  if [ -s "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh"
  else
    echo "could not find nvm"
  fi
fi

# based on https://github.com/creationix/nvm/issues/603#issuecomment-88617225
nvm_auto_switch() {
  local NVM_RC_FILE
  local DEFAULT_VERSION
  local NVM_VERSION
  NVM_RC_FILE=`nvm_find_nvmrc`

  if [ "$NVM_RC_FILE"  == "" ]; then
    DEFAULT_VERSION="$(nvm_alias default 2>/dev/null || echo)"
    NVM_VERSION="$(nvm_version $DEFAULT_VERSION)"
  else
    NVM_VERSION=`cat $NVM_RC_FILE`
  fi

  [ "$(nvm_version_path $NVM_VERSION)/bin" == "$NVM_BIN" ] || nvm use "$NVM_VERSION"
}

cd() { builtin cd "$@"; nvm_auto_switch; }

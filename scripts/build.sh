# Copyright (c) 2017 AndreaSonny <andreasonny83@gmail.com> (https://github.com/andreasonny83)
#
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

#!/bin/bash

# Clean up previous build
rm -rf dist
rm -rf build

# Variable pointing to Angular Compiler CLI
NGC="node_modules/.bin/ngc"
ROLLUP="node_modules/.bin/rollup"

# Run Angular Compiler
$NGC -p ./tsconfig-build.json
$ROLLUP build/ng-library.js -f es -o dist/ng-library.js
# $ROLLUP build/ng-library.js --config rollup-build.config.js

# Generate ES5 version
$NGC -p ./tsconfig-es5.json
$ROLLUP build/ng-library.js -f es -o dist/ng-library.es5.js
# Generate UMD version
$ROLLUP --config rollup.umd.config.js

rsync -a --exclude=*.js build/ dist

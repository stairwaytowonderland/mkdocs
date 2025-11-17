#!/usr/bin/env python3

import sys

if sys.prefix == sys.base_prefix:
    sys.stderr.write("Not in a virtual environment.\n")
    sys.exit(1)
else:
    sys.stderr.write("Inside a virtual environment.\n")

sys.exit(0)

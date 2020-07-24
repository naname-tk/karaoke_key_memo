#!/bin/bash

echo "phpdoc";
phpdoc run -d app -t /src/output-docs
echo "output /src/output-docs"

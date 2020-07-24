#!/bin/bash

echo "phpstan";
./vendor/bin/phpstan analyse --memory-limit=2G

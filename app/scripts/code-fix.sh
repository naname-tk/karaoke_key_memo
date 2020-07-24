#!/bin/bash

echo "diff or fix ?";

#入力を受付、その入力を「str」に代入
read choise

if [ $choise = "diff" ] ; then
  # DIFF
  echo "./vendor/bin/php-cs-fixer fix --dry-run --diff --diff-format udiff";
  ./vendor/bin/php-cs-fixer fix --dry-run --diff --diff-format udiff
elif [ $choise = "fix" ] ; then
  # FIX
  echo "./vendor/bin/php-cs-fixer fix";
  ./vendor/bin/php-cs-fixer fix
else
  # OTHER
  echo "Please enter 'diff' or 'fix'";
fi

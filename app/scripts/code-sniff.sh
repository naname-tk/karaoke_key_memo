#!/bin/bash

echo "check or fix ?";

#入力を受付、その入力を「str」に代入
read choise

if [ $choise = "check" ] ; then
  # DIFF
  echo "./vendor/bin/phpcs ./app";
  ./vendor/bin/phpcs ./app
elif [ $choise = "fix" ] ; then
  # FIX
  echo "./vendor/bin/phpcbf ./app";
  ./vendor/bin/phpcbf ./app
else
  # OTHER
  echo "Please enter 'check' or 'fix'";
fi

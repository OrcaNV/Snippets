#!/bin/bash

date
# 300 seconds is 5 minutes
ps axh -O etimes | grep emailAesBooking.js | grep -v grep | awk '{if ($2 >= 300) print $1}' | xargs kill

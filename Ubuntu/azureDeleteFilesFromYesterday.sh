#!/bin/bash
yester=`date -d "yesterday 13:00 " '+%Y%m%d'`
echo $yester

        for i in `azure storage blob list data | grep data | grep sg | grep $yester | tr -s ' ' | cut -d ' ' -f2`;
        do
                echo Deleting $i
                azure storage blob delete -q data $i
        done


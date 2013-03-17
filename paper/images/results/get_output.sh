#!/bin/bash

scp -i ~/.ssh/id_rsa2 -P 1004 root@vienna.studlab.os3.nl:{output.png,results.csv} .

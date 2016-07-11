#!/bin/bash

screen -dm -L -S clean_ALDC python clean_ALDC.py
screen -dm -S clean_FLGA -L python clean_FLGA.py
screen -dm -S clean_HIKS -L python clean_HIKS.py
screen -dm -S clean_KYOH -L python clean_KYOH.py
screen -dm -S clean_OKTN -L python clean_OKTN.py
screen -dm -S clean_TX -L python clean_TXWY.py
screen -dm -S clean_Failed -L python clean_Failed.py
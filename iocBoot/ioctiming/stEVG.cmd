#!../../bin/linux-x86_64/timing

## You may have to change timing to something else
## everywhere it appears in this file

< envPaths
< EVG.config

# ################################

epicsEnvSet("STREAM_PROTOCOL_PATH", "$(TOP)/timingApp/Db")

## Register all support components
dbLoadDatabase("${TOP}/dbd/timing.dbd")
timing_registerRecordDeviceDriver pdbbase

asSetFilename("$(TOP)/timingApp/Db/accessSecurityFile.acf")

drvAsynIPPortConfigure ("${PORT}", "${IPADDR}:${IPPORT}:${IPPORT} udp",0,0,0)

## Load record instances

# EVG
dbLoadRecords("${TOP}/db/evg.db", "P=${P}, R=${R}, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords "${TOP}/db/SeqRAM.db", "P=${P}, R=${R}"

# Events
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=0, desc='Li Inj event', code=01, time=100, mode=0, transm=0"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=1, desc='BO Inj event', code=02, time=150, mode=1, transm=0"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=2, desc='BO ramp event', code=03, time=160, mode=1, transm=0"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=3, desc='SI Inj event', code=04, time=170, mode=1, transm=0"

dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=4, desc='Diagnostic', code=05, time=180, mode=1, transm=0"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=5, desc='Undefined', code=06, time=190, mode=1, transm=0"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=6, desc='Undefined', code=07, time=200, mode=1, transm=0"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=7, desc='Undefined', code=08, time=210, mode=1, transm=0"

dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=8, desc='Undefined', code=09, time=220, mode=1, transm=0"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=9, desc='Undefined', code=0A, time=230, mode=1, transm=0"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=10, desc='Undefined', code=0B, time=240, mode=1, transm=0"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=11, desc='Undefined', code=0C, time=250, mode=1, transm=0"

dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=12, desc='Undefined', code=0D, time=260, mode=1, transm=0"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=13, desc='Undefined', code=0E, time=270, mode=1, transm=0"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=14, desc='Undefined', code=0F, time=280, mode=1, transm=0"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=15, desc='Undefined', code=10, time=290, mode=1, transm=0"

# < save_restore.cmd

## Run this to trace the stages of iocInit
#traceIocInit

iocInit

## Start any sequence programs

# Module initialization and network status
seq sncEVGSetup, "P=${P}, R=${R}"

# Injection System State Machine
seq sncSeqRAM, "P=${P}, R=${R}, ev_num=${EVENT_NUM}"


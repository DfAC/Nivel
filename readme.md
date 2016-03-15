# Leica Nivel 220 processing

This is R code for processing Leica Nivel 220 data collected using [port sniffer](https://technet.microsoft.com/en-us/sysinternals/bb896644)


## How to collect data

* start [port sniffer](https://technet.microsoft.com/en-us/sysinternals/bb896644) and select Nivel COM port
	* In Windows make sure that COM port is <5 and that speed is the same as set up for Leica Nivel
* start Leica Nivel 220 software
	* setup Leica Nivel 220 to output data
* record data on sniffer
* process data in R


## How to process Data

* clean output using Unix tools
* run R scripts
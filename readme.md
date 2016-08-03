
This is the code for processing Leica Nivel 220 reading, part of University of Nottingham H24VEP MSc course (Project 3 Bridge monitoring). For more details check my [TeachingSlides](https://github.com/DfAC/TeachingSlides/tree/master/H24VEP_Bridge).
Work with [Leica Nivel 220](http://leica-geosystems.com/products/levels/leica-nivel210_220) requires three stage approach:

* Data collection;
  * in Windows data is collected using [port sniffer](https://technet.microsoft.com/en-us/sysinternals/bb896644).
* Data parsing;
* Data analysis;


# Data collection

* set up  Nivel220 sensor (RS485 interface) and connect it to the laptop via USB converter
* start [Portmon for Windows v3.03](https://technet.microsoft.com/en-us/sysinternals/bb896644) port sniffer and select Nivel COM port
  * In Windows make sure that COM port is <5 and that speed is the same as set up for Leica Nivel
* start Leica Nivel 220 **NivelTool** software
  * setup **NivelTool** to output data continously
* start recording data on sniffer
  * make sure that time is set to UTC time and synchronisation with network is set

## connecting directly to Nivel 220

* Leica recommend using [Hercules](http://www.hw-group.com/products/hercules/index_en.html) as commands have to be send as hex
* for command details check

# Data parsing

# Exploratory data analysis

Before we parse data it is important to understand it.

## set up

We are using **NivelTool** soft to extract information.

* Use `grep "N1C1" 008.LOG | cut -d. -f4 | sort | uniq -c` to list commands used
  * `N1C1 W N 008; N1C1 PS` set sample average
    * this sets no of measurements to average before producing measurements
  * get Nivel sensor information - `N1C1 RB [A B D I]`, sensor offsets - `N1C1 RP [OX OY OT]`
  * reading is triggered by `N1C1 G A` command with the answer as `CxNx X:vz.zzz Y:vz.zzz T:vz.zz` where
    * X,Y - inclinations-cross and inclinations-length values in in mrad (0.001 rad)

cc | " | mrad | μrad
:-: |:-:| :-:  | :-:
1 | 0.324 | 1.570796E-3 | 1.570796
3.08641975 | 1 | 4.848136E-3 | 4.848136
636.61977 | 206.2648062 | 1 | 1000
0.63661977 | 0.206264806 | 0.001 | 1
      *
    * T -
    * The NIVEL200 sensor detects inclinations at a rate of once a second. Before being displayed, these values are then corrected according to the correction factors
    * The temperature inside the NIVEL200 sensor is measured every 10 seconds and the signal is directly accessible
    * see [TechRef](https://github.com/DfAC/Nivel/blob/master/Docs/Nivel200_TechRef.pdf) for more information.
* `SUCCESS  Length` response come from sniffer


## Bash/cmd line approach

A simplest way to parse the code is to use **bash**[^Cmder] and script below:


```
FOR /f %%F IN ('dir /b *.log') DO (
grep "C1N1 X" %%F | tr -s ' ' | cut -d" " -f1,2,7-9 | cut -d. -f1-4 | tr -s ' ' ',' > %%~nF.csv
)
```
This code can also be executed by running ExtractNivel.bat.

## python

Compile **ParserSnifferData.py** using [py2exe](https://pypi.python.org/pypi/py2exe/#installation). Note that official version is for python 3.3 so don't use pip and install from link instead.


# Data analysis

* A [RStudio](https://www.rstudio.com/) script (*NivelAnalysis.Rmd*) is provided as a sample.
* *exploreTime.bat* and *exploreTime.plt* is an example of visual analysis using GNUplot.





[^Cmder]: The easiest way to run bash in windows is to install [cmder](http://cmder.net/). It allows to run bash from Windows cmd, or run native bash envorment inside Windows. It also looks nicer than *cygwin* or native *cmd.exe*.

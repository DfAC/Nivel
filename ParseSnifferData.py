"""
LKB (c) 2016

Processing Nivel220 sensor (RS485 interface) output, as collected by Portmon for Windows port sniffer.
Output:
Time, X,Y,T
"""

#import pandas as pd
#import numpy as np
#import scipy
import glob, os  #for file handling

import re #advanced text
import pdb #debugger


#################################################################
############## SUPPORT FUNCTION DEFINITIONS
#################################################################

# parser Nivel220 sensor (RS485 interface) output from Portmon for Windows
def parserNivel(dataFileName):

  # get output file
  ##################
  outFile = open("%s.out" % dataFileName[:dataFileName.index('.')], "w")
  iErrorCounter = 0
  iLineCounter = 0
  print "\tProcessing {}...".format(dataFileName)

  # extract readings
  ##################
  for line in open(dataFileName).readlines():
    if line.find('C1N1 X')>0:
      Val =  line.split(" ")
      iLineCounter=iLineCounter+1

      try:
        time = Val[2:3]
        Val =  Val[9:12] #get X= Y= T=
        Val=' '.join(Val).split('.')[:4]  #remove noise at the end
        Val = re.split(' |:', '.'.join(Val))[1::2] #X Y T
        Val = time + Val  #time X Y T
        outString = "{d[0]},{d[1]},{d[2]},{d[3]}\n".format(d=Val)
        outFile.write(outString)

      except ValueError:
        print "Reading error at %s: %s" % (Val[2],ValueError)
        iErrorCounter=iErrorCounter+1

  # finalise outputs
  ##################
  print "\n\nReading errors:%i \n Lines Read:%i \n" %(iErrorCounter,iLineCounter)     
  outFile.close()

#################################################################
############## MAIN BODY STARTS HERE 
#################################################################
if __name__ == "__main__":


  os.chdir("./") #get current dir
  print("Found the following Nivel sensor log files:\n")
  for file in glob.glob("*.log"):
    parserNivel(file)

  print "\tAll is done now."
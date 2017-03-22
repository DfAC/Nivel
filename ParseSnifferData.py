"""
LKB (c) 2016-17

Processing Nivel220 sensor (RS485 interface) output, as collected by Portmon for Windows port sniffer.
Output:
Time, X,Y,T

written for python 2.7
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
      line = re.sub(": ", ":", line) #remove gaps
      #Val =  line.split(" ") #only one argument allowed
      Val =  re.split('[\t ]',line)
      Val = list(filter(None, Val)) #remove empty elements
      iLineCounter=iLineCounter+1

      try:
        time = Val[1]
        #to get X= Y= T= we need to id it first
        #base_index=Val.index('.G..C1N1') #to find index of item
        base_index=[idx for idx, str in enumerate(Val) if 'C1N1' in str][0] #find part of string
        #I can't just list it from the back as sometimes parser breaks last field
        Val =  Val[base_index+1:base_index+4] #get X= Y= T=
        Val[-1] = Val[-1].strip()[:-1]   #remove noise at the end
        Val = re.split(' |:', ' '.join(Val))[1::2] #X Y T
        Val.append(time) #X Y T time
        #pdb.set_trace()
        outString = "{d[3]},{d[0]},{d[1]},{d[2]}\n".format(d=Val)
        #time X Y T
        #
        outString = re.sub("\+", "", outString) #remove +

        outFile.write(outString)

      except: #ValueError:
        print "Reading error at %s: %s" % (line,ValueError)
        #pdb.set_trace()
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
"""
LKB (c) 2016

Processing Nivel220 sensor (RS485 interface) output, as collected by Portmon for Windows port sniffer.
Output:
Time, X,Y,T
"""

#import pandas as pd
import numpy as np
import scipy
import getopt

import re #advanced text
import pdb #debugger


#################################################################
############## SUPPORT FUNCTION DEFINITIONS
#################################################################



#################################################################
############## MAIN BODY STARTS HERE 
#################################################################
if __name__ == "__main__":

  
  # get input file
  ##################
  inFile = '008.LOG'
  outFile = open("%s.out" % inFile[:inFile.index('.')], "w")
  iErrorCounter = 0
  iLineCounter = 0

  # extract readings
  ##################

  for line in open(inFile).readlines():
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
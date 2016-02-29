import numpy as np
import matplotlib.pyplot as plt
import matplotlib.figure as fig
import sys, getopt

class data_struc:
  def __init__(self, filename):
    self.data=np.loadtxt(filename,usecols=[1,2,3,4,5,6,7])
    self.atms= self.get_parameters("atm")
    self.zeniths= self.get_parameters("zenith")
    self.wobbles= self.get_parameters("wobble")
    self.noises= self.get_parameters("noise")
    self.energies=self.get_parameters("energy")
  def get_parameters(self,parameter):
    energy=False
    if(parameter=="atm"):
      col = 0
    if(parameter=="zenith"):
      col = 1
    if(parameter=="wobble"):
      col = 2
    if(parameter=="noise"):
      col = 3
    if(parameter=="energy"):
      col = 4
      energy=True
    num,params=np.histogram(self.data[:,col],bins=1e3)
    k=0
    for i in range(len(params)):
      if energy:
        params[i]=params[i]
      else:
        params[i]=np.ceil(params[i])
    close_p = params[num>0]
    parameter=np.zeros(len(close_p))
    for i in range(len(close_p)):
      for m in range(len(self.data[:,col])):
        if (close_p[i]-self.data[m,col])<1e-3:
          parameter[k]=self.data[m,col]
          k=k+1
          break
    return parameter
  def get_EvRes_frozen_params(self, atm,zenith,wobble,noise,res="res"):
    atms=self.data[:,0]
    zeniths=self.data[:,1]
    wobbles=self.data[:,2]
    noises=self.data[:,3]
    energies=np.zeros(len(self.energies))
    Res=np.zeros(len(self.energies))
    k=0
    for i in range(len(self.data[:,0])):
      if (atm==atms[i]) and (zenith==zeniths[i]) and (wobble==wobbles[i]) and (noise==noises[i]):
        energies[k]=self.data[i,4]
        if (res=="res"):
          Res[k]=self.data[i,5]
          k=k+1
        elif (res=="rms"):
          Res[k]=self.data[i,6]
          k=k+1
    return energies,Res 

class plotResolutions:
  def __init__(self):
    self.energy_label="Energy (MeV)"
    self.resolution_label="Resolution (Degrees)"
    self.energy_scale="log"
    self.save_folder="/a/home/tehanu/dribeiro/Analysis/CrabSim/Plots/"

  def single_sim(self,E,Res,figure):
    plt.figure(figure)
    plt.subplot(111)
    plt.plot(E,Res,'.')
    plt.ylabel(self.resolution_label)
    plt.xlabel(self.energy_label)
    plt.xscale(self.energy_scale)
    
  def savePlot(self,figure):
    plt.figure(figure)
    plt.savefig(''.join([self.save_folder,"SinglePlot.pdf"]))
    print "Saving to %s" %( ''.join([self.save_folder,"SinglePlot.pdf"]))
  def clear_plots(self):
    plt.close('all')
    

def main(argv):
  Test_import()

def Test_import():
  filename = "/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes/Results_disp_old.txt"
  d=data_struc(filename)
  E1,Res1=d.get_EvRes_frozen_params(21, 65,50,400)
  E2,Res2=d.get_EvRes_frozen_params(21, 65,50,350)
  print Res1, Res2
  p=plotResolutions()
  p.clear_plots()
  p.single_sim(E1,Res1,1)
  p.single_sim(E2,Res2,1)
  p.savePlot(1)

if __name__ == '__main__':
  print 'This program is being run by itself'
  main(sys.argv[1:])
else:
  print 'I am being imported from another module'
  Test_import()

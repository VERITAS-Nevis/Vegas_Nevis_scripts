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
    self.size=len(self.data[:,0])
    if ("disp_new" in filename):
      self.label="disp_new"
    elif ("disp_old" in filename):
      self.label="disp_old"
    elif ("geo" in filename):
      self.label="geo"
    else:
      self.label=""
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
    num,params=np.histogram(self.data[:,col],bins=1e3)
    params=params[:-1]
    k=0
    for i in range(len(params)):
      params[i]=np.ceil(params[i])
    close_p = params[num>0]
    parameter=np.zeros(len(close_p))
    for i in range(len(close_p)):
      for m in range(len(self.data[:,col])):
        if (abs(close_p[i]-self.data[m,col]))<1e-3:
          parameter[k]=self.data[m,col]
          k=k+1
          break
    return parameter
  def get_EvRes_frozen_params(self, atm,zenith,wobble,noise,res="res"):
    atms=self.data[:,0]
    zeniths=self.data[:,1]
    wobbles=self.data[:,2]
    noises=self.data[:,3]
    energies=[]
    Res=[]
    k=0
    for i in range(self.size):
      if (atm==atms[i]) and (zenith==zeniths[i]) and (wobble==wobbles[i]) and (noise==noises[i]):
        energies=np.append(energies,self.data[i,4])
        if (res=="res"):
          Res=np.append(Res,self.data[i,5])
        elif (res=="rms"):
          Res=np.append(Res,self.data[i,6])
    return energies,Res 

class plotResolutions:
  def __init__(self,d):
    self.energy_label="Energy (GeV)"
    self.resolution_label="Resolution (Degrees)"
    self.energy_scale="log"
    self.xlim=[1e2,1e4]
    self.ylim=[0.1,0.3]
    self.save_folder="/a/home/tehanu/dribeiro/Analysis/CrabSim/Plots/"
    self.d = d
    self.linestyle=':'
    self.nZen=len(self.d.zeniths)
    self.cm='jet'
    self.set_colormap(self.cm)
    self.method_label=d.label

  def add_single_sim(self,E,Res,figure,color='k',marker='o',label=''):
    plt.figure(figure, figsize=[14,10])
    plt.subplot(111)
    plt.plot(E,Res,marker,color=color,linestyle=self.linestyle,label=label)
    plt.ylabel(self.resolution_label)
    plt.xlabel(self.energy_label)
    plt.xscale(self.energy_scale)
    plt.xlim(self.xlim)
    plt.ylim(self.ylim)

  def set_linestyle(self,linestyle):
    self.linestyle=linestyle
  
  def set_colormap(self,cm):
    self.cm=cm
    cmap=plt.get_cmap(self.cm)
    self.colors=[cmap(i) for i in np.linspace(0, 1, self.nZen)]

  def savePlot(self,figure,filename="Single_Sim.pdf"):
    plt.figure(figure)
    plt.savefig(''.join([self.save_folder,filename]))
    print "Saving to %s" %( ''.join([self.save_folder,filename]))

  def clear_plots(self):
    plt.close('all')
    
  def vary_zeniths(self,figure,marker='o',wobble=50,noise=350,atms=21,resolution="res"):
    for i in range(self.nZen):
      E,res=self.d.get_EvRes_frozen_params(atms,self.d.zeniths[i],wobble,noise,resolution)
      self.add_single_sim(E,res,figure,color=self.colors[i],marker=marker,label=str(self.d.zeniths[i])+" "+self.method_label)
      plt.legend(loc='best')
      E=[]
      res=[]
  def single_zenith(self,zenith, wobble, noise, resolution,figure=0,atm=21,color='k',marker='o'):
    E,res=self.d.get_EvRes_frozen_params(atm,zenith,wobble,noise,resolution)
    self.add_single_sim(E,res,figure,color=color,marker=marker,label=str(zenith)+" "+self.method_label)
    plt.legend(loc='best')

def main(argv):
  Test_import()

def Test_import():
  filename = "/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes/Results_geo.txt"
  d=data_struc(filename)
  #E1,Res1=d.get_EvRes_frozen_params(21, 65,50,400)
  #E2,Res2=d.get_EvRes_frozen_params(21, 65,50,350)
  p=plotResolutions(d)
  p.clear_plots()
  #p.add_single_sim(E1,Res1,1)
  #p.add_single_sim(E2,Res2,1)
  #p.savePlot(1)
  p.vary_zeniths(2,noise=350)
  p.vary_zeniths(2,noise=400)
  p.vary_zeniths(2,wobble=000, noise=350,marker='^')
  p.vary_zeniths(2,wobble=000, noise=400,marker='^')
  #plt.show()

if __name__ == '__main__':
  print 'This program is being run by itself'
  main(sys.argv[1:])
else:
  print 'I am being imported from another module'
  #Test_import()

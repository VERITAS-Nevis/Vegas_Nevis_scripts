####################
##
## Condor command file to run launch VEGAS analysis for sims file
##
####################

universe        = vanilla
Rank            = (10*Mips + 10*KFlops + 20*Memory)
Requirements  = (Memory > 2000)
should_transfer_files = YES
when_to_transfer_output = ON_EXIT
getenv          = true
Arguments       = $(Server) $(St2File) $(St4File) $(OutDir) $(LT) $(DispTable) $$(LnDir) 
executable      = /a/home/tehanu/$(User)/Analysis/scripts/goSim.sh
initialdir      = $(SimDir)
transfer_input_files = $(St2File).cvbf
#Requirements  = (Mips > 5500)

#####

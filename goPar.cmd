####################
##
## Condor command file to run launch VEGAS analysis
##
####################

universe        = vanilla
Rank            = (10*Mips + 10*KFlops + 20*Memory)
#Requirements  = (Memory > 2000)
should_transfer_files = YES
when_to_transfer_output = ON_EXIT
getenv          = true
Arguments       = $(RunNumber) $(Server) $(RawFile) $(Flasher) $(RawDir) $(OutDir) $(LT) $(LnDir) $(StCode) $(Version) $(DispTable) $(User)
executable	= /a/home/tehanu/$(User)/Analysis/scripts/goPar.sh
initialdir      = $(Datadir)
#transfer_input_files = $(RawFile).cvbf,$(Flasher).cvbf
#Requirements  = (Mips > 5500)

#####


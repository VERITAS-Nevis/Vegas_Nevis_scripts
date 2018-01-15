####################
##
## Condor command file to run launch VEGAS analysis
##
####################

universe        = vanilla
should_transfer_files = YES
when_to_transfer_output = ON_EXIT
getenv          = true
Arguments       = $(RunNumber) $(Server) $(RawFile) $(Flasher) $(RawDir) $(OutDir) $(LT) $(LnDir) $(StCode) $(Version) $(DispTable) $(User)
executable	= /a/home/tehanu/$(User)/Analysis/scripts/goPar.sh
initialdir      = $(Datadir)

#####


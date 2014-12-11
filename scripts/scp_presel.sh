# a script to retrieve plots from at3i00. run from the top dir.
# [thesis] > . scripts/scp_presel.sh

output="figures/presel"
mkdir -p ${output}

# nominal
input="atuna@at3i00.hep.upenn.edu:/web/Analysis/tuna/HiggsTauTau2012/scratch/higgs.plots.2014-12-11-09h09m25s/regions/*/*mMMC-Nb70jet30*/*"

for plot in "H-pt" "met-phi-centrality" "n-jets30" "period" "taulep-ptratio" "tau-numTrack" "tau-pt"; do
    for ext in "eps" "pdf"; do
        scp ${input}/h1-${plot}.${ext} ${output}/${plot}.${ext}
    done
done

# SetMaxDigits(3)
input="atuna@at3i00.hep.upenn.edu:/web/Analysis/tuna/HiggsTauTau2012/scratch/higgs.plots.2014-12-11-09h10m39s/regions/*/*mMMC-Nb70jet30*/*"

for plot in "mMMC" "mT-hi" "mvis" "lepmet-dphi" "taulep-dR" "taulep-deta" "taulep-dphi" "taumet-dphi" "lep-eta" "lep-pt-hi" "met-pt" "tau-eta"; do
    for ext in "eps" "pdf"; do
        scp ${input}/h1-${plot}.${ext} ${output}/${plot}.${ext}
    done
done




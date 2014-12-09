# a script to retrieve plots from at3i00. run from the top dir.
# [thesis] > . scripts/scp_LTT.sh

# vbf
input="atuna@at3i00.hep.upenn.edu:/web/Analysis/tuna/HiggsTauTau2012/scratch/higgs.plots.2014-12-09-13h07m17s/regions/VBFmvaSR/*-os*/*"
output="figures/vbf-LTT"

mkdir -p ${output}

for plot in "H-pt-hi" "lep-eta-centrality" "mMMC" "mT" "met-phi-centrality" "mvis" "n-jets30" "taulep-dR" "dijet-m-high" "jet-1-eta" "jet-1-pt" "jet-2-eta" "jet-2-pt" "jets-deta" "jets-dphi" "jets-etaprod" "system-pt" "lep-eta" "lep-pt-hi" "met-pt-hi" "BDTEve-VBF" "tau-eta" "tau-numTrack" "tau-pt"; do
    for ext in "eps" "pdf"; do
        scp ${input}/h1-${plot}.${ext} ${output}/${plot}.${ext}
    done
done




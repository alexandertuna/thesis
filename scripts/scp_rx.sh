# a script to retrieve plots from at3i00. run from the top dir.
# [thesis] > . scripts/scp_analysis.sh

# vbf
input_OS="atuna@at3i00.hep.upenn.edu:/web/Analysis/tuna/HiggsTauTau2012/scratch/higgs.plots.2014-12-15-14h40m18s/regions/VBFmvaSR/*-os*/*"
input_SS="atuna@at3i00.hep.upenn.edu:/web/Analysis/tuna/HiggsTauTau2012/scratch/higgs.plots.2014-12-15-14h40m18s/regions/VBFmvaSR/*-ss*/*"

output_OS="figures/rx/vbf-mvaSR"
output_SS="figures/rx/vbf-SSXCR"

mkdir -p ${output_OS}
mkdir -p ${output_SS}

for plot in "H-pt-hi" "lep-eta-centrality" "mMMC" "mT" "mT-hi" "met-phi-centrality" "mvis" "n-jets30" "taulep-dR" "dijet-m-veryhigh" "jet-1-eta" "jet-1-pt" "jet-2-eta" "jet-2-pt" "jets-deta" "jets-dphi" "jets-etaprod" "system-pt" "lep-eta" "lep-pt-hi" "met-pt-hi" "BDTEve-VBF" "tau-eta" "tau-numTrack" "tau-pt"; do
    for ext in "eps" "pdf"; do
        scp ${input_OS}/h1-${plot}-fraction.${ext} ${output_OS}/${plot}.${ext}
        scp ${input_SS}/h1-${plot}-fraction.${ext} ${output_SS}/${plot}.${ext}
    done
done




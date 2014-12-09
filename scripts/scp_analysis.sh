# a script to retrieve plots from at3i00. run from the top dir.
# [thesis] > . scripts/scp_analysis.sh

# vbf
input_SSXCR="atuna@at3i00.hep.upenn.edu:/web/Analysis/tuna/HiggsTauTau2012/scratch/higgs.plots.2014-12-08-08h18m34s/regions/VBFmvaSR/*-ss*/*"
input_WlvCR="atuna@at3i00.hep.upenn.edu:/web/Analysis/tuna/HiggsTauTau2012/scratch/higgs.plots.2014-12-08-08h18m34s/regions/VBFWlvCR/*/*"
input_QCDCR="atuna@at3i00.hep.upenn.edu:/web/Analysis/tuna/HiggsTauTau2012/scratch/higgs.plots.2014-12-08-08h18m34s/regions/VBFQCDCR/*/*"
input_topCR="atuna@at3i00.hep.upenn.edu:/web/Analysis/tuna/HiggsTauTau2012/scratch/higgs.plots.2014-12-08-08h18m34s/regions/VBFtopCR/*/*"
input_ZllCR="atuna@at3i00.hep.upenn.edu:/web/Analysis/tuna/HiggsTauTau2012/scratch/higgs.plots.2014-12-08-08h18m34s/regions/VBFZllCR/*/*"

output_SSXCR="figures/analysis/vbf-SSXCR"
output_WlvCR="figures/analysis/vbf-WlvCR"
output_QCDCR="figures/analysis/vbf-QCDCR"
output_topCR="figures/analysis/vbf-topCR"
output_ZllCR="figures/analysis/vbf-ZllCR"

mkdir -p ${output_SSXCR}
mkdir -p ${output_WlvCR}
mkdir -p ${output_QCDCR}
mkdir -p ${output_topCR}
mkdir -p ${output_ZllCR}

for plot in "H-pt-hi" "lep-eta-centrality" "mMMC" "mT" "mT-hi" "met-phi-centrality" "mvis" "n-jets30" "taulep-dR" "dijet-m-veryhigh" "jet-1-eta" "jet-1-pt" "jet-2-eta" "jet-2-pt" "jets-deta" "jets-dphi" "jets-etaprod" "system-pt" "lep-eta" "lep-pt-hi" "met-pt-hi" "BDTEve-VBF" "tau-eta" "tau-numTrack" "tau-pt"; do
    for ext in "eps" "pdf"; do
        scp ${input_SSXCR}/h1-${plot}.${ext} ${output_SSXCR}/${plot}.${ext}
        scp ${input_WlvCR}/h1-${plot}.${ext} ${output_WlvCR}/${plot}.${ext}
        scp ${input_QCDCR}/h1-${plot}.${ext} ${output_QCDCR}/${plot}.${ext}
        scp ${input_topCR}/h1-${plot}.${ext} ${output_topCR}/${plot}.${ext}
        scp ${input_ZllCR}/h1-${plot}.${ext} ${output_ZllCR}/${plot}.${ext}
    done
done




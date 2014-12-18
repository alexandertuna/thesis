# a script to retrieve plots from at3i00. run from the top dir.
# [thesis] > . scripts/scp_L1vars.sh

# vbf
input="atuna@at3i00.hep.upenn.edu:/web/Analysis/tuna/HiggsTauTau2012/scratch/plots.l1topo.2014-12-18-12h56m03s/nominal/*"
output="figures/l1topo"

mkdir -p ${output}

for plot in "ditau-m" "ditau-pt" "taulep-dR" "taulep-deta" "taulep-dphi" "lep-pt" "tau-pt"; do
    for ext in "eps" "pdf"; do
        scp ${input}/L1-${plot}-TH1.${ext} ${output}/${plot}.${ext}
    done
done




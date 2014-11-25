# a script to retrieve plots from at3i00. run from the top dir.
# [thesis] > . scripts/scp_mtautau.sh

input="atuna@at3i00.hep.upenn.edu:/web/Analysis/tuna/HiggsTauTau2012/scratch/mtautau-2014-11-25-14h38m54s"
output="figures/mtautau"

mkdir -p ${output}

for plot in "mtautau-ROC-vbf" "mtautau-ROC-boost"; do
    for ext in "eps" "pdf"; do
        scp ${input}/${plot}.${ext} ${output}/${plot}.${ext}
    done
done



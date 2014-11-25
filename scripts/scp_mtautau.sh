# a script to retrieve plots from at3i00. run from the top dir.
# [thesis] > . scripts/scp_mtautau.sh

input="atuna@at3i00.hep.upenn.edu:/web/Analysis/tuna/HiggsTauTau2012/scratch/mtautau-2014-11-25-04h44m49s"
output="figures/mtautau"

mkdir -p ${output}

for plot in "mtautau-roc"; do 
    for ext in "eps" "pdf"; do
        scp ${input}/${plot}.${ext} ${output}/${plot}.${ext}
    done
done



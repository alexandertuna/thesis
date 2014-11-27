if [ -z "$1" ]; then
    echo
    echo " fatal: need to pass note name (eg, ATLAS-CONF-2013-064) as argument."
    echo
    exit
fi

doc=$1
echo
echo "retrieving ${doc} (pdf and eps extensions only) and putting in ./figures/"
echo 
mkdir -p ./figures/${doc}/

for ext in pdf eps; do
    scp tuna@lxplus.cern.ch:/afs/cern.ch/atlas/www/GROUPS/PHYSICS/*/${doc}/*${ext} ./figures/${doc}/
done

clear
echo 
echo " > ls ./figures/${doc}/"
echo
ls ./figures/${doc}/
echo


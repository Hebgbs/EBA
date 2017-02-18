echo "Doing initial setup" && sh eba-sh/init.sh;
echo "Copying EBA aerials for IBA compatibiility" && sh eba-sh/cp.sh;
echo "Setting up beachball (blockfix)" && sh eba-sh/cp_ballconf_bf.sh;
echo "--> To use scalefix after, do sh eba-sh/cp_ballconf_bf.sh"

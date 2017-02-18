echo "Doing initial setup" && sh eba-sh/init.sh;
echo "Copying EBA aerials for IBA compatibiility" && sh eba-sh/cp.sh;
echo "Setting up beachball (scalefix)" && sh eba-sh/cp_ballconf_sf.sh;
echo "--> To use blockfix after, do sh eba-sh/cp_ballconf_sf.sh"

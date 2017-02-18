chmod +x fix_cases && ./fix_cases;
echo "Doing initial setup" && sh eba-sh/init.sh;
echo "Linking EBA aerials for IBA compatibiility" && sh eba-sh/ln.sh;
echo "Setting up beachball (scalefix)" && sh eba-sh/ln_ballconf_sf.sh;
echo "--> To use blockfix after, do sh eba-sh/ln_ballconf_sf.sh"

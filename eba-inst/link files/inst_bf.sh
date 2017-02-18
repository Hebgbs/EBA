chmod +x fix_cases && ./fix_cases;
echo "Doing initial setup" && sh eba-sh/init.sh;
echo "Linking EBA aerials for IBA compatibiility" && sh eba-sh/ln.sh;
echo "Setting up beachball (blockfix)" && sh eba-sh/ln_ballconf_bf.sh;
echo "--> To use scalefix after, do sh eba-sh/ln_ballconf_bf.sh"

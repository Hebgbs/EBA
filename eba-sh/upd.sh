chmod +x fix_cases && ./fix_cases
cd gfx
echo "Deleting old fxpage1.bmp if it exists..."
rm -rf oldfxpage1.bmp
echo "Saving present fxpage1.bmp (as oldfxpage1.bmp)..."
mv fxpage1.bmp oldfxpage1.bmp
echo "Making ebafxpage1.bmp usable in-game"
mv ebafxpage1.bmp fxpage1.bmp

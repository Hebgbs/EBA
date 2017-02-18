cd gfx
echo "Undoing changes to fxpage1.bmp"
mv fxpage1.bmp ebafxpage1.bmp
echo "Making stock fxpage1 usable"
rm -rf fxpage1.bmp
mv preebafxpage1.bmp fxpage1.bmp
cd ..
cd models
echo "Undoing changes to beachball.m"
rm -rf beachball.m
echo "Making stock beachball.m usable"
mv preebabeachball.m beachball.m 
cd ..
cd cars/misc
echo "Undoing changes to aerial files"
mv aerial.m ebaaerial.m
mv aerialt.m ebaaerialt.m
rm -rf aerial*
echo "Making stock aerial files usable"
mv preebaaerial.m aerial.m
mv preebaaerialt.m aerialt.m

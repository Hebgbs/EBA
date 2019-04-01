
#########  #########     ###     #########  ###     ### #########
 ##     ##  ##     #    ## ##     ##     ##  ###   ###   ##     #
 ##     ##  ##         ##   ##    ##     ##  #### ####   ##
 ########   ######    ##     ##   ##     ##  ## ### ##   ######
 ##   ##    ##        #########   ##     ##  ##     ##   ##
 ##    ##   ##     #  ##     ##   ##     ##  ##     ##   ##     #
####   ### ######### ####   #### #########  ####   #### #########
-----------------------------------------------------------------
Seriously, you should read this first before doing anything else.

So right, if you've used EBA before this is totally different, and you should either start with a fresh archive or run eba-bat/rm.bat on your Windows system before using this. Otherwise things are probably going to become messy.

If you haven't ran any of my previous scripts before, then you're in luck; I've simplified my batch instance for this content to a single file, with different routines depending on what you select. So basically this is how things work:

* Run ebba_ln_inst.bat
* Make selections for script Behaviour
* Let it rip

This script will work so long it is pointed to the correct cars directory for the installation of Re-Volt / RVGL you wish to affect. Special instances in the batch script you should be aware of:

1. %pgrm% is for 32-bit program files. If you aren't using the 32-bit version of Re-Volt 1.2 (1207 patch from ZipperRules' installer for instance), then this variable is of no use to you, and can safely be ignored when editing line 12 of the script to change which cars directory the script goes to.
2. Several files will be written inside of the directory which shouldn't be picked up by Github due to .gitignore settings. As follows:
  * .installed: Created upon first use of batch script
  * .remove: Created when choosing to uninstall; is deleted along with .installed afterward
  * .bbupd: Created when changign what beachball model is in use, deleted when finished.
3. If .installed exists, then a different menu with options for changing individual aspects of your installation will render instead of the initialization menu.

To update aerials in the future, simply run the batch script again and choose to update aerials. Nothing else really needs to be done except if you want to edit the "blockfix" beachball by specifying its use and changing the small island of colour in EBAgfx/FxPage1.bmp.

Do not submit future changes for FxPage1.bmp: They will be ignored, and probably superseded. If you want changes of FxPage1.bmp to persist, choose to copy it directly into your game's gfx directory instead and decline future changes to it; the script will ask upon updating aerials if you want to overwrite present FxPage1.bmp (of which you will lose changes because it will link the copy from the GitHub repository again).

# ElectricBee's Aerials
A set of antenna stems and tips in the same vain as Iron Bob's Aerials

###TL;DR
**If you wish to skip the content below, `./eba-docs/do it.txt` has _everything_ you need to know right away. It is very brief, but it also assumes you want this applied _now_, without needing to understand everything completely.**

###About
If you're looking to add a little extra pizzaz to your submissions, or if you think there is a little _je ne sais quoi_ missing from your vehicle, you might be interested in this set of replacement aerials (antennas) for your vehicle.

They are entirely remade, with new tip and stem models instead of the original stock tips, and come in a variety of colours, with the initial set of colours coming directly from the game, or from another set by Iron Bob, called Iron Bob's Aerials.

They are very easy to use on their own, though their use may interfere with the beachball model in future revisions. To resolve this issue, read further.

###Installation
To install, all contents must be extracted to the Re-Volt directory where either `revolt.exe` or `rvgl.exe` is (though `eba-docs` can be ignored, there may be helpful information in that directory). By default none of the contents are immediately usable; This is by design, since there are a bunch of batch and shell script files included to assist with installation in both Windows and other systems.

If your game is installed in an elevated space requiring administrator access, **you must open your command interpreter as administrator.** For Windows users, this means to run `cmd` as administrator, for all others it means running as root user with `sudo`. In most systems with a `sudoers` file you can do `sudo su` to elevate yourself without using `gksu x-terminal-emulator` to do so.

After extracting the contents and opening your commend interpreter, `cd` into where `revolt.exe` or `rvgl.exe` is and see the contents of `eba-docs/do it.txt` to quickly see the command you need to use. See the next section to understand more fully what the installation scripts should provide.

###What the scripts provided should do
After executing any of the scripts compatible for your system as instructed in the section above, the following should occur;
* All of Iron Bob's original models will be deleted, if applicable (from Iron Bob's Aerials kit)
 * More information about that is provided in the next section
* _Either_ links or copies of aerial files for compaibility with vehicles using Iron Bob's kit should be made
* _Either_ links or copies of _either_ the scalefix or blockfix beachballs should be made.
 * More information about these is provided in the next section

###_What is this other stuff you keep talking about?_
**Iron Bob's Aerials**

This is the kit that preceded ElectricBee's Aerials. This previous aerial set, which is intended to provide dfferent aerials for his vehicles were made in such a way that limited customization and presented a myraid of issues which I felt needed to be resolved. This pack intends to not just resolve these issues, but introduce new colours and improved appearances for all aerials, making them relatively easy to use and implement in other works.

**The beachballs**

Two beachball models of differeing names are included, and perform differently;
* _Scalefix_: This version of the beachball is made expressly to resolve the slightly odd appearance of the default beachball by using UV mapping that renders the sides of the beachball as completely solid colours. This is intended for users who wish to just fix its appearance and not customize it.
* _Blockfix_: This version of the beachballl is made to work with the new block of colour seen in `eba-docs/overlay.png` and `gfx/EBAFxPage1.bmp`, and can be very easily customized to change the colour of the beachball. useful for maps which have different FxPage1.bmp textures in their `custom` folder.

###For developers and makers
Please put heavy consideration toward your users when including this pack. Most of them may have no interest in this small detail, and as such, may have no interest in downloading additional content just to use your cars.

At the very least, _if you must_ include anything from the pack, have it be the following;
`cars/gfx/EBAFxPage1.bmp` (renamed to `FxPage1.bmp)
_Any of the EBA stem and tip models you are using from_ `cars/misc`
`models/sfbeachball.m` (renamed to beachball.m)
`eba-docs/overlay.png`
`eba-docs/Overlay for unmodded FxPage1.txt`
`eba-docs/Get ElectricBee's Aerials.url`
`stocks/gfx/FxPage1.bmp`
_This readme file._

If you can help it, don't include the full contents of this pack directly. There may be more significant changes in the future, and I would rather users keep up with them than to use an outdated version of my kit so everybody receives the result expected.

###For common users
**If a developer included a copy of my pack contents and the colour of the tip and stem do not match, that probably means an older model or GFX page is expected. Download and extract the contents of this pack to resolve any issues which may occur.**

If you are looking to improve the look of your vehicle library using this, there should be consideration on whether or not you'll do online races. If you intend to do online races, you _cannot_ modify the working directory of the stock cars, though you can create a new directory for yor vehicle. Using RC Bandit as an example;
`mkdir rc_eba`
`cp ./rc/parameters.txt ./rc_eba`

Then open the parameters file you ust copied, modifying it to suit (This should appear as formatted code: If it does not I will fix it later);
```
Name      	"RC Bandit (EBA)"

;====================
; Model Filenames
;====================

MODEL 	0 	"cars\rc\body.prm"
MODEL 	1 	"cars\rc\wheelfl.prm"
MODEL 	2 	"cars\rc\wheelfr.prm"
MODEL 	3 	"cars\rc\wheelbl.prm"
MODEL 	4 	"cars\rc\wheelbr.prm"
MODEL 	5 	"cars\rc\spring.prm"
MODEL 	6 	"NONE"
MODEL 	7 	"NONE"
MODEL 	8 	"NONE"
MODEL 	9 	"cars\rc\axle.prm"
MODEL 	10 	"NONE"
MODEL 	11 	"NONE"
MODEL 	12 	"NONE"
MODEL 	13 	"cars\rc\pin.prm"
MODEL 	14 	"NONE"
MODEL 	15 	"NONE"
MODEL 	16 	"NONE"
MODEL 	17 	"cars\misc\EBAs-FFFFFF.m"
MODEL 	18 	"cars\misc\EBAt-FF8000.m"
TPAGE 	"cars\rc\car.bmp"
COLL 	"cars\rc\hull.hul"
EnvRGB 	200 200 200
```

That should produce a vehicle that will be named "RC Bandit (EBA)", loading all original assets from `./cars/rc` and the new assets this mod will include, from directory `./cars/rc_eba`. It doesn't have to be that exact configuration however since Re-Volt is very flexible with filenames and such, and everything provided is _only an example_; use whatever arguments you wish within reason.

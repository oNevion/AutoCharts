# Changelog

## 3.4.0
### Current Release

*December 23, 2021*

* Features: Added FIVR fund for Strategy Shares
* Features: Added TENH fund for Strategy Shares
* Features: Added a little Holiday Cheer
* Bug Fixes: Increased server initialization time for chart builder to 8 seconds
* Bug Fixes: Increase export wait time for all fund charts to 6 seconds
* Bug Fixes: The two above bug fixes should resolve chart generation issue where data is not fully loaded

## 3.3.1

*November 02, 2021*

* Features: Now compatible with InDesign 2022 and DataLinker 2022
* Enhancements: Increased server wait time on chart creation for more reliable generation
* Enhancements: Aesthetic updates to GLDB charts
* Enhancements: Updated CFR pie chart to use "value" column in backup file
* Enhancements: Added PDF upload functions in backend

## 3.3.0

*October 08, 2021*

* Features: Removed Dropbox as database source and instead use WebDav drive connection
* Features: Updated archive function to simply create a new directory (instead of creating a .zip file)
* Features: Added additional error handling in main loop to help with future debugging
* Enhancements: AutoCharts is now a 64bit program
* Enhancements: Settings should better migrate over when user updates program
* Enhancements: Updated chart bulder dependencies to remove tar vulnerability
* Enhancements: RDM charts updated
* Bug Fix: Sometimes, previously selected funds would not clear after running through updates for a second time - Clear FundFamily Array after main program loop
* Bug Fix: GUI would "uncheck" the material type selected after pressing the "Process Updates" button - Material type checkboxes uncheck during main program loop
* Bug Fix: Program would not move completed files back into DropBox while running.
* Bug Fix: Creating an archive .zip file stopped working after recent Windows 10 update

## 3.2.1

*October 04, 2021*

* Bug Fix: Fix error when copying backup file to VBS location
* Bug Fix: Fix Expense Ratio CSV splitting to use new VBS location
* Bug Fix: Fix dropbox directory saving error

## 3.2.0

*October 04, 2021*

* Fixed VBS script call issue by moving to user's Documents folder
* Material checkboxes now work as expected

## 3.1.0

*August 17, 2021*

* Added IGO to Rational Tab
* Fixed resizing issue of GUI. User can now resize the program
* Removed DPI compatibility to try and fix GUI rendering issues
* Installation and running of the program now requires administrator rights
* Program install file moved to C:/Programs instead of the Local App Data folder

## 3.0.0

*August 04, 2021*

* New "Metro" UI Style with 4 user selectable themes
* Data sync validation added when running VBS script that splits .xlsx files to .csv
* Various updates to fund charts for Q2 2021
* GUI functions and variables now separated from main code
* Support for multiple child GUI's added for better program development
* GUI is now resizable, but very janky

## 2.4.9

*July 12, 2021*

* Added WinSCP Library for future feature releases
* Updated Include syntax by globalizing database sync variables
* AutoCharts now checks for updates on startup
* You can manually check for updates by going to HELP > Check for Updates
* Database sync now uses XCopy and only replaces files if they've been recently modified. Should perform a lot faster.
* BugFix: Database sync issue should be fixed now as a required include was accidentally deleted.

## 2.4.8

*July 12, 2021*

* Update to link to autocharts updater in script

## 2.4.7

*July 09, 2021*

* Worked on fixing database sync issue

## 2.4.6

*July 09, 2021*

* Updated include links again
* Added Database variables to main program run
* FEATURE: Program now only downloads current fund's csv data (should help with optimization/speed)
* Added message box reminding user to check that their settings converted over correctly
* Changed naming convention when creating factsheet archives
* Updated GUI for 2.4.6 release

## 2.4.5 

*July 07, 2021*

* Automatically Import DataLinker from database when user chooses to update a material
* Updated DataLinker alert boxes to only show when user specifically requests to import DataLinker database
* Settings from previous installation of AutoCharts now migrates over when updating

## 2.4.2

*July 07, 2021*

* BUG FIX: Include Files references updated and moved after global variables have been called.

## 2.4.1 

*July 06, 2021*

* BUG FIX: Fact Sheet Dates .CSV not updating correctly.

## 2.4.0 

*July 05, 2021*

* Increased amCharts Server Wait Time
* Centralized Database
* Updated Pie and Bar Chart Layouts to work with new image system
* Datalinker database updated to point to correct files
* Externalized main programming functions for future development ease
* Updated logging procedure

## 2.3.1 

*May 24, 2021*

* Removed CFH from Logic
* Added DCX to Logic

## 2.3.0 

*May 20, 2021*

* Create new menu item for Syncing with Dropbox/Database
* Create Database on Dropbox for a more centralized approach to data management
* Add Upload amCharts Scripts option
* AutoCharts now syncs amCharts scripts with database when running
* Add Upload DataLinker to Database Option
* Add Export DataLinker Option
* Add Import DataLinker Option

## 2.2.0

*May 12, 2021*

* Added Ability to Update Expense Ratios
* Removed CTV fund
* AutoCharts now automatically syncs with Dropbox before processing changes. This ensures AutoCharts is always in sync with Dropbox
* Removed unnecessary files from repository
* Added ability to archive the InDesign and Backup Files from Dropbox to user specified directory
* Added ability to clear the log file
* Replaced Quarter Select List with radio buttons. This allows AutoCharts to load the last selected quarter from the settings.ini file
* Updated/Added/Removed multiple fund charts for new fact sheet changes from Q1 of 2021

## 2.1.1

*April 30, 2021*

First release ready for multi user testing.

* Rebuilt in AutoIt and Node.js
* All Charts are generated locally vs through the catalystmf.com website
* Updated GUI with seperated funds by family
* Optimized by factor of x50
* Windows installer created
* Automated log file for debugging added
* Documentation added

## 0.2.0

* Deprecated
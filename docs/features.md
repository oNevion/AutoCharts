# Features of AutoCharts

## Sync with Dropbox

To sync AutoCharts with Dropbox, all you need to do is go to the "Pull Data from Dropbox" option under "Sync Options"

`Sync Options > Pull Data from Dropbox`


?> **Tip |** AutoCharts will also sync with Dropbox automatically when you click the "Process Updates" button.

## Archive Files

### Fact Sheets

You can easily create an archive of the InDesign and Backup Files located in Dropbox by selecting "File" in the main menu and then "Create Factsheet Archive"

`File > Create Factsheet Archive`

AutoCharts will ask you where you would like to save your archive. Once AutoCharts has finished archiving, you will find your file with the following name:

<span>*FactSheets_[Your Name]_[Current Quarter]-[Current Year].zip*</span>

## amChart Scripts
#### as of v2.3.0

Before v2.3.0, In order for the chart scripts (code that generates a fund's charts) to update, a new version of AutoCharts needed to be released.

Now, all fund chart scripts are automatically synced with a database located on Dropbox before processing any updates to a marketing piece.

!> **Notice |** Only certain users can upload/overwrite files in the database. If you feel you need this functionality, please contact me at jakob.bradshaw@catalystmf.com

To upload any chart scripts you have edited to the AutoCharts Database, just select the "Upload amChart Files" option under the "Sync Options" menu item.

`Sync Options > Upload amChart Files`


## DataLinker Options

### Export

You can easily save your local DataLinker file to any location you would like. Just select the "Export Data Sources" option under the "Sync Options" menu item and select your chosen folder.

`Sync Options > DataLinker > Export Data Sources`


### Import

Updating your DataLinker file is now as simple as clicking a button! If changes have been made to the master DataLinker.xml file in the database, all you have to do to load the new file is select the "Import Data Sources" option under the "Sync Options" menu item.

`Sync Options > DataLinker > Import Data Sources`

### Upload

!> **Notice |** Only certain users can upload/overwrite files in the database. If you feel you need this functionality, please contact me at jakob.bradshaw@catalystmf.com

To upload and overwrite the master Datalinker file in the AutoCharts database, you just need to select the "Upload Data Sources to Database" option under the "DataLinker" menu item.

`Sync Options > DataLinker > Upload Data Sources to Database`

This will copy your current DataLinker.xml file and upload it to the database, replacing everyone's file.

## Automated Logging

As you use AutoCharts to update marketing materials, the program will automatically create a log file for you to reference later.

To access this log file, select "Help" in the main menu and then "Open Log File"

`Help > Open Log File`

You may also clear the log file easily by selecting "Clear Log File" in the "Help" menu.

`Help > Clear Log File`

## Future Development

If you would like to see what upcoming features are planned, please look at the road map located on GitHub

https://github.com/oNevion/AutoCharts/projects/1?fullscreen=true
# AutoCharts

AutoCharts is a program that automatically updates the Catalyst/Rational/Strategy Shares fund fact sheets and other marketing materials every quarter when new financial data is available. This is a program designed with various technologies like AutoIt, Node.JS, and amCharts.

## Prerequisites

Please make sure you have the following installed on your system:
* Node.JS
* Dropbox
* Microsoft Excel
* Adobe InDesign
* Datalinker Plugin for Adobe InDesign
* Firefox

The Smart Sync "AutoCharts&Tables" folder in the shared Dropbox folder must be set to Local. 

[Click here for more information on Dropbox's Smart Sync](https://help.dropbox.com/installs-integrations/sync-uploads/smart-sync)

## Installation

Use the installer file here:   
[Current Release - 2.4.0](https://github.com/oNevion/AutoCharts/releases/download/v2.4.0/AutoCharts_2.4.0_Installer.exe)

## Usage

* Double check the prerequisites above!

* Before you run through an update, you need to update the settings by going to Settings > Edit

`Settings > Edit`

![alt](/img/autocharts1.gif)  

* After you have updated a backup file for a fund in Dropbox, you should sync Dropbox with AutoCharts. To do this, simply select "Pull Data from Dropbox" under the "Sync Options" menu.  

`Sync Options > Pull Data from Dropbox`

![alt](/img/autocharts2.gif)  

?> **Tip |** As of v2.2.0, you may skip the above step as AutoCharts will automatically sync with Dropbox when you press the "Process Updates" button

* Lastly, to update a fund, just select it and click "Process Updates"

![alt](/img/autocharts3.gif)  

## Requests and Future Development
AutoCharts is still in active development and more features will be coming soon. 

[View Roadmap Here](https://github.com/oNevion/AutoCharts/projects/1?fullscreen=true)

This program was built and designed for the internal use of the marketing department of Catalyst Funds. 

## License
[MIT](https://choosealicense.com/licenses/mit/)
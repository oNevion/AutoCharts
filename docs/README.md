# AutoCharts

AutoCharts is a program that automatically updates the Catalyst/Rational/Strategy Shares fund fact sheets and other marketing materials every quarter when new financial data is available. This is a program designed with various technologies like AutoIt, Node.JS, and amCharts.

## Prerequisites

Please make sure you have the following installed on your system:
* Node.JS
* RaiDrive
* Microsoft Excel
* Adobe InDesign
* Datalinker Plugin for Adobe InDesign
* Firefox

Please make sure RaiDrive is running and has been configured to connect to the AutoCharts drive. This will be setup manually with Jakob Bradshaw

![alt](/img/raidrive.jpg) 

## Installation

Use the installer file here:   
[Current Release - 3.4.1](https://github.com/oNevion/AutoCharts/releases/download/v3.4.1/AutoCharts_3.4.1_Setup.exe)

## Usage

* Double check the prerequisites above!

* Before you run through an update, you need to update the settings by going to Main Menu > Settings

* Please make sure to select the AutoCharts drive in the settings menu.

`Main Menu > Settings` or by clicking the `Settings` button in the bottom right.

![alt](/img/autocharts1.gif)  

* After you have updated a backup file for a fund in Dropbox, you should sync Dropbox with AutoCharts. To do this, simply select "Pull Data from Dropbox" under the "Sync Options" menu.  

`Main Menu > Sync Options > Pull Data from Dropbox`

![alt](/img/autocharts2.gif)  

?> **Tip |** As of v2.2.0, you may skip the above step as AutoCharts will automatically sync with Dropbox when you press the "Process Updates" button

* Lastly, to update a fund, just select the fund family and then the fund and click "Process Updates"

![alt](/img/autocharts3.gif)  

## Requests and Future Development
AutoCharts is still in active development and more features will be coming soon. 

[View Roadmap Here](https://github.com/oNevion/AutoCharts/projects/1?fullscreen=true)

This program was built and designed for the internal use of the marketing department of Catalyst Funds. 

## License
[MIT](https://choosealicense.com/licenses/mit/)
const { Builder, until } = require('selenium-webdriver');
const firefox = require('selenium-webdriver/firefox');
require('geckodriver');

module.exports = async (server) => {

    let url = 'http://localhost:3000',
        options = new firefox.Options();

    // Set some conditions for the download manager
    options.setPreference('browser.helperApps.neverAsk.saveToDisk', 'image/svg+xml,xml,text/html,application/xhtml+xml,text/xml,applicatoin/xml');
    options.setPreference('browser.download.folderList', 2);
    options.setPreference('browser.download.manager.showWhenStarting', false);
    options.setPreference('pdfjs.disabled', true);
    options.setPreference('browser.download.viewableInternally.enabledTypes', '');
    options.setPreference('browser.cache.disk.enable', false);
    options.setPreference('browser.cache.memory.enable', false);
    options.setPreference('browser.cache.offline.enable', false);
    options.setPreference('network.http.use-cache', false);

    // Set the directory to save the exported file
    options.setPreference('browser.download.dir', __dirname);

    // Open the browser headless
    //options.addArguments('-headless');

    let driver = await new Builder()
        .forBrowser('firefox')
        .setFirefoxOptions(options)
        .build();

    try {

        await driver.get(url);
        await driver.executeAsyncScript(() => {
            
            let callback = arguments[arguments.length - 1],
                exportChart = () => {

                    chart.exporting.events.on('exportfinished', () => { 
                        setTimeout(callback, 500);
                    });

                    // Start the export
                    //chart.exporting.export('svg');
                    document.getElementsByClassName('.amcharts-amexport-clickable').click();

                },
                startExportWhenReady = () => {

                    if (chart.isReady())
                        exportChart();
                    else
                        chart.events.on('ready', exportChart);
                };
            
            if (document.readyState === 'complete')
                startExportWhenReady();
            else
                document.addEventListener('DOMContentLoaded', startExportWhenReady);
        })
        .then(() => {
            driver.quit();
        });

    } finally {
        await driver.quit();
    }
};
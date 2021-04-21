let chrome = require('selenium-webdriver/chrome');
let {Builder} = require('selenium-webdriver');


(async (server) => {

    let url = ('https://catalystmf.com/autocharts/acxix-10k-chart-line/')




 let driver = new Builder()
     .forBrowser('chrome')
    .setChromeOptions(new chrome.Options()
        .headless()
        .excludeSwitches('enable-logging')
    .setUserPreferences({'download.default_directory': __dirname}))
     .build();


    try {
        await driver.get(url);
        await new Promise(r => setTimeout(r, 2000));

        await driver.executeAsyncScript(() => {

                let callback = arguments[arguments.length - 1],
                    exportChart = () => {

                        chart.exporting.events.on('exportfinished', () => {
                            setTimeout(callback, 500);
                        });

                        // Start the export
                        chart.exporting.export('svg');

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
                driver.close();
            });

    } finally {
        await driver.quit();
    }
 
})();
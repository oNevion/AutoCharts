// ################################   Creates Dynamic CSS on page for charts. ################################################


// create an element
const style = document.createElement('style');

// add CSS styles
style.innerHTML = `
@import url('https://fonts.googleapis.com/css2?family=Source+Sans+Pro:ital,wght@0,200;0,300;0,400;0,600;0,700;0,900;1,200;1,300;1,400;1,600;1,700;1,900&display=swap');

body {
  font-family: "Source Sans Pro";
}


    #chartdiv {
        width:1080px!important;
		height:500px!important;
    }

        #chartdiv2 {
        width:1330px!important;
		height:400px!important;
    }

     #chartdiv3 {
        width:790px!important;
    height:350px!important;
    }

     #chartdiv4 {
        width:840px!important;
    height:570px!important;
    }

`;

// append to DOM
document.head.appendChild(style);




// ################################   CHART 1 CWX 10k Chart (Line) ################################################


// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart1 = am4core.create("chartdiv", am4charts.XYChart);

// Set up data source
chart1.dataSource.url = "../Data/Backups/Catalyst/CWX/CWX_EXPORT_10kChart.csv";
chart1.dataSource.parser = new am4core.CSVParser();
chart1.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart1.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart1.numberFormatter.numberFormat = "'$'#,###.";




// Create axes
var dateAxis = chart1.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "20px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.minGridDistance = 30;
//dateAxis.renderer.labels.template.dx = 10;
dateAxis.renderer.minLabelPosition = -.04;
dateAxis.extraMax = 0.03; 
dateAxis.startLocation = 0.5;
dateAxis.endLocation = 0.4;
dateAxis.marginTop = 10;
dateAxis.dateFormats.setKey("month", "MM/yyyy");
dateAxis.periodChangeDateFormats.setKey("month", "MM/yyyy");
dateAxis.renderer.labels.template.rotation = -45;
dateAxis.renderer.labels.template.verticalCenter = "middle";
dateAxis.renderer.labels.template.horizontalCenter = "right";


var valueAxis = chart1.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "20px";
valueAxis.extraMin = 0.03; 

valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart1.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "Portfolio";
series1.dataFields.dateX = "Date";
series1.name = "CWXAX";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.9;
series1.stroke = am4core.color("#08da94");

var series2 = chart1.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "Index";
series2.dataFields.dateX = "Date";
series2.name = "S&P 500 TR Index";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.tensionX = 0.9;
series2.stroke = am4core.color("#2d7abf");

// Add legend
chart1.legend = new am4charts.Legend();
chart1.legend.labels.template.fontSize = "20px";
chart1.legend.labels.template.text = "{name}[/]  [bold {color}]{valueY.close}";
chart1.legend.labels.template.minWidth = 175;
chart1.legend.labels.template.truncate = false;

// Export this stuff
chart1.exporting.menu = new am4core.ExportMenu();
chart1.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart1.exporting.filePrefix = "CWX_10k";


// // ################################ CHART 2 CWX - Annual Return (Bar) ################################################

// // Themes begin
// am4core.useTheme(am4themes_amcharts);
// // Themes end

// // Create chart instance
// var chart2 = am4core.create("chartdiv2", am4charts.XYChart);

// // Add percent sign to all numbers
// chart2.numberFormatter.numberFormat = "#.#'%'";

// // Set up data source
// chart2.dataSource.url = "../Data/Backups/Catalyst/CWX/CWX_EXPORT_AnnualReturns.csv";
// chart2.dataSource.parser = new am4core.CSVParser();
// chart2.dataSource.parser.options.useColumnNames = true;

// // Create axes
// var categoryAxis = chart2.xAxes.push(new am4charts.CategoryAxis());
// categoryAxis.dataFields.category = "Year";
// categoryAxis.renderer.labels.template.fontSize = "23px";
// categoryAxis.renderer.labels.template.fontWeight = "Bold";
// categoryAxis.renderer.grid.template.disabled = false;
// categoryAxis.renderer.grid.template.location = 0;
// categoryAxis.renderer.minGridDistance = 30;
// categoryAxis.renderer.cellStartLocation = 0.1;
// categoryAxis.renderer.cellEndLocation = 0.9;
// categoryAxis.renderer.grid.template.strokeOpacity = .2;
// categoryAxis.renderer.labels.template.textAlign = "middle";

// var label = categoryAxis.renderer.labels.template;
// label.wrap = true;
// label.maxWidth = 100;

// var valueAxis = chart2.yAxes.push(new am4charts.ValueAxis());
// valueAxis.renderer.grid.template.disabled = true;
// valueAxis.renderer.labels.template.fontWeight = "Bold";
// valueAxis.renderer.labels.template.fontSize = "23px";

// // Create series
// var series = chart2.series.push(new am4charts.ColumnSeries());
// series.dataFields.valueY = "CWXAX";
// series.dataFields.categoryX = "Year";
// series.name = "CWXAX";
// series.clustered = true;
// series.fill = am4core.color("#08da94");
// series.strokeWidth = 0;
// series.columns.template.width = am4core.percent(100);




// var series2 = chart2.series.push(new am4charts.ColumnSeries());
// series2.dataFields.valueY = "S&P 500 TR";
// series2.dataFields.categoryX = "Year";
// series2.name = "S&P 500 TR";
// series2.clustered = true;
// series2.fill = am4core.color("#2d7abf");
// series2.strokeWidth = 0;
// series2.columns.template.width = am4core.percent(100);



// // Add legend
// chart2.legend = new am4charts.Legend();
// chart2.legend.labels.template.fontSize = "23px";
// chart2.legend.labels.template.truncate = false;


// // Export this stuff
// chart2.exporting.menu = new am4core.ExportMenu();
// chart2.exporting.menu.items = [{
//   "label": "...",
//   "menu": [
//           { "type": "svg", "label": "SVG" },
//   ]
// }];
// chart2.exporting.filePrefix = "CWX_AnnualReturn";

// ################################ CHART 3 CWX Institutional 10k Chart (Line) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart3 = am4core.create("chartdiv3", am4charts.XYChart);

// Set up data source
chart3.dataSource.url = "../Data/Backups/Catalyst/CWX/CWX_I_GrowthOf10k.csv";
chart3.dataSource.parser = new am4core.CSVParser();
chart3.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart3.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart3.numberFormatter.numberFormat = "'$'#,###.";




// Create axes
var dateAxis = chart3.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "16px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.labels.template.dx = -30;
dateAxis.renderer.minGridDistance = 25;
dateAxis.renderer.labels.template.location = 0;
dateAxis.renderer.labels.template.rotation = -60;
dateAxis.renderer.labels.template.verticalCenter = "middle";
dateAxis.renderer.labels.template.horizontalCenter = "left";
dateAxis.renderer.minLabelPosition = -.04;
dateAxis.extraMax = 0.02; 


var valueAxis = chart3.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "16px";
valueAxis.renderer.minGridDistance = 25;

valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart3.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "Warrington Strategic Fund, LP";
series1.dataFields.dateX = "Date";
series1.name = "Warrington Strategic Program";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.93;
series1.stroke = am4core.color("#08da94");

var series2 = chart3.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "Barclay CTA";
series2.dataFields.dateX = "Date";
series2.name = "Barclay CTA Index";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.tensionX = 0.93;
series2.stroke = am4core.color("#2d7abf");

var series3 = chart3.series.push(new am4charts.LineSeries());
series3.dataFields.valueY = "S&P 500 TR Index";
series3.dataFields.dateX = "Date";
series3.name = "S&P 500 TR Index";
series3.strokeWidth = 3;
series3.tooltipText = "{valueY}";
series3.tensionX = 0.93;
series3.stroke = am4core.color("#d97c7c");

// Add legend
chart3.legend = new am4charts.Legend();
chart3.legend.itemContainers.template.marginTop = -15;
chart3.legend.labels.template.truncate = false;
chart3.legend.labels.template.fontSize = "14px";
chart3.legend.labels.template.text = "{name}[/]  [bold {color}]{valueY.close}";


// Export this stuff
chart3.exporting.menu = new am4core.ExportMenu();
chart3.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart3.exporting.filePrefix = "CWX_I_10k";


// ################################ CHART 4 CWX Brochure 2020 Bear Market (Line) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart4 = am4core.create("chartdiv4", am4charts.XYChart);

// Set up data source
chart4.dataSource.url = "../Data/Backups/Catalyst/CWX/CWX_BRO_BearMarketGraph.csv";
chart4.dataSource.parser = new am4core.CSVParser();
chart4.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart4.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart4.numberFormatter.numberFormat = "#,###.00'%'";




// Create axes
var dateAxis = chart4.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "20px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.minGridDistance = 90;
dateAxis.renderer.labels.template.location = 0;
dateAxis.renderer.labels.template.dx = 20;
dateAxis.renderer.labels.template.dy = 10;

dateAxis.dateFormats.setKey("day", "M/d/yyyy");
dateAxis.periodChangeDateFormats.setKey("day", "M/d/yyyy");



var valueAxis = chart4.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "20px";
//valueAxis.renderer.minGridDistance = 80;

valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "#,###'%'";

// Create series
var series1 = chart4.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "CWXIX (%)";
series1.dataFields.dateX = "Date";
series1.name = "CWXIX (%)";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.95;
series1.stroke = am4core.color("#08da94");

var series2 = chart4.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "S&P 500 TR (%)";
series2.dataFields.dateX = "Date";
series2.name = "S&P 500 TR (%)";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.tensionX = 0.93;
series2.stroke = am4core.color("#2d7abf");

// Add legend
chart4.legend = new am4charts.Legend();
chart4.legend.labels.template.fontSize = "20px";

chart4.legend.itemContainers.template.marginTop = 10;
chart4.legend.labels.template.truncate = false;
chart4.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";


// Export this stuff
chart4.exporting.menu = new am4core.ExportMenu();
chart4.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart4.exporting.filePrefix = "CWX_Brochure_2020BearMarket";


// ################################   Export any charts OTHER THAN chart1 ################################################

function loadFrame() {
     chart1.exporting.export('svg');
     chart3.exporting.export('svg');
     chart4.exporting.export('svg');
};

window.onload = setTimeout(loadFrame, 1800);
                           
                        
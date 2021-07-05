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
        width:720px!important;
		height:800px!important;
    }

        #chartdiv2 {
        width:840px!important;
		height:630px!important;
    }

`;

// append to DOM
document.head.appendChild(style);




// ################################   CHART 1 TRX Institutional 10k Chart (Line) ################################################


// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart1 = am4core.create("chartdiv", am4charts.XYChart);

// Set up data source
chart1.dataSource.url = "../Data/Backups/Catalyst/TRX/TRX_I_EXPORT_Growth10k.csv";
chart1.dataSource.parser = new am4core.CSVParser();
chart1.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart1.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart1.numberFormatter.numberFormat = "'$'#,###.";




// Create axes
var dateAxis = chart1.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "23px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.labels.template.dx = -20;
dateAxis.renderer.minGridDistance = 50;
dateAxis.renderer.labels.template.location = 0;
dateAxis.extraMax = 0.02; 
dateAxis.renderer.labels.template.dy = 10;



var valueAxis = chart1.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "23px";

valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart1.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "MAP Global Balanced Composite (Net)";
series1.dataFields.dateX = "Date";
series1.name = "MAP Global Balanced Composite (Net)";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.9;
series1.stroke = am4core.color("#08da94");

var series2 = chart1.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "Benchmark";
series2.dataFields.dateX = "Date";
series2.name = "Benchmark[baseline-shift: super; font-size: 10;]1[/b] (Gross)";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.tensionX = 0.9;
series2.stroke = am4core.color("#2d7abf");




// Add legend
chart1.legend = new am4charts.Legend();
chart1.legend.labels.template.fontSize = "20px";
chart1.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";
chart1.legend.labels.template.minWidth = 150;
chart1.legend.labels.template.truncate = false;


// Export this stuff
chart1.exporting.menu = new am4core.ExportMenu();
chart1.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart1.exporting.filePrefix = "TRX_I_10k";


// ################################ CHART 2 TRX 10k Chart (Line) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart2 = am4core.create("chartdiv2", am4charts.XYChart);

// Set up data source
chart2.dataSource.url = "../Data/Backups/Catalyst/TRX/TRX_EXPORT_10kChart.csv";
chart2.dataSource.parser = new am4core.CSVParser();
chart2.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart2.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart2.numberFormatter.numberFormat = "'$'#,###.";




// Create axes
var dateAxis = chart2.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "23px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.labels.template.dx = -20;
dateAxis.renderer.minGridDistance = 50;
dateAxis.renderer.labels.template.location = 0;
dateAxis.extraMax = 0.04; 
dateAxis.renderer.minLabelPosition = -0.3;
dateAxis.renderer.labels.template.dy = 10;



var valueAxis = chart2.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "23px";

valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart2.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "TRXAX";
series1.dataFields.dateX = "Date";
series1.name = "TRXAX";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.9;
series1.stroke = am4core.color("#08da94");

var series2 = chart2.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "50% MSCI ACWI/50% ML A-AAA 1-3yr US Corp";
series2.dataFields.dateX = "Date";
series2.name = "50% MSCI ACWI/50% ML A-AAA 1-3yr US Corp";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.tensionX = 0.9;
series2.stroke = am4core.color("#2d7abf");




// Add legend
chart2.legend = new am4charts.Legend();
chart2.legend.labels.template.fontSize = "20px";
chart2.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";
chart2.legend.labels.template.minWidth = 150;
chart2.legend.labels.template.truncate = false;


// Export this stuff
chart2.exporting.menu = new am4core.ExportMenu();
chart2.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart2.exporting.filePrefix = "TRX_10k";

// ################################   Export any charts OTHER THAN chart1 ################################################

function loadFrame() {
     chart1.exporting.export('svg');
     chart2.exporting.export('svg');
};

window.onload = setTimeout(loadFrame, 1800);
                           
                        
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
        width:1330px!important;
		height:400px!important;
    }

        #chartdiv2 {
        width:1330px!important;
		height:250px!important;
    }

     #chartdiv3 {
        width:1330px!important;
		height:300px!important;
    }
`;

// append to DOM
document.head.appendChild(style);




// ################################   CHART 1  ACXIX - 10k Chart (Line) ################################################


// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart1 = am4core.create("chartdiv", am4charts.XYChart);

// Set up data source
chart1.dataSource.url = "../Data/Backups/Catalyst/ACX/ACX_EXPORT_10kChart.csv";
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
dateAxis.renderer.labels.template.dy = 10;
dateAxis.renderer.minGridDistance = 50;
dateAxis.renderer.labels.template.location = 0;
dateAxis.renderer.maxLabelPosition = 1.02;
dateAxis.renderer.labels.template.horizontalCenter = "left";
//dateAxis.extraMax = 0.03; 
dateAxis.extraMin = 0.025; 
dateAxis.startLocation = 0.49;
dateAxis.endLocation = 0.4;

var valueAxis = chart1.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "23px";

valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart1.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "ACXIX";
series1.dataFields.dateX = "Date";
series1.name = "ACXIX";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.93;
series1.stroke = am4core.color("#08da94");

var series2 = chart1.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "CSLABMF";
series2.dataFields.dateX = "Date";
series2.name = "CSLABMF";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.tensionX = 0.93;
series2.stroke = am4core.color("#2d7abf");


// Add legend
chart1.legend = new am4charts.Legend();
chart1.legend.labels.template.fontSize = "24px";
chart1.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";
chart1.legend.labels.template.minWidth = 200;
chart1.legend.labels.template.truncate = false;



// Export this stuff
chart1.exporting.menu = new am4core.ExportMenu();
chart1.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart1.exporting.filePrefix = "ACX_10k";




// ################################   CHART 2  ACX - Annual Return (Bar) ################################################




// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart2 = am4core.create("chartdiv2", am4charts.XYChart);

// Add percent sign to all numbers
chart2.numberFormatter.numberFormat = "#.#'%'";

// Set up data source
chart2.dataSource.url = "../Data/Backups/Catalyst/ACX/ACX_EXPORT_AnnualReturn.csv";
chart2.dataSource.parser = new am4core.CSVParser();
chart2.dataSource.parser.options.useColumnNames = true;

// Create axes
var categoryAxis = chart2.xAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "Date";
categoryAxis.renderer.labels.template.fontWeight = "Bold";
categoryAxis.renderer.labels.template.fontSize = "23px";
categoryAxis.renderer.grid.template.disabled = false;
categoryAxis.renderer.grid.template.disabled = false;
categoryAxis.renderer.grid.template.location = 0;
categoryAxis.renderer.minGridDistance = 30;
categoryAxis.renderer.cellStartLocation = 0.1;
categoryAxis.renderer.cellEndLocation = 0.9;
categoryAxis.renderer.grid.template.strokeOpacity = .2;
categoryAxis.renderer.labels.template.textAlign = "middle";

var label = categoryAxis.renderer.labels.template;
label.wrap = true;
label.maxWidth = 100;
var valueAxis = chart2.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.grid.template.disabled = true;
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "23px";



// Create series
var series = chart2.series.push(new am4charts.ColumnSeries());
series.dataFields.valueY = "ACXIX";
series.dataFields.categoryX = "Date";
series.name = "ACXIX";
series.clustered = true;
series.fill = am4core.color("#08da94");
series.strokeWidth = 0;
series.columns.template.width = am4core.percent(100);



var series2 = chart2.series.push(new am4charts.ColumnSeries());
series2.dataFields.valueY = "SP500TR";
series2.dataFields.categoryX = "Date";
series2.name = "S&P 500 TR Index";
series2.clustered = true;
series2.fill = am4core.color("#2d7abf");
series2.strokeWidth = 0;
series2.columns.template.width = am4core.percent(100);




// Add legend
chart2.legend = new am4charts.Legend();
chart2.legend.labels.template.fontSize = "23px";
chart2.legend.labels.template.truncate = false;


// Export this stuff
chart2.exporting.menu = new am4core.ExportMenu();
chart2.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart2.exporting.filePrefix = "ACX_AnnualReturn";


// ################################   CHART 3  ACX S&P 500 Down Months (Bar) ################################################


// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart3 = am4core.create("chartdiv3", am4charts.XYChart);

// Add percent sign to all numbers
chart3.numberFormatter.numberFormat = "#.#'%'";

// Set up data source
chart3.dataSource.url = "../Data/Backups/Catalyst/ACX/ACX_EXPORT_SPDownMonths.csv";
chart3.dataSource.parser = new am4core.CSVParser();
chart3.dataSource.parser.options.useColumnNames = true;

// Create axes
var categoryAxis = chart3.xAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "Date";
categoryAxis.renderer.labels.template.fontWeight = "Bold";
categoryAxis.renderer.labels.template.fontSize = "23px";
categoryAxis.renderer.grid.template.disabled = false;
categoryAxis.renderer.minGridDistance = 30;
categoryAxis.renderer.grid.template.location = 0;
categoryAxis.renderer.labels.template.rotation = -45;
categoryAxis.renderer.labels.template.location = 0;
categoryAxis.renderer.cellStartLocation = 0.1;
categoryAxis.renderer.cellEndLocation = 0.9;
categoryAxis.renderer.grid.template.strokeOpacity = .2;
categoryAxis.renderer.labels.template.dx = -20;


var valueAxis = chart3.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.grid.template.disabled = true;
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "23px";




// Create series
var series = chart3.series.push(new am4charts.ColumnSeries());
series.dataFields.valueY = "ACXIX";
series.dataFields.categoryX = "Date";
series.name = "ACXIX";
series.clustered = true;
series.fill = am4core.color("#08da94");
series.strokeWidth = 0;
series.columns.template.width = am4core.percent(100);



var series2 = chart3.series.push(new am4charts.ColumnSeries());
series2.dataFields.valueY = "S&P 500 TR Index";
series2.dataFields.categoryX = "Date";
series2.name = "S&P 500TR";
series2.clustered = true;
series2.fill = am4core.color("#2d7abf");
series2.strokeWidth = 0;
series2.columns.template.width = am4core.percent(100);



// Add legend
chart3.legend = new am4charts.Legend();
chart3.legend.labels.template.fontSize = "23px";
chart3.legend.labels.template.truncate = false;


// Export this stuff
chart3.exporting.menu = new am4core.ExportMenu();
chart3.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart3.exporting.filePrefix = "ACX_S&PDownMonths";

// ################################   Export any charts OTHER THAN chart1 ################################################

function loadFrame() {
     chart1.exporting.export('svg');
     chart2.exporting.export('svg');
     chart3.exporting.export('svg');
};

window.onload = setTimeout(loadFrame, 1000);
                           
                        
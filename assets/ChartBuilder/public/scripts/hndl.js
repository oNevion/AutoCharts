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
        width:1200px!important;
		height:800px!important;
    }

        #chartdiv2 {
        width:1500px!important;
		height:320px!important;
    }

     #chartdiv3 {
        width:900px!important;
    height:900px!important;
    }

     #chartdiv4 {
        width:1200px!important;
    height:800px!important;
    }

     #chartdiv5 {
        width:1500px!important;
    height:320px!important;
    } 

    #chartdiv6 {
        width:1500px!important;
    height:320px!important;
    }

`;

// append to DOM
document.head.appendChild(style);




// ################################   CHART 1 HNDL - Growth of 10k (Line) ################################################


// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart1 = am4core.create("chartdiv", am4charts.XYChart);

// Set up data source
chart1.dataSource.url = "../Data/Backups/StrategyShares/HNDL/HNDL_EXPORT_10k.csv";
chart1.dataSource.parser = new am4core.CSVParser();
chart1.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart1.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart1.numberFormatter.numberFormat = "'$'#,###.";

// Create axes
var dateAxis = chart1.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "22px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.minGridDistance = 60;
dateAxis.renderer.labels.template.location = 0;
dateAxis.renderer.labels.template.rotation = -45;
dateAxis.renderer.labels.template.verticalCenter = "middle";
dateAxis.renderer.labels.template.horizontalCenter = "middle";
dateAxis.dateFormats.setKey("month", "MM/yyyy");
dateAxis.periodChangeDateFormats.setKey("month", "MM/yyyy"); 
dateAxis.startLocation = 0.49;
dateAxis.endLocation = 0.4;
dateAxis.renderer.labels.template.dy = 20;
dateAxis.renderer.minLabelPosition = -0.5;
dateAxis.extraMax = 0.05; 

var valueAxis = chart1.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "22px";
valueAxis.renderer.minGridDistance = 60;
valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart1.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "HANDL: NAV";
series1.dataFields.dateX = "Date";
series1.name = "HANDL: NAV";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
//series1.tensionX = 0.99;
series1.stroke = am4core.color("#08da94");

var series2 = chart1.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "HANDL: Market";
series2.dataFields.dateX = "Date";
series2.name = "HANDL: Market";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
//series2.tensionX = 0.99;
series2.stroke = am4core.color("#025268");

var series3 = chart1.series.push(new am4charts.LineSeries());
series3.dataFields.valueY = "Bloomberg Barclay U.S. Agg. Index";
series3.dataFields.dateX = "Date";
series3.name = "Bloomberg Barclays U.S. Agg. Index";
series3.strokeWidth = 3;
series3.tooltipText = "{valueY}";
//series2.tensionX = 0.99;
series3.stroke = am4core.color("#b7b7bd");

// Add legend
chart1.legend = new am4charts.Legend();
chart1.legend.labels.template.fontSize = "22px";
chart1.legend.labels.template.truncate = false;
chart1.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";
chart1.legend.itemContainers.template.marginTop = 10;

// Export this stuff
chart1.exporting.menu = new am4core.ExportMenu();
chart1.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart1.exporting.filePrefix = "HNDL_10k";


// ################################ CHART 2 HNDL - Performance Table (Bar) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart2 = am4core.create("chartdiv2", am4charts.XYChart);

// Add percent sign to all numbers
chart2.numberFormatter.numberFormat = "#.#'%'";

// Set up data source
chart2.dataSource.url = "../Data/Backups/StrategyShares/HNDL/HNDL_EXPORT_PerformanceBar.csv";
chart2.dataSource.parser = new am4core.CSVParser();
chart2.dataSource.parser.options.useColumnNames = true;

// Create axes
var categoryAxis = chart2.xAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "Category";
categoryAxis.renderer.labels.template.fontWeight = "Bold";
categoryAxis.renderer.grid.template.disabled = false;
categoryAxis.renderer.grid.template.location = 0;
categoryAxis.renderer.minGridDistance = 30;
categoryAxis.renderer.labels.template.fontSize = "25px";
categoryAxis.renderer.cellStartLocation = 0.1;
categoryAxis.renderer.cellEndLocation = 0.9;
categoryAxis.renderer.grid.template.strokeOpacity = .2;



var valueAxis = chart2.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.grid.template.disabled = true;
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "32px";




// Create series
var series = chart2.series.push(new am4charts.ColumnSeries());
series.dataFields.valueY = "HANDL: NAV";
series.dataFields.categoryX = "Category";
series.name = "HANDL: NAV";
series.clustered = true;
series.fill = am4core.color("#08da94");
series.strokeWidth = 0;
series.columns.template.width = am4core.percent(100);




var series2 = chart2.series.push(new am4charts.ColumnSeries());
series2.dataFields.valueY = "HANDL: Market";
series2.dataFields.categoryX = "Category";
series2.name = "HANDL: Market";
series2.clustered = true;
series2.fill = am4core.color("#2d7abf");
series2.strokeWidth = 0;
series2.columns.template.width = am4core.percent(100);


var series3 = chart2.series.push(new am4charts.ColumnSeries());
series3.dataFields.valueY = "Bloomberg Barclay U.S. Agg. Index";
series3.dataFields.categoryX = "Category";
series3.name = "Bloomberg Barclays U.S. Agg. Index";
series3.clustered = true;
series3.fill = am4core.color("#444444");
series3.strokeWidth = 0;
series3.columns.template.width = am4core.percent(100);


// Export this stuff
chart2.exporting.menu = new am4core.ExportMenu();
chart2.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart2.exporting.filePrefix = "HNDL_PerformanceBar";


// ################################ CHART 3 HNDL Sector Allocation (Pie) ################################################

// Create chart instance
var chart3 = am4core.create("chartdiv3", am4charts.PieChart);
chart3.innerRadius = am4core.percent(40);
am4core.options.autoSetClassName = true;

// Set up data source
chart3.dataSource.url = "../Data/Backups/StrategyShares/HNDL/HNDL_EXPORT_SectorPie.csv";
chart3.dataSource.parser = new am4core.CSVParser();
chart3.dataSource.parser.options.useColumnNames = true;

// Add series
var series2 = chart3.series.push(new am4charts.PieSeries());
series2.dataFields.value = "Category Sums";
series2.dataFields.category = "Category Label";
series2.slices.template.stroke = am4core.color("#ffffff");
series2.slices.template.strokeWidth = 2;
series2.slices.template.strokeOpacity = 1;
series2.labels.template.disabled = true;
series2.ticks.template.disabled = true;
series2.slices.template.tooltipText = "";
series2.colors.list = [
    am4core.color("#0d345e"),
    am4core.color("#c02026"),
    am4core.color("#091829"),
    am4core.color("#08DA94")

];

// Add series
var series = chart3.series.push(new am4charts.PieSeries());
series.dataFields.value = "Outer Value";
series.dataFields.category = "Outer Label";
series.slices.template.stroke = am4core.color("#ffffff");
series.slices.template.strokeWidth = 2;
series.slices.template.strokeOpacity = 1;
series.labels.template.disabled = true;
series.ticks.template.disabled = true;
series.slices.template.tooltipText = "";
series.colors.list = [
    am4core.color("#0D345E"),
    am4core.color("#274E78"),
    am4core.color("#406791"),
    am4core.color("#5A81AB"),
    am4core.color("#739AC4"),
    am4core.color("#8CB3DD"),
    am4core.color("#A6CDF7"),
    am4core.color("#c02026"),
    am4core.color("#C02026"),
    am4core.color("#A7070D"),
    am4core.color("#8D0000"),
    am4core.color("#091829"),
    am4core.color("#0d2139"),
    am4core.color("#08DA94"),

];


// Add legend
//chart3.legend = new am4charts.Legend();
//chart3.legend.position = "bottom";
//chart3.legend.maxWidth = undefined;
//chart3.legend.maxheight = 400;
//chart3.legend.valueLabels.template.align = "right";
//chart3.legend.valueLabels.template.textAlign = "end";
//chart3.legend.labels.template.minWidth = 300;
//chart3.legend.valueLabels.template.text = "{value.value.formatNumber('#.0')}%";
//chart3.legend.labels.template.truncate = false;


// Export this stuff
chart3.exporting.menu = new am4core.ExportMenu();
chart3.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart3.exporting.filePrefix = "HNDL_SectorAllocation";


// ################################ CHART 4 HNDL - Institutional Growth of 10k (Line) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart4 = am4core.create("chartdiv4", am4charts.XYChart);

// Set up data source
chart4.dataSource.url = "../Data/Backups/StrategyShares/HNDL/HNDL_I_EXPORT_10k.csv";
chart4.dataSource.parser = new am4core.CSVParser();
chart4.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart4.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart4.numberFormatter.numberFormat = "'$'#,###.";

// Create axes
var dateAxis = chart4.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "22px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.minGridDistance = 60;
dateAxis.renderer.labels.template.location = 0;
dateAxis.renderer.labels.template.rotation = -45;
dateAxis.renderer.labels.template.verticalCenter = "middle";
dateAxis.renderer.labels.template.horizontalCenter = "middle";
dateAxis.dateFormats.setKey("month", "MM/yyyy");
dateAxis.periodChangeDateFormats.setKey("month", "MM/yyyy"); 
dateAxis.startLocation = 0.49;
dateAxis.endLocation = 0.4;
dateAxis.renderer.labels.template.dy = 20;
dateAxis.renderer.minLabelPosition = -0.5;
dateAxis.extraMax = 0.06; 
dateAxis.groupData = true;
dateAxis.groupCount = 2000;

var valueAxis = chart4.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "22px";
valueAxis.renderer.minGridDistance = 60;
valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart4.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "Nasdaq 7HANDL Index";
series1.dataFields.dateX = "Date";
series1.name = "Nasdaq 7HANDL Index";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
//series1.tensionX = 0.99;
series1.stroke = am4core.color("#08da94");

var series2 = chart4.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "Bloomberg Barclay U.S. Agg. Index";
series2.dataFields.dateX = "Date";
series2.name = "Bloomberg Barclays U.S. Agg. Index";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
//series2.tensionX = 0.99;
series2.stroke = am4core.color("#025268");

// Add legend
chart4.legend = new am4charts.Legend();
chart4.legend.labels.template.fontSize = "22px";
chart4.legend.labels.template.truncate = false;
chart4.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";
chart4.legend.itemContainers.template.marginTop = 10;

// Export this stuff
chart4.exporting.menu = new am4core.ExportMenu();
chart4.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart4.exporting.filePrefix = "HNDL_I_10k";


// ################################ CHART 5 HNDL -  Institutional Performance Table (Bar) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart5 = am4core.create("chartdiv5", am4charts.XYChart);

// Add percent sign to all numbers
chart5.numberFormatter.numberFormat = "#.#'%'";

// Set up data source
chart5.dataSource.url = "../Data/Backups/StrategyShares/HNDL/HNDL_I_EXPORT_PerformanceBar.csv";
chart5.dataSource.parser = new am4core.CSVParser();
chart5.dataSource.parser.options.useColumnNames = true;

// Create axes
var categoryAxis = chart5.xAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "Label";
categoryAxis.renderer.labels.template.fontWeight = "Bold";
categoryAxis.renderer.grid.template.disabled = false;
categoryAxis.renderer.grid.template.location = 0;
categoryAxis.renderer.minGridDistance = 30;
categoryAxis.renderer.labels.template.fontSize = "25px";
categoryAxis.renderer.cellStartLocation = 0.1;
categoryAxis.renderer.cellEndLocation = 0.9;
categoryAxis.renderer.grid.template.strokeOpacity = .2;



var valueAxis = chart5.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.grid.template.disabled = true;
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "32px";




// Create series
var series = chart5.series.push(new am4charts.ColumnSeries());
series.dataFields.valueY = "HNDL";
series.dataFields.categoryX = "Label";
series.name = "Nasdaq 7HANDL Index";
series.clustered = true;
series.fill = am4core.color("#08da94");
series.strokeWidth = 0;
series.columns.template.width = am4core.percent(100);

var series2 = chart5.series.push(new am4charts.ColumnSeries());
series2.dataFields.valueY = "Barclay";
series2.dataFields.categoryX = "Label";
series2.name = "Bloomberg Barclays Agg";
series2.clustered = true;
series2.fill = am4core.color("#2d7abf");
series2.strokeWidth = 0;
series2.columns.template.width = am4core.percent(100);

// Export this stuff
chart5.exporting.menu = new am4core.ExportMenu();
chart5.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart5.exporting.filePrefix = "HNDL_I_PerformanceBar";

// ################################ CHART 6 HNDL -  Institutional Annual Returns ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart6 = am4core.create("chartdiv6", am4charts.XYChart);

// Add percent sign to all numbers
chart6.numberFormatter.numberFormat = "#.#'%'";

// Set up data source
chart6.dataSource.url = "../Data/Backups/StrategyShares/HNDL/HNDL_I_EXPORT_AnnualReturns.csv";
chart6.dataSource.parser = new am4core.CSVParser();
chart6.dataSource.parser.options.useColumnNames = true;

// Create axes
var categoryAxis = chart6.xAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "Year";
categoryAxis.renderer.labels.template.fontWeight = "Bold";
categoryAxis.renderer.grid.template.disabled = false;
categoryAxis.renderer.grid.template.location = 0;
categoryAxis.renderer.minGridDistance = 30;
categoryAxis.renderer.labels.template.fontSize = "25px";
categoryAxis.renderer.cellStartLocation = 0.1;
categoryAxis.renderer.cellEndLocation = 0.9;
categoryAxis.renderer.grid.template.strokeOpacity = .2;



var valueAxis = chart6.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.grid.template.disabled = true;
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "32px";




// Create series
var series = chart6.series.push(new am4charts.ColumnSeries());
series.dataFields.valueY = "HNDL";
series.dataFields.categoryX = "Year";
series.name = "Nasdaq 7HANDL Index";
series.clustered = true;
series.fill = am4core.color("#08da94");
series.strokeWidth = 0;
series.columns.template.width = am4core.percent(100);

var series2 = chart6.series.push(new am4charts.ColumnSeries());
series2.dataFields.valueY = "Barclay";
series2.dataFields.categoryX = "Year";
series2.name = "Bloomberg Barclays Agg";
series2.clustered = true;
series2.fill = am4core.color("#2d7abf");
series2.strokeWidth = 0;
series2.columns.template.width = am4core.percent(100);

// Export this stuff
chart6.exporting.menu = new am4core.ExportMenu();
chart6.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart6.exporting.filePrefix = "HNDL_I_AnnualReturns";

// ################################   Export any charts OTHER THAN chart1 ################################################

function loadFrame() {
     chart1.exporting.export('svg');
     chart2.exporting.export('svg');
     chart3.exporting.export('svg');
     chart4.exporting.export('svg');
     chart5.exporting.export('svg');
     chart6.exporting.export('svg');
};

window.onload = setTimeout(loadFrame, 6000);
                           
                        
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
		height:500px!important;
    }

        #chartdiv2 {
        width:1200px!important;
		height:450px!important;
    }

     #chartdiv3 {
        width:900px!important;
    height:300px!important;
    }

     #chartdiv4 {
        width:690px!important;
    height:591px!important;
    }

     #chartdiv5 {
        width:1000px!important;
    height:800px!important;
    } 

    #chartdiv6 {
        width:1500px!important;
    height:320px!important;
    }

    #chartdiv7 {
        width:1500px!important;
    height:340px!important;
    }

    #chartdiv8 {
        width:690px!important;
    height:391px!important;
    }

`;

// append to DOM
document.head.appendChild(style);

// ################################   CHART 1 GLDB - Gold Vs US Dollar (Line) ################################################


// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart1 = am4core.create("chartdiv", am4charts.XYChart);

// Set up data source
chart1.dataSource.url = "../Data/Backups/StrategyShares/GLDB/GLDB_EXPORT_GoldVsUSDollarChart.csv";
chart1.dataSource.parser = new am4core.CSVParser();
chart1.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart1.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart1.numberFormatter.numberFormat = "#,###.00";

// Create axes
var dateAxis = chart1.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "22px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.minGridDistance = 60;
dateAxis.renderer.labels.template.verticalCenter = "middle";
dateAxis.renderer.labels.template.horizontalCenter = "middle";
dateAxis.dateFormats.setKey("month", "MM/yyyy");
dateAxis.periodChangeDateFormats.setKey("month", "MM/yyyy"); 
dateAxis.startLocation = 0.49;
dateAxis.endLocation = 0.4;
dateAxis.renderer.labels.template.dy = 20;

var valueAxis = chart1.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "22px";
valueAxis.renderer.minGridDistance = 60;
valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "#,###";

// Create series
var series1 = chart1.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "Inflation-Adjusted Value of USD";
series1.dataFields.dateX = "Date";
series1.name = "Inflation-Adjusted Value of USD";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
//series1.tensionX = 0.99;
series1.stroke = am4core.color("#025268");

var series2 = chart1.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "Inflation-Adjusted Value of Gold";
series2.dataFields.dateX = "Date";
series2.name = "Inflation-Adjusted Value of Gold";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
//series2.tensionX = 0.99;
series2.stroke = am4core.color("#08da94");

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
chart1.exporting.filePrefix = "GLDB_GoldVsUSDollar";


// ################################ CHART 2 GLDB - Gold Vs Fed Reserve (Line) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart2 = am4core.create("chartdiv2", am4charts.XYChart);

// Set up data source
chart2.dataSource.url = "../Data/Backups/StrategyShares/GLDB/GLDB_EXPORT_GoldVsFedReserve.csv";
chart2.dataSource.parser = new am4core.CSVParser();
chart2.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart2.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart2.numberFormatter.numberFormat = "#,###.'%'";

// Create axes
var dateAxis = chart2.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "22px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.minGridDistance = 60;
dateAxis.renderer.labels.template.verticalCenter = "middle";
dateAxis.renderer.labels.template.horizontalCenter = "middle";
dateAxis.dateFormats.setKey("month", "MM/yyyy");
dateAxis.periodChangeDateFormats.setKey("month", "MM/yyyy"); 
dateAxis.startLocation = 0.49;
dateAxis.endLocation = 0.4;
dateAxis.renderer.labels.template.dy = 20;

var valueAxis = chart2.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "22px";
valueAxis.renderer.minGridDistance = 60;
valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "#,###'%'";

var series2 = chart2.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "% Increase in Price of Gold";
series2.dataFields.dateX = "Date";
series2.name = "% Increase in Price of Gold";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.stroke = am4core.color("#08da94");
series2.fillOpacity = .5;

// Create series
var series1 = chart2.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "Growth of US M1 Money Supply";
series1.dataFields.dateX = "Date";
series1.name = "Growth of US M1 Money Supply";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.stroke = am4core.color("#025268");



let fillModifier = new am4core.LinearGradientModifier();
fillModifier.opacities = [1, .2];
fillModifier.offsets = [.2, 1];
fillModifier.gradient.rotation = 90;
series2.segments.template.fillModifier = fillModifier;

// Add legend
chart2.legend = new am4charts.Legend();
chart2.legend.labels.template.fontSize = "22px";
chart2.legend.labels.template.truncate = false;
chart2.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";
chart2.legend.itemContainers.template.marginTop = 10;

// Export this stuff
chart2.exporting.menu = new am4core.ExportMenu();
chart2.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart2.exporting.filePrefix = "GLDB_GoldVsFedReserve";


// ################################ CHART 3 GLDB - Gold/Bond Exposure (Bar) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart3 = am4core.create("chartdiv3", am4charts.XYChart);

// Add percent sign to all numbers
chart3.numberFormatter.numberFormat = "#.#'%'";

// Set up data source
chart3.dataSource.url = "../Data/Backups/StrategyShares/GLDB/GLDB_EXPORT_ExposureBarChart.csv";
chart3.dataSource.parser = new am4core.CSVParser();
chart3.dataSource.parser.options.useColumnNames = true;

// Create axes
var categoryAxis = chart3.yAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "Label";
categoryAxis.renderer.labels.template.fontWeight = "Bold";
categoryAxis.renderer.labels.template.fontSize = "20px";
categoryAxis.renderer.grid.template.disabled = false;
categoryAxis.renderer.grid.template.location = 0;
categoryAxis.renderer.cellStartLocation = 0.1;
categoryAxis.renderer.cellEndLocation = 0.9;
categoryAxis.renderer.grid.template.strokeOpacity = .2;
categoryAxis.renderer.labels.template.disabled = true



var valueAxis = chart3.xAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.grid.template.disabled = true;
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "20px";
valueAxis.renderer.grid.template.location = 0;
valueAxis.renderer.labels.template.dx = -20;
valueAxis.min = 70;
valueAxis.renderer.labels.template.horizontalCenter = "left";
valueAxis.renderer.labels.template.verticalCenter = "middle";
valueAxis.renderer.maxLabelPosition = 0.99;
valueAxis.renderer.minGridDistance = 50;

var series2 = chart3.series.push(new am4charts.ColumnSeries());
series2.dataFields.valueX = "Bonds";
series2.dataFields.categoryY = "Label";
series2.name = "Bonds";
//series2.clustered = true;
series2.fill = am4core.color("#025268");
series2.strokeWidth = 0;
//series2.columns.template.width = am4core.percent(100);

// Create series
var series = chart3.series.push(new am4charts.ColumnSeries());
series.dataFields.valueX = "Gold";
series.dataFields.categoryY = "Label";
series.name = "Gold";
//series.clustered = true;
series.fill = am4core.color("#08da94");
series.strokeWidth = 0;
//series.columns.template.width = am4core.percent(100);

// Add legend
chart3.legend = new am4charts.Legend();
chart3.legend.labels.template.fontSize = "20px";
chart3.legend.labels.template.truncate = false;
chart3.legend.labels.template.text = "{name}[/] [bold {color}]{valueX.close}";

// Export this stuff
chart3.exporting.menu = new am4core.ExportMenu();
chart3.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart3.exporting.filePrefix = "GLDB_GoldBondExposureBar";


// ################################ CHART 5 GLDB - Institutional Growth of 10k (Line) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart5 = am4core.create("chartdiv5", am4charts.XYChart);

// Set up data source
chart5.dataSource.url = "../Data/Backups/StrategyShares/GLDB/GLDB_I_EXPORT_10kChart.csv";
chart5.dataSource.parser = new am4core.CSVParser();
chart5.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart5.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart5.numberFormatter.numberFormat = "'$'#,###.";

// Create axes
var dateAxis = chart5.xAxes.push(new am4charts.DateAxis());
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

var valueAxis = chart5.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "22px";
valueAxis.renderer.minGridDistance = 60;
valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart5.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "Solactive Gold-Backed Bond Index";
series1.dataFields.dateX = "Date";
series1.name = "Solactive Gold-Backed Bond Index";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
//series1.tensionX = 0.99;
series1.stroke = am4core.color("#08da94");

var series2 = chart5.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "Bloomberg Barclays US Corporate TR";
series2.dataFields.dateX = "Date";
series2.name = "Bloomberg Barclays U.S. Corporate TR";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
//series2.tensionX = 0.99;
series2.stroke = am4core.color("#025268");

// Add legend
chart5.legend = new am4charts.Legend();
chart5.legend.labels.template.fontSize = "22px";
chart5.legend.labels.template.truncate = false;
chart5.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";
chart5.legend.itemContainers.template.marginTop = 10;

// Export this stuff
chart5.exporting.menu = new am4core.ExportMenu();
chart5.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart5.exporting.filePrefix = "GLDB_I_10k";


// ################################ CHART 6 GLDB -  Institutional Performance Table (Bar) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart6 = am4core.create("chartdiv6", am4charts.XYChart);

// Add percent sign to all numbers
chart6.numberFormatter.numberFormat = "#.#'%'";

// Set up data source
chart6.dataSource.url = "../Data/Backups/StrategyShares/GLDB/GLDB_I_EXPORT_PerformanceChart.csv";
chart6.dataSource.parser = new am4core.CSVParser();
chart6.dataSource.parser.options.useColumnNames = true;

// Create axes
var categoryAxis = chart6.xAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "Label";
categoryAxis.renderer.labels.template.fontWeight = "Bold";
categoryAxis.renderer.grid.template.disabled = false;
categoryAxis.renderer.grid.template.location = 0;
categoryAxis.renderer.minGridDistance = 30;
categoryAxis.renderer.labels.template.fontSize = "25px";
categoryAxis.renderer.cellStartLocation = 0.1;
categoryAxis.renderer.cellEndLocation = 0.9;
categoryAxis.renderer.grid.template.strokeOpacity = .2;
categoryAxis.renderer.labels.template.disabled = true;



var valueAxis = chart6.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.grid.template.disabled = true;
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "32px";




// Create series
var series = chart6.series.push(new am4charts.ColumnSeries());
series.dataFields.valueY = "Solactive Gold-Backed Bond Index";
series.dataFields.categoryX = "Label";
series.name = "Solactive Gold-Backed Bond Index";
series.clustered = true;
series.fill = am4core.color("#08da94");
series.strokeWidth = 0;
series.columns.template.width = am4core.percent(100);

var series2 = chart6.series.push(new am4charts.ColumnSeries());
series2.dataFields.valueY = "Bloomberg Barclays US Corporate TR";
series2.dataFields.categoryX = "Label";
series2.name = "Bloomberg Barclays US Corporate TR";
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
chart6.exporting.filePrefix = "GLDB_I_PerformanceBar";


// ################################ CHART 7 GLDB -  Institutional Annual Returns ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart7 = am4core.create("chartdiv7", am4charts.XYChart);

// Add percent sign to all numbers
chart7.numberFormatter.numberFormat = "#.#'%'";

// Set up data source
chart7.dataSource.url = "../Data/Backups/StrategyShares/GLDB/GLDB_I_AnnualReturnsTable.csv";
chart7.dataSource.parser = new am4core.CSVParser();
chart7.dataSource.parser.options.useColumnNames = true;

// Create axes
var categoryAxis = chart7.xAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "Year";
categoryAxis.renderer.labels.template.fontWeight = "Bold";
categoryAxis.renderer.grid.template.disabled = false;
categoryAxis.renderer.grid.template.location = 0;
categoryAxis.renderer.minGridDistance = 30;
categoryAxis.renderer.labels.template.fontSize = "25px";
categoryAxis.renderer.cellStartLocation = 0.1;
categoryAxis.renderer.cellEndLocation = 0.9;
categoryAxis.renderer.grid.template.strokeOpacity = .2;



var valueAxis = chart7.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.grid.template.disabled = true;
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "32px";




// Create series
var series = chart7.series.push(new am4charts.ColumnSeries());
series.dataFields.valueY = "Solactive Gold-Backed Bond Index";
series.dataFields.categoryX = "Year";
series.name = "Solactive Gold-Backed Bond Index";
series.clustered = true;
series.fill = am4core.color("#08da94");
series.strokeWidth = 0;
series.columns.template.width = am4core.percent(100);

var series2 = chart7.series.push(new am4charts.ColumnSeries());
series2.dataFields.valueY = "Bloomberg Barclays US Corporate TR";
series2.dataFields.categoryX = "Year";
series2.name = "Bloomberg Barclays US Corporate TR";
series2.clustered = true;
series2.fill = am4core.color("#2d7abf");
series2.strokeWidth = 0;
series2.columns.template.width = am4core.percent(100);

// Export this stuff
chart7.exporting.menu = new am4core.ExportMenu();
chart7.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart7.exporting.filePrefix = "GLDB_I_AnnualReturns";


// ################################ CHART 8 GLDB Sector Allocation (Pie) ################################################

// Create chart instance
var chart8 = am4core.create("chartdiv8", am4charts.PieChart);
chart8.innerRadius = am4core.percent(40);

// Set up data source
chart8.dataSource.url = "../Data/Backups/StrategyShares/GLDB/GLDB_EXPORT_SectorAllocationPie.csv";
chart8.dataSource.parser = new am4core.CSVParser();
chart8.dataSource.parser.options.useColumnNames = true;



// Make the chart fade-in on init
chart8.hiddenState.properties.opacity = 0;

// Add series
var series = chart8.series.push(new am4charts.PieSeries());
series.dataFields.value = "Value";
series.dataFields.category = "Label";
series.slices.template.stroke = am4core.color("#ffffff");
series.slices.template.strokeWidth = 2;
series.slices.template.strokeOpacity = 1;
series.labels.template.disabled = true;
series.ticks.template.disabled = true;
series.slices.template.tooltipText = "";
series.colors.list = [
  am4core.color("#0d345e"),
  am4core.color("#0c4664"),
  am4core.color("#0c5769"),
  am4core.color("#0b696f"),
  am4core.color("#0b7b75"),
  am4core.color("#0a8d7b"),
  am4core.color("#0aa081"),
  am4core.color("#09b387"),
  am4core.color("#09c68e"),
  am4core.color("#08da94"),

];


// Create initial animation
series.hiddenState.properties.opacity = 1;
series.hiddenState.properties.endAngle = -90;
series.hiddenState.properties.startAngle = -90;


// Add legend
chart8.legend = new am4charts.Legend();
chart8.legend.position = "right";
chart8.legend.maxWidth = undefined;
//chart8.legend.maxheight = 400;
chart8.legend.valueLabels.template.align = "right";
chart8.legend.valueLabels.template.textAlign = "end";  
chart8.legend.labels.template.minWidth = 220;
chart8.legend.labels.template.truncate = false;
chart8.legend.valign = "bottom";




// Export this stuff
chart8.exporting.menu = new am4core.ExportMenu();
chart8.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart8.exporting.filePrefix = "GLDB_SectorWeights";

// ################################   Export any charts OTHER THAN chart1 ################################################

function loadFrame() {
     chart1.exporting.export('svg');
     chart2.exporting.export('svg');
     chart3.exporting.export('svg');
     chart5.exporting.export('svg');
     chart6.exporting.export('svg');
     chart7.exporting.export('svg');
     chart8.exporting.export('svg');
};

window.onload = setTimeout(loadFrame, 1800);
                           
                        
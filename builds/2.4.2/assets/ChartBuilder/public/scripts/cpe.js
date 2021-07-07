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
        width:900px!important;
		height:500px!important;
    }

        #chartdiv2 {
        width:720px!important;
		height:550px!important;
    }

     #chartdiv3 {
        width:1330px!important;
    height:320px!important;
    }

     #chartdiv4 {
        width:720px!important;
    height:800px!important;
    }

     #chartdiv5 {
        width:1330px!important;
    height:575px!important;
    } 

`;

// append to DOM
document.head.appendChild(style);




// ################################   CHART 1 CPE Portfolio Sector (Pie) ################################################


// Create chart instance
var chart1 = am4core.create("chartdiv", am4charts.PieChart);
chart1.marginTop = "";
chart1.width = "100%";
chart1.height = "440";
chart1.verticalCenter = "top";
chart1.layout = "vertical";
chart1.radius = "80%";
chart1.innerRadius = "50%";

// Set up data source
chart1.dataSource.url = "../Data/Backups/Catalyst/CPE/CPE_EXPORT_PortfolioSector.csv";
chart1.dataSource.parser = new am4core.CSVParser();
chart1.dataSource.parser.options.useColumnNames = true;



// Make the chart fade-in on init
chart1.hiddenState.properties.opacity = 0;

// Add series
var series = chart1.series.push(new am4charts.PieSeries());
series.dataFields.value = "Portfolio";
series.dataFields.value2 = "S&P 500";
series.dataFields.category = "Label";
series.slices.template.stroke = am4core.color("#ffffff");
series.slices.template.strokeWidth = 2;
series.slices.template.strokeOpacity = 1;
series.labels.template.disabled = true;
series.ticks.template.disabled = true;
series.slices.template.tooltipText = "";
series.colors.list = [
  am4core.color("#3c1e57"),
  am4core.color("#253b7d"),
  am4core.color("#00589e"),
  am4core.color("#0074b4"),
  am4core.color("#0090bd"),
  am4core.color("#00aab9"),
  am4core.color("#00c3aa"),
  am4core.color("#08da94"),
  am4core.color("#00b59c"),
  am4core.color("#008f96"),
  am4core.color("#006981"),
  am4core.color("#004560")
];


// Create initial animation
series.hiddenState.properties.opacity = 1;
series.hiddenState.properties.endAngle = -90;
series.hiddenState.properties.startAngle = -90;


// Add legend
chart1.legend = new am4charts.Legend();
chart1.legend.position = "right";
chart1.legend.maxWidth = undefined;
chart1.legend.maxheight = 700;
chart1.legend.valueLabels.template.align = "right";
chart1.legend.valueLabels.template.textAlign = "end";  
chart1.legend.labels.template.minWidth = 225;
chart1.legend.labels.template.truncate = false;
chart1.legend.valueLabels.template.text = "[bold #26003d]{value}%[/] | [bold #A8A8A8]{value2}%[/]";




// Export this stuff
chart1.exporting.menu = new am4core.ExportMenu();
chart1.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart1.exporting.filePrefix = "CPE_PortfolioSector";


// ################################ CHART 2 CPE 10k Chart (Line) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart2 = am4core.create("chartdiv2", am4charts.XYChart);

// Set up data source
chart2.dataSource.url = "../Data/Backups/Catalyst/CPE/CPE_EXPORT_10kChart.csv";
chart2.dataSource.parser = new am4core.CSVParser();
chart2.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart2.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart2.numberFormatter.numberFormat = "'$'#,###.";


// Create axes
var dateAxis = chart2.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "20px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.minGridDistance = 60;
dateAxis.renderer.labels.template.location = 0;
dateAxis.renderer.maxLabelPosition = 1.02;
dateAxis.renderer.minLabelPosition = -1;
dateAxis.extraMax = 0.035; 
dateAxis.startLocation = 0.5;
dateAxis.endLocation = 0.4;
dateAxis.extraMin = 0.025; 
dateAxis.renderer.labels.template.dy = 10;


var valueAxis = chart2.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "20px";

valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart2.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "CPEAX";
series1.dataFields.dateX = "Date";
series1.name = "CPEAX";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.93;
series1.stroke = am4core.color("#08da94");

var series2 = chart2.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "S&P 500 TR Index";
series2.dataFields.dateX = "Date";
series2.name = "S&P 500 TR Index";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.tensionX = 0.93;
series2.stroke = am4core.color("#2d7abf");

// Add legend
chart2.legend = new am4charts.Legend();
chart2.legend.labels.template.fontSize = "20px";
chart2.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";
chart2.legend.labels.template.minWidth = 175;
chart2.legend.labels.template.truncate = false;


// Export this stuff
chart2.exporting.menu = new am4core.ExportMenu();
chart2.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart2.exporting.filePrefix = "CPE_10k";


// ################################ CHART 3 CPE - Performance Graph (Bar) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart3 = am4core.create("chartdiv3", am4charts.XYChart);

// Add percent sign to all numbers
chart3.numberFormatter.numberFormat = "#.#'%'";

// Set up data source
chart3.dataSource.url = "../Data/Backups/Catalyst/CPE/CPE_EXPORT_PerformanceBarGraph.csv";
chart3.dataSource.parser = new am4core.CSVParser();
chart3.dataSource.parser.options.useColumnNames = true;

// Create axes
var categoryAxis = chart3.xAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "Label";
categoryAxis.renderer.labels.template.fontWeight = "Bold";
categoryAxis.renderer.grid.template.disabled = false;
categoryAxis.renderer.grid.template.location = 0;
categoryAxis.renderer.minGridDistance = 30;
categoryAxis.renderer.labels.template.fontSize = "25px";
categoryAxis.renderer.cellStartLocation = 0.1;
categoryAxis.renderer.cellEndLocation = 0.9;
categoryAxis.renderer.grid.template.strokeOpacity = .2;
categoryAxis.renderer.labels.template.textAlign = "middle";

var valueAxis = chart3.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.grid.template.disabled = true;
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "25px";



// Create series
var series = chart3.series.push(new am4charts.ColumnSeries());
series.dataFields.valueY = "CPEAX";
series.dataFields.categoryX = "Label";
series.name = "CPEAX (% return)";
series.clustered = true;
series.fill = am4core.color("#08da94");
series.strokeWidth = 0;
series.columns.template.width = am4core.percent(100);


//var bullet = series.bullets.push(new am4charts.LabelBullet());
//bullet.label.text = "{valueY}";
//bullet.label.verticalCenter = "bottom";
//bullet.label.dy = 5;
//bullet.label.fontSize = 25;
//bullet.label.fontWeight = "Bold";
//chart3.maskBullets = false;

var series2 = chart3.series.push(new am4charts.ColumnSeries());
series2.dataFields.valueY = "S&P 500 TR Index";
series2.dataFields.categoryX = "Label";
series2.name = "S&P 500 TR Index (% return)";
series2.clustered = true;
series2.fill = am4core.color("#61a8e8");
series2.strokeWidth = 0;
series2.columns.template.width = am4core.percent(100);


//var bullet2 = series2.bullets.push(new am4charts.LabelBullet());
//bullet2.label.text = "{valueY}";
//bullet2.label.verticalCenter = "bottom";
//bullet2.label.dy = 0;
//bullet2.label.fontSize = 25;
//bullet2.label.fontWeight = "Bold";
//chart3.maskBullets = false;

// Add legend
chart3.legend = new am4charts.Legend();
chart3.legend.labels.template.fontSize = "25px";
chart3.legend.labels.template.minWidth = 220;
chart3.legend.labels.template.truncate = false;


// Export this stuff
chart3.exporting.menu = new am4core.ExportMenu();
chart3.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart3.exporting.filePrefix = "CPE_PerformanceBarGraph";


// ################################ CHART 4 CPE Institution 10k Chart (Line) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart4 = am4core.create("chartdiv4", am4charts.XYChart);

// Set up data source
chart4.dataSource.url = "../Data/Backups/Catalyst/CPE/CPE_I_EXPORT_10kChart.csv";
chart4.dataSource.parser = new am4core.CSVParser();
chart4.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart4.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart4.numberFormatter.numberFormat = "'$'#,###.";




// Create axes
var dateAxis = chart4.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "20px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.labels.template.dx = -10;
dateAxis.renderer.minGridDistance = 60;
dateAxis.renderer.labels.template.location = 0;



var valueAxis = chart4.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "20px";

valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart4.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "CP All Cap Equity Composite (Net)";
series1.dataFields.dateX = "Date";
series1.name = "CP All Cap Equity Composite (Net)";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.93;
series1.stroke = am4core.color("#08da94");

var series2 = chart4.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "S&P 500 TR Index";
series2.dataFields.dateX = "Date";
series2.name = "S&P 500 TR Index";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.tensionX = 0.93;
series2.stroke = am4core.color("#2d7abf");

// Add legend
chart4.legend = new am4charts.Legend();
chart4.legend.labels.template.fontSize = "20px";
chart4.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";
chart4.legend.labels.template.minWidth = 150;
chart4.legend.labels.template.truncate = false;


// Export this stuff
chart4.exporting.menu = new am4core.ExportMenu();
chart4.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart4.exporting.filePrefix = "CPE_I_10k";



// ################################ CHART 5 CPE Institutional - Performance Graph (Bar) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart5 = am4core.create("chartdiv5", am4charts.XYChart);

// Set up data source
chart5.dataSource.url = "../Data/Backups/Catalyst/CPE/CPE_I_EXPORT_PerformanceBar.csv";
chart5.dataSource.parser = new am4core.CSVParser();
chart5.dataSource.parser.options.useColumnNames = true;

// Create axes
var categoryAxis = chart5.xAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "Category";
categoryAxis.renderer.labels.template.fontWeight = "Bold";
categoryAxis.renderer.grid.template.disabled = false;
categoryAxis.renderer.grid.template.location = 0;
categoryAxis.renderer.minGridDistance = 30;
categoryAxis.renderer.labels.template.fontSize = "25px";
categoryAxis.renderer.cellStartLocation = 0.1;
categoryAxis.renderer.cellEndLocation = 0.9;
categoryAxis.renderer.grid.template.strokeOpacity = .2;
categoryAxis.renderer.labels.template.textAlign = "middle";

var valueAxis = chart5.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.grid.template.disabled = true;
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "25px";
valueAxis.renderer.numberFormatter.numberFormat = "#'%'";



// Create series
var series = chart5.series.push(new am4charts.ColumnSeries());
series.dataFields.valueY = "CP All Cap Equity Composite (Net)";
series.dataFields.categoryX = "Category";
series.name = "CP All Cap Equity Composite (% Return - Net)";
series.clustered = true;
series.fill = am4core.color("#08da94");
series.strokeWidth = 0;
series.columns.template.width = am4core.percent(100);


var bullet = series.bullets.push(new am4charts.LabelBullet());
bullet.label.text = "{valueY}";
bullet.label.verticalCenter = "bottom";
bullet.label.dy = 0;
bullet.label.fontSize = 20;
bullet.label.fontWeight = "Bold";
chart5.maskBullets = false;

var series2 = chart5.series.push(new am4charts.ColumnSeries());
series2.dataFields.valueY = "S&P 500 TR Index";
series2.dataFields.categoryX = "Category";
series2.name = "S&P 500 TR Index (% Return)";
series2.clustered = true;
series2.fill = am4core.color("#61a8e8");
series2.strokeWidth = 0;
series2.columns.template.width = am4core.percent(100);


var bullet2 = series2.bullets.push(new am4charts.LabelBullet());
bullet2.label.text = "{valueY}";
bullet2.label.verticalCenter = "bottom";
bullet2.label.dy = 0;
bullet2.label.fontSize = 20;
bullet2.label.fontWeight = "Bold";
chart5.maskBullets = false;

// Add legend
chart5.legend = new am4charts.Legend();
chart5.legend.labels.template.fontSize = "25px";
chart5.legend.labels.template.minWidth = 500;
chart5.legend.labels.template.truncate = false;


// Export this stuff
chart5.exporting.menu = new am4core.ExportMenu();
chart5.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart5.exporting.filePrefix = "CPE_I_PerformanceBarGraph";

// ################################   Export any charts OTHER THAN chart1 ################################################

function loadFrame() {
     chart1.exporting.export('svg');
     chart2.exporting.export('svg');
     chart3.exporting.export('svg');
     chart4.exporting.export('svg');
     chart5.exporting.export('svg');
};

window.onload = setTimeout(loadFrame, 1800);
                           
                        
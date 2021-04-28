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
        width:790px!important;
		height:460px!important;
    }

        #chartdiv2 {
        width:790px!important;
		height:480px!important;
    }

     #chartdiv3 {
        width:1330px!important;
    height:240px!important;
    }

     #chartdiv4 {
        width:400px!important;
    height:400px!important;
    }

     #chartdiv5 {
        width:810px!important;
    height:635px!important;
    } 

`;

// append to DOM
document.head.appendChild(style);




// ################################   CHART 1 RFX Brochure - Growth of 10k ################################################


// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart1 = am4core.create("chartdiv", am4charts.XYChart);

// Set up data source
chart1.dataSource.url = "../Data/Backups/Rational/RFX/RFX_BRO_10k.csv";
chart1.dataSource.parser = new am4core.CSVParser();
chart1.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart1.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart1.numberFormatter.numberFormat = "'$'#,###.";

// Create axes
var dateAxis = chart1.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "16px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.minGridDistance = 40;
dateAxis.renderer.labels.template.location = 0;
dateAxis.renderer.labels.template.dx = -10;
dateAxis.extraMax = 0.03; 



var valueAxis = chart1.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "16px";

valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart1.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "RFXIX";
series1.dataFields.dateX = "Date";
series1.name = "RFXIX";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.93;
series1.stroke = am4core.color("#08da94");
series1.legendSettings.labelText = "{name}[/]";
series1.legendSettings.valueText = "[bold {color}]{valueY.close}";

var series2 = chart1.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "Bloomberg MBS Index";
series2.dataFields.dateX = "Date";
series2.name = "Bloomberg MBS Index";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.tensionX = 0.93;
series2.stroke = am4core.color("#025268");
series2.legendSettings.labelText = "{name}[/]";
series2.legendSettings.valueText = "[bold {color}]{valueY.close}";

var series3 = chart1.series.push(new am4charts.LineSeries());
series3.dataFields.valueY = "Barclays U.S. AGG";
series3.dataFields.dateX = "Date";
series3.name = "Barclays U.S. AGG";
series3.strokeWidth = 3;
series3.tooltipText = "{valueY}";
series3.tensionX = 0.93;
series3.stroke = am4core.color("#b7b7bd");
series3.legendSettings.labelText = "{name}[/]";
series3.legendSettings.valueText = "[bold {color}]{valueY.close}";

// Add legend
chart1.legend = new am4charts.Legend();
chart1.legend.labels.template.truncate = false;


// Export this stuff
chart1.exporting.menu = new am4core.ExportMenu();
chart1.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart1.exporting.filePrefix = "RFX_BRO_10k";


// ################################ CHART 2 RFX Brochure - S&P 500 Growth of 10k ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart2 = am4core.create("chartdiv2", am4charts.XYChart);

// Set up data source
chart2.dataSource.url = "../Data/Backups/Rational/RFX/RFX_BRO_10k.csv";
chart2.dataSource.parser = new am4core.CSVParser();
chart2.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart2.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart2.numberFormatter.numberFormat = "'$'#,###.";

// Create axes
var dateAxis = chart2.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "16px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.minGridDistance = 40;
dateAxis.renderer.labels.template.location = 0;
dateAxis.renderer.labels.template.dx = -10;
dateAxis.extraMax = 0.03; 



var valueAxis = chart2.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "16px";

valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart2.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "RFXIX";
series1.dataFields.dateX = "Date";
series1.name = "RFXIX";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.93;
series1.stroke = am4core.color("#08da94");
series1.legendSettings.labelText = "{name}[/]";
series1.legendSettings.valueText = "[bold {color}]{valueY.close}";

var series2 = chart2.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "S&P 500 TR Index";
series2.dataFields.dateX = "Date";
series2.name = "S&P 500 TR Index";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.tensionX = 0.93;
series2.stroke = am4core.color("#025268");
series2.legendSettings.labelText = "{name}[/]";
series2.legendSettings.valueText = "[bold {color}]{valueY.close}";

var series3 = chart2.series.push(new am4charts.LineSeries());
series3.dataFields.valueY = "Barclays U.S. AGG";
series3.dataFields.dateX = "Date";
series3.name = "Barclays U.S. AGG";
series3.strokeWidth = 3;
series3.tooltipText = "{valueY}";
series3.tensionX = 0.93;
series3.stroke = am4core.color("#b7b7bd");
series3.legendSettings.labelText = "{name}[/]";
series3.legendSettings.valueText = "[bold {color}]{valueY.close}";

// Add legend
chart2.legend = new am4charts.Legend();
chart2.legend.labels.template.truncate = false;


// Export this stuff
chart2.exporting.menu = new am4core.ExportMenu();
chart2.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart2.exporting.filePrefix = "RFX_BRO_S&P_10k";


// ################################ CHART 3 RFX Performance Table (Bar) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart3 = am4core.create("chartdiv3", am4charts.XYChart);

// Add percent sign to all numbers
chart3.numberFormatter.numberFormat = "#.#'%'";

// Set up data source
chart3.dataSource.url = "../Data/Backups/Rational/RFX/RFX_BRO_PerformanceBar.csv";
chart3.dataSource.parser = new am4core.CSVParser();
chart3.dataSource.parser.options.useColumnNames = true;

// Create axes
var categoryAxis = chart3.xAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "Category";
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
label.maxWidth = 150;
var valueAxis = chart3.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.grid.template.disabled = true;
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "23px";



// Create series
var series = chart3.series.push(new am4charts.ColumnSeries());
series.dataFields.valueY = "Class I";
series.dataFields.categoryX = "Category";
series.name = "Class I";
series.clustered = true;
series.fill = am4core.color("#4574b9");
series.strokeWidth = 0;
series.columns.template.width = am4core.percent(100);



var series2 = chart3.series.push(new am4charts.ColumnSeries());
series2.dataFields.valueY = "Barclays US Agg TR Index";
series2.dataFields.categoryX = "Category";
series2.name = "Barclays US Agg TR Index";
series2.clustered = true;
series2.fill = am4core.color("#681d7d");
series2.strokeWidth = 0;
series2.columns.template.width = am4core.percent(100);



var series3 = chart3.series.push(new am4charts.ColumnSeries());
series3.dataFields.valueY = "Bloomberg MBS TR Index";
series3.dataFields.categoryX = "Category";
series3.name = "Bloomberg MBS TR Index";
series3.clustered = true;
series3.fill = am4core.color("#c02026");
series3.strokeWidth = 0;
series3.columns.template.width = am4core.percent(100);


// Export this stuff
chart3.exporting.menu = new am4core.ExportMenu();
chart3.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart3.exporting.filePrefix = "RFX_PerformanceBar";


// ################################ CHART 4 RFX Target Allocation (Pie) ################################################

// Create chart instance
var chart4 = am4core.create("chartdiv4", am4charts.PieChart);
chart4.innerRadius = am4core.percent(40);


// Set up data source
chart4.dataSource.url = "../Data/Backups/Rational/RFX/RFX_EXPORT_PieChart.csv";
chart4.dataSource.parser = new am4core.CSVParser();
chart4.dataSource.parser.options.useColumnNames = true;

// Add series
var series = chart4.series.push(new am4charts.PieSeries());

series.ticks.template.disabled = true;
series.alignLabels = false;
series.labels.template.text = "[bold]{value.percent.formatNumber('#.0')}%";
series.labels.template.radius = am4core.percent(-25);
series.labels.template.fill = am4core.color("white");
series.labels.template.fontSize = "20px";



series.dataFields.value = "Value";
series.dataFields.category = "Label";
series.slices.template.stroke = am4core.color("#ffffff");
series.slices.template.strokeWidth = 3;
series.slices.template.strokeOpacity = 1;
series.ticks.template.disabled = true;
series.slices.template.tooltipText = "";
series.colors.list = [
  am4core.color("#0d345e"),
  am4core.color("#c02026"),
  am4core.color("#6aaadd"),

];


// Export this stuff
chart4.exporting.menu = new am4core.ExportMenu();
chart4.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart4.exporting.filePrefix = "RFX_TargetAllocation";



// ################################ CHART 5 RFX - Growth of 10k (Line) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart5 = am4core.create("chartdiv5", am4charts.XYChart);

// Set up data source
chart5.dataSource.url = "../Data/Backups/Rational/RFX/RFX_EXPORT_10kChart.csv";
chart5.dataSource.parser = new am4core.CSVParser();
chart5.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart5.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart5.numberFormatter.numberFormat = "'$'#,###.";

// Create axes
var dateAxis = chart5.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "26px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.minGridDistance = 30;
dateAxis.renderer.labels.template.dx = -40;
dateAxis.renderer.labels.template.location = 0;
dateAxis.renderer.labels.template.rotation = -60;
dateAxis.renderer.labels.template.verticalCenter = "middle";
dateAxis.renderer.labels.template.horizontalCenter = "left";
//dateAxis.renderer.maxLabelPosition = 1.05;

var valueAxis = chart5.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "26px";
valueAxis.renderer.minGridDistance = 60;
valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart5.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "RFXIX";
series1.dataFields.dateX = "Date";
series1.name = "RFXIX";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.93;
series1.stroke = am4core.color("#08da94");

var series2 = chart5.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "Bloomberg MBS Index";
series2.dataFields.dateX = "Date";
series2.name = "Bloomberg MBS Index";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.tensionX = 0.93;
series2.stroke = am4core.color("#025268");

var series3 = chart5.series.push(new am4charts.LineSeries());
series3.dataFields.valueY = "Barclays US Agg";
series3.dataFields.dateX = "Date";
series3.name = "Barclays US AGG";
series3.strokeWidth = 3;
series3.tooltipText = "{valueY}";
series3.tensionX = 0.93;
series3.stroke = am4core.color("#b7b7bd");

// Add legend
chart5.legend = new am4charts.Legend();
chart5.legend.labels.template.fontSize = "26px";
chart5.legend.labels.template.truncate = false;
chart5.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";
chart5.legend.itemContainers.template.marginTop = -15;

// Export this stuff
chart5.exporting.menu = new am4core.ExportMenu();
chart5.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart5.exporting.filePrefix = "RFX_10k";


// ################################   Export any charts OTHER THAN chart1 ################################################

function loadFrame() {
     chart1.exporting.export('svg');
     chart2.exporting.export('svg');
     chart3.exporting.export('svg');
     chart4.exporting.export('svg');
     chart5.exporting.export('svg');
};

window.onload = setTimeout(loadFrame, 1800);
                           
                        
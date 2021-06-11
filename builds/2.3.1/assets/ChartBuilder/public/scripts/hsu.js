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
        width:1500px!important;
		height:320px!important;
    }

        #chartdiv2 {
        width:1200px!important;
		height:800px!important;
    }

     #chartdiv3 {
        width:690px!important;
    height:591px!important;
    }
    #chartdiv4 {
        width:1010px!important;
    height:451px!important;
    }
`;

// append to DOM
document.head.appendChild(style);




// ################################   CHART 1  HSU - Performance Table (Bar) ################################################


// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart1 = am4core.create("chartdiv", am4charts.XYChart);

// Add percent sign to all numbers
chart1.numberFormatter.numberFormat = "#.#'%'";

// Set up data source
chart1.dataSource.url = "../Data/Backups/Rational/HSU/HSU_EXPORT_PerformanceBar.csv";
chart1.dataSource.parser = new am4core.CSVParser();
chart1.dataSource.parser.options.useColumnNames = true;

// Create axes
var categoryAxis = chart1.xAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "Category";
categoryAxis.renderer.labels.template.fontWeight = "Bold";
categoryAxis.renderer.grid.template.disabled = false;
categoryAxis.renderer.grid.template.location = 0;
categoryAxis.renderer.minGridDistance = 30;
categoryAxis.renderer.labels.template.fontSize = "25px";
categoryAxis.renderer.cellStartLocation = 0.1;
categoryAxis.renderer.cellEndLocation = 0.9;
categoryAxis.renderer.grid.template.strokeOpacity = .2;



var valueAxis = chart1.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.grid.template.disabled = true;
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "32px";




// Create series
var series = chart1.series.push(new am4charts.ColumnSeries());
series.dataFields.valueY = "Class I";
series.dataFields.categoryX = "Category";
series.name = "Class I";
series.clustered = true;
series.fill = am4core.color("#08da94");
series.strokeWidth = 0;
series.columns.template.width = am4core.percent(100);




var series2 = chart1.series.push(new am4charts.ColumnSeries());
series2.dataFields.valueY = "S&P 500 TR Index";
series2.dataFields.categoryX = "Category";
series2.name = "S&P 500 TR Index";
series2.clustered = true;
series2.fill = am4core.color("#2d7abf");
series2.strokeWidth = 0;
series2.columns.template.width = am4core.percent(100);


// Export this stuff
chart1.exporting.menu = new am4core.ExportMenu();
chart1.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart1.exporting.filePrefix = "HSU_PerformanceTableBar";




// ################################   CHART 2  HSU - Growth of 10k (Line) ################################################


// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart2 = am4core.create("chartdiv2", am4charts.XYChart);

// Set up data source
chart2.dataSource.url = "../Data/Backups/Rational/HSU/HSU_EXPORT_10kChart.csv";
chart2.dataSource.parser = new am4core.CSVParser();
chart2.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart2.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart2.numberFormatter.numberFormat = "'$'#,###.";

// Create axes
var dateAxis = chart2.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "24px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.minGridDistance = 60;
dateAxis.renderer.labels.template.dx = -40;
dateAxis.renderer.labels.template.location = 0;
dateAxis.renderer.labels.template.rotation = -60;
dateAxis.renderer.labels.template.verticalCenter = "middle";
dateAxis.renderer.labels.template.horizontalCenter = "left";
dateAxis.dateFormats.setKey("month", "MM/yyyy");
dateAxis.periodChangeDateFormats.setKey("month", "MM/yyyy"); 
dateAxis.extraMax = 0.01; 

dateAxis.gridIntervals.setAll([
  { timeUnit: "month", count: 1 },
  { timeUnit: "month", count: 2 }
]);




var valueAxis = chart2.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "24px";
valueAxis.renderer.minGridDistance = 60;
valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart2.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "HSU";
series1.dataFields.dateX = "Date";
series1.name = "HSUTX";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.93;
series1.stroke = am4core.color("#08da94");

var series2 = chart2.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "S&P";
series2.dataFields.dateX = "Date";
series2.name = "S&P 500 TR Index";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.tensionX = 0.93;
series2.stroke = am4core.color("#025268");

// Add legend
chart2.legend = new am4charts.Legend();
chart2.legend.labels.template.fontSize = "24px";
chart2.legend.labels.template.truncate = false;
chart2.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";
chart2.legend.itemContainers.template.marginTop = -15;

// Export this stuff
chart2.exporting.menu = new am4core.ExportMenu();
chart2.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart2.exporting.filePrefix = "HSU_10k";


// ################################   CHART 3  HSU Sector Allocation (Pie) ################################################


// Create chart instance
var chart3 = am4core.create("chartdiv3", am4charts.PieChart);
chart3.innerRadius = am4core.percent(40);

// Set up data source
chart3.dataSource.url = "../Data/Backups/Rational/HSU/HSU_EXPORT_SectorWeights.csv";
chart3.dataSource.parser = new am4core.CSVParser();
chart3.dataSource.parser.options.useColumnNames = true;



// Make the chart fade-in on init
chart3.hiddenState.properties.opacity = 0;

// Add series
var series = chart3.series.push(new am4charts.PieSeries());
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
  am4core.color("#08da94"),
  am4core.color("#6aaadd"),
  am4core.color("#091829"),

];


// Create initial animation
series.hiddenState.properties.opacity = 1;
series.hiddenState.properties.endAngle = -90;
series.hiddenState.properties.startAngle = -90;


// Add legend
chart3.legend = new am4charts.Legend();
chart3.legend.position = "bottom";
chart3.legend.maxWidth = undefined;
chart3.legend.maxheight = 400;
chart3.legend.valueLabels.template.align = "right";
chart3.legend.valueLabels.template.textAlign = "end";  
chart3.legend.labels.template.minWidth = 175;
chart3.legend.labels.template.truncate = false;




// Export this stuff
chart3.exporting.menu = new am4core.ExportMenu();
chart3.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart3.exporting.filePrefix = "HSU_SectorAllocation";

// ################################   CHART 4  HSU Geographic Allocation (Pie) ################################################


// Create chart instance
var chart4 = am4core.create("chartdiv4", am4charts.PieChart);
chart4.innerRadius = am4core.percent(40);

// Set up data source
chart4.dataSource.url = "../Data/Backups/Rational/HSU/HSU_EXPORT_GeographicAllocation.csv";
chart4.dataSource.parser = new am4core.CSVParser();
chart4.dataSource.parser.options.useColumnNames = true;



// Make the chart fade-in on init
chart4.hiddenState.properties.opacity = 0;

// Add series
var series = chart4.series.push(new am4charts.PieSeries());
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
  am4core.color("#08da94"),
  am4core.color("#6aaadd"),
  am4core.color("#091829"),

];


// Create initial animation
series.hiddenState.properties.opacity = 1;
series.hiddenState.properties.endAngle = -90;
series.hiddenState.properties.startAngle = -90;


// Add legend
chart4.legend = new am4charts.Legend();
chart4.legend.position = "left";
chart4.legend.maxWidth = undefined;
chart4.legend.maxheight = 400;
chart4.legend.valueLabels.template.align = "right";
chart4.legend.valueLabels.template.textAlign = "end";  
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
chart4.exporting.filePrefix = "HSU_GeographicAllocation";

// ################################   Export any charts OTHER THAN chart1 ################################################

function loadFrame() {
     chart1.exporting.export('svg');
     chart2.exporting.export('svg');
     chart3.exporting.export('svg');
     chart4.exporting.export('svg');
};

window.onload = setTimeout(loadFrame, 1000);
                           
                        
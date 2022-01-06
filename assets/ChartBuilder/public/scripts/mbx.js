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
        width:740px!important;
		height:820px!important;
    }

        #chartdiv2 {
        width:860px!important;
		height:700px!important;
    }

     #chartdiv3 {
        width:790px!important;
    height:340px!important;
    }

     #chartdiv4 {
        width:860px!important;
    height:790px!important;
    }

     #chartdiv5 {
        width:1000px!important;
    height:800px!important;
    } 

`;

// append to DOM
document.head.appendChild(style);




// ################################   CHART 1 MBX 10k Chart (Line) ################################################


// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart1 = am4core.create("chartdiv", am4charts.XYChart);

// Set up data source
chart1.dataSource.url = "../Data/Backups/Catalyst/MBX/MBX_EXPORT_10kChart.csv";
chart1.dataSource.parser = new am4core.CSVParser();
chart1.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart1.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart1.numberFormatter.numberFormat = "'$'#,###.";




// Create axes
var dateAxis = chart1.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "19px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.labels.template.dx = -30;
dateAxis.renderer.minGridDistance = 25;
dateAxis.renderer.labels.template.location = 1;
dateAxis.renderer.labels.template.rotation = -60;
dateAxis.renderer.labels.template.verticalCenter = "middle";
dateAxis.renderer.labels.template.horizontalCenter = "left";
dateAxis.renderer.maxLabelPosition = 1.05;
dateAxis.extraMax = 0.01; 

var valueAxis = chart1.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "20px";
//valueAxis.extraMax = 0.1; 
valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";
valueAxis.logarithmic = true;
valueAxis.max = 140000;
valueAxis.min = 8750;
valueAxis.strictMinMax = true; 
valueAxis.renderer.grid.template.disabled = true;
valueAxis.renderer.labels.template.disabled = true;
function createGrid(value) {
  var range = valueAxis.axisRanges.create();
  range.value = value;
  range.label.text = "{value}";
}
createGrid(8750);
createGrid(17500);
createGrid(35000);
createGrid(70000);
createGrid(140000);
valueAxis.title.text = "Logarithmic";
valueAxis.title.fontSize = "20px";
valueAxis.title.fontWeight = "regular";
// Create series
var series1 = chart1.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "MBXIX";
series1.dataFields.dateX = "Date";
series1.name = "MBXIX";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.9;
series1.stroke = am4core.color("#08da94");

var series2 = chart1.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "S&P 500 TR Index";
series2.dataFields.dateX = "Date";
series2.name = "S&P 500 TR Index";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.tensionX = 0.9;
series2.stroke = am4core.color("#2d7abf");

// Add legend
chart1.legend = new am4charts.Legend();
chart1.legend.labels.template.fontSize = "20px";
chart1.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";
chart1.legend.labels.template.truncate = false;


// Export this stuff
chart1.exporting.menu = new am4core.ExportMenu();
chart1.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart1.exporting.filePrefix = "MBX_10k";


// ################################ CHART 2 MBX Brochure 1k Chart (Line) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart2 = am4core.create("chartdiv2", am4charts.XYChart);

// Set up data source
chart2.dataSource.url = "../Data/Backups/Catalyst/MBX/MBX_BRO_1kChart.csv";
chart2.dataSource.parser = new am4core.CSVParser();
chart2.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart2.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart2.numberFormatter.numberFormat = "'$'#,###.";




// Create axes
var dateAxis = chart2.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "25px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.minGridDistance = 25;
dateAxis.renderer.labels.template.location = 0;
dateAxis.renderer.labels.template.rotation = -60;
dateAxis.renderer.labels.template.verticalCenter = "middle";
dateAxis.renderer.labels.template.horizontalCenter = "middle";
dateAxis.extraMax = 0.03; 


var valueAxis = chart2.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "25px";
valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";
valueAxis.logarithmic = true;
valueAxis.max = 140000;
valueAxis.min = 8750;
valueAxis.strictMinMax = true; 
valueAxis.renderer.grid.template.disabled = true;
valueAxis.renderer.labels.template.disabled = true;
function createGrid(value) {
  var range = valueAxis.axisRanges.create();
  range.value = value;
  range.label.text = "{value}";
}
createGrid(8750);
createGrid(17500);
createGrid(35000);
createGrid(70000);
createGrid(140000);
valueAxis.title.text = "Logarithmic";
valueAxis.title.fontSize = "25px";
valueAxis.title.fontWeight = "regular";


// Create series
var series1 = chart2.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "Catalyst/Millburn";
series1.dataFields.dateX = "Date";
series1.name = "Catalyst/Millburn";
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

var series3 = chart2.series.push(new am4charts.LineSeries());
series3.dataFields.valueY = "U.S. Bonds";
series3.dataFields.dateX = "Date";
series3.name = "U.S. Bonds";
series3.strokeWidth = 3;
series3.tooltipText = "{valueY}";
series3.tensionX = 0.93;
series3.stroke = am4core.color("#d97c7c");

var series4 = chart2.series.push(new am4charts.LineSeries());
series4.dataFields.valueY = "Hedge Funds";
series4.dataFields.dateX = "Date";
series4.name = "Hedge Funds";
series4.strokeWidth = 3;
series4.tooltipText = "{valueY}";
series4.tensionX = 0.93;
series4.stroke = am4core.color("#61328d");

// Add legend
chart2.legend = new am4charts.Legend();
chart2.legend.labels.template.fontSize = "25px";
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
chart2.exporting.filePrefix = "MBX_BRO_1kChart";


// ################################ CHART 3 MBX Brochure Worst 5 Drawdowns ################################################





// ################################ CHART 4 MBX FAQ Brochure - Chart 1 ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart4 = am4core.create("chartdiv4", am4charts.XYChart);

// Set up data source
chart4.dataSource.url = "../Data/Backups/Catalyst/MBX/MBX_FAQ_Brochure_chart1.csv";
chart4.dataSource.parser = new am4core.CSVParser();
chart4.dataSource.parser.options.useColumnNames = true;

// Create axes
var categoryAxis = chart4.xAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "Category";
categoryAxis.renderer.labels.template.fontWeight = "Bold";
categoryAxis.renderer.grid.template.disabled = false;
categoryAxis.renderer.grid.template.location = 0;
categoryAxis.renderer.minGridDistance = 60;
categoryAxis.renderer.labels.template.fontSize = "20px";
categoryAxis.renderer.cellStartLocation = 0.3;
categoryAxis.renderer.cellEndLocation = 0.7;
categoryAxis.renderer.grid.template.strokeOpacity = .2;
categoryAxis.renderer.labels.template.textAlign = "middle";

var valueAxis = chart4.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.grid.template.disabled = true;
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "25px";
valueAxis.renderer.numberFormatter.numberFormat = "#.0'%'";



// Create series
var series = chart4.series.push(new am4charts.ColumnSeries());
series.dataFields.valueY = "Annualized Return";
series.dataFields.categoryX = "Category";
series.name = "Annualized Return";
series.clustered = true;
series.fill = am4core.color("#08da94");
series.strokeWidth = 0;
series.columns.template.width = am4core.percent(100);


var bullet = series.bullets.push(new am4charts.LabelBullet());
bullet.label.text = "{valueY}";
bullet.label.verticalCenter = "bottom";
bullet.label.dy = 0;
bullet.label.fontSize = 25;
bullet.label.fontWeight = "Bold";
chart4.maskBullets = false;

//var series2 = chart4.series.push(new am4charts.ColumnSeries());
//series2.dataFields.valueY = "S&P 500 TR Index";
//series2.dataFields.categoryX = "Category";
//series2.name = "S&P 500 TR Index (% Return)";
//series2.clustered = true;
//series2.fill = am4core.color("#61a8e8");
//series2.strokeWidth = 0;
//series2.columns.template.width = am4core.percent(100);


//var bullet2 = series2.bullets.push(new am4charts.LabelBullet());
//bullet2.label.text = "{valueY}";
//bullet2.label.verticalCenter = "bottom";
//bullet2.label.dy = 0;
//bullet2.label.fontSize = 20;
//bullet2.label.fontWeight = "Bold";
//chart4.maskBullets = false;

// Add legend
chart4.legend = new am4charts.Legend();
chart4.legend.labels.template.fontSize = "25px";
//chart4.legend.labels.template.minWidth = 500;
chart4.legend.labels.template.truncate = false;


// Export this stuff
chart4.exporting.menu = new am4core.ExportMenu();
chart4.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart4.exporting.filePrefix = "MBX_FAQ_Chart1";

// ################################ CHART 5 MBX FAQ Brochure - Chart 2 ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart5 = am4core.create("chartdiv5", am4charts.XYChart);

// Set up data source
chart5.dataSource.url = "../Data/Backups/Catalyst/MBX/MBX_FAQ_Brochure_chart2.csv";
chart5.dataSource.parser = new am4core.CSVParser();
chart5.dataSource.parser.options.useColumnNames = true;

// Create axes
var categoryAxis = chart5.xAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "Category";
categoryAxis.renderer.labels.template.fontWeight = "Bold";
categoryAxis.renderer.grid.template.disabled = false;
categoryAxis.renderer.grid.template.location = 0;
categoryAxis.renderer.minGridDistance = 60;
categoryAxis.renderer.labels.template.fontSize = "20px";
categoryAxis.renderer.cellStartLocation = 0.1;
categoryAxis.renderer.cellEndLocation = 0.9;
categoryAxis.renderer.grid.template.strokeOpacity = .2;
categoryAxis.renderer.labels.template.textAlign = "middle";

var valueAxis = chart5.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.grid.template.disabled = true;
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "25px";
valueAxis.renderer.numberFormatter.numberFormat = "#'%'";
valueAxis.max = 0;



// Create series
var series = chart5.series.push(new am4charts.ColumnSeries());
series.dataFields.valueY = "Worst Drawdown";
series.dataFields.categoryX = "Category";
series.name = "Worst Drawdown";
series.clustered = true;
series.fill = am4core.color("#08da94");
series.strokeWidth = 0;
series.columns.template.width = am4core.percent(100);



var series2 = chart5.series.push(new am4charts.ColumnSeries());
series2.dataFields.valueY = "2nd Worst Drawdown";
series2.dataFields.categoryX = "Category";
series2.name = "2nd Worst Drawdown";
series2.clustered = true;
series2.fill = am4core.color("#61a8e8");
series2.strokeWidth = 0;
series2.columns.template.width = am4core.percent(100);


var series3 = chart5.series.push(new am4charts.ColumnSeries());
series3.dataFields.valueY = "3rd Worst Drawdown";
series3.dataFields.categoryX = "Category";
series3.name = "3rd Worst Drawdown";
series3.clustered = true;
series3.fill = am4core.color("#26003d");
series3.strokeWidth = 0;
series3.columns.template.width = am4core.percent(100);


// Add legend
chart5.legend = new am4charts.Legend();
chart5.legend.labels.template.fontSize = "25px";
//chart5.legend.labels.template.minWidth = 500;
chart5.legend.labels.template.truncate = false;


// Export this stuff
chart5.exporting.menu = new am4core.ExportMenu();
chart5.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart5.exporting.filePrefix = "MBX_FAQ_Chart2";


// ################################   Export any charts OTHER THAN chart1 ################################################

function loadFrame() {
     chart1.exporting.export('svg');
     chart2.exporting.export('svg');
    // chart3.exporting.export('svg');
     chart4.exporting.export('svg');
     chart5.exporting.export('svg');
};

window.onload = setTimeout(loadFrame, 6000);
                           
                        
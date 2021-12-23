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
        width:1200px!important;
    height:400px!important;
    }
    #chartdiv4 {
        width:900px!important;
    height:345px!important;
    }
`;

// append to DOM
document.head.appendChild(style);




// ################################   CHART 1  HRS - Growth of 10k (Line) ################################################


// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart1 = am4core.create("chartdiv", am4charts.XYChart);

// Set up data source
chart1.dataSource.url = "../Data/Backups/Rational/HRS/HRS_EXPORT_10kChart.csv";
chart1.dataSource.parser = new am4core.CSVParser();
chart1.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart1.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart1.numberFormatter.numberFormat = "'$'#,###.";

// Create axes
var dateAxis = chart1.xAxes.push(new am4charts.DateAxis());
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


var valueAxis = chart1.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "24px";
valueAxis.renderer.minGridDistance = 60;
valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart1.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "HRSTX";
series1.dataFields.dateX = "Date";
series1.name = "HRSTX";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.93;
series1.stroke = am4core.color("#08da94");

var series2 = chart1.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "S&P 500 TR Index";
series2.dataFields.dateX = "Date";
series2.name = "S&P 500 TR Index";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.tensionX = 0.93;
series2.stroke = am4core.color("#025268");

// Add legend
chart1.legend = new am4charts.Legend();
chart1.legend.labels.template.fontSize = "24px";
chart1.legend.labels.template.truncate = false;
chart1.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";
chart1.legend.itemContainers.template.marginTop = -15;

// Export this stuff
chart1.exporting.menu = new am4core.ExportMenu();
chart1.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart1.exporting.filePrefix = "HRS_10k";




// ################################   CHART 2  HRS - Performance Table (Bar) ################################################




// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart2 = am4core.create("chartdiv2", am4charts.XYChart);

// Add percent sign to all numbers
chart2.numberFormatter.numberFormat = "#.#'%'";

// Set up data source
chart2.dataSource.url = "../Data/Backups/Rational/HRS/HRS_EXPORT_PerformanceBar.csv";
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
series.dataFields.valueY = "Class I";
series.dataFields.categoryX = "Category";
series.name = "Class I";
series.clustered = true;
series.fill = am4core.color("#08da94");
series.strokeWidth = 0;
series.columns.template.width = am4core.percent(100);




var series2 = chart2.series.push(new am4charts.ColumnSeries());
series2.dataFields.valueY = "S&P 500 TR Index";
series2.dataFields.categoryX = "Category";
series2.name = "Mid-Cap Blend";
series2.clustered = true;
series2.fill = am4core.color("#2d7abf");
series2.strokeWidth = 0;
series2.columns.template.width = am4core.percent(100);


// Export this stuff
chart2.exporting.menu = new am4core.ExportMenu();
chart2.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart2.exporting.filePrefix = "HRS_PerformanceTableBar";


// ################################   CHART 3  HRS Institutional - Growth of 10k (Line) ################################################


// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart3 = am4core.create("chartdiv3", am4charts.XYChart);

// Set up data source
chart3.dataSource.url = "../Data/Backups/Rational/HRS/HRS_I_EXPORT_10k.csv";
chart3.dataSource.parser = new am4core.CSVParser();
chart3.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart3.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart3.numberFormatter.numberFormat = "'$'#,###.";

// Create axes
var dateAxis = chart3.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "24px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.minGridDistance = 80;
dateAxis.renderer.labels.template.location = 0;
dateAxis.renderer.minLabelPosition = -0.05;
dateAxis.extraMax = 0.05; 



var valueAxis = chart3.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "24px";
valueAxis.renderer.minGridDistance = 60;
valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart3.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "Tactical Return Composite (Net)";
series1.dataFields.dateX = "Date";
series1.name = "Tactical Return Composite (Net)";
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
series2.stroke = am4core.color("#025268");

var series3 = chart3.series.push(new am4charts.LineSeries());
series3.dataFields.valueY = "S&P 500 TR Index";
series3.dataFields.dateX = "Date";
series3.name = "S&P 500 TR Index";
series3.strokeWidth = 3;
series3.tooltipText = "{valueY}";
series3.tensionX = 0.93;
series3.stroke = am4core.color("#b7b7bd");

// Add legend
chart3.legend = new am4charts.Legend();
chart3.legend.labels.template.fontSize = "24px";
chart3.legend.labels.template.truncate = false;
chart3.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";
chart3.legend.itemContainers.template.marginTop = -15;

// Export this stuff
chart3.exporting.menu = new am4core.ExportMenu();
chart3.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart3.exporting.filePrefix = "HRS_I_10k";

// ################################   CHART 4  HRS Institutional - Risk/Reward Profile ################################################


// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart4 = am4core.create("chartdiv4", am4charts.XYChart);
chart4.colors.step = 3;
chart4.numberFormatter.numberFormat = "#.00'%'";

// Set up data source
chart4.dataSource.url = "../Data/Backups/Rational/HRS/HRS_I_EXPORT_RiskRewardProfile.csv";
chart4.dataSource.parser = new am4core.CSVParser();
chart4.dataSource.parser.options.useColumnNames = true;

// Create axes
var xAxis = chart4.xAxes.push(new am4charts.ValueAxis());
xAxis.renderer.minGridDistance = 50;
xAxis.title.text = "Standard Deviation (Risk)";
xAxis.renderer.labels.template.fontSize = "18px";
xAxis.extraMax = 0.3; 
xAxis.extraMin = 0.3; 
xAxis.title.fontSize = 20;
xAxis.title.fontWeight = "Bold";


var yAxis = chart4.yAxes.push(new am4charts.ValueAxis());
yAxis.renderer.minGridDistance = 50;
yAxis.title.text = "Annualized Return";
yAxis.extraMin = 0.3; 
yAxis.extraMax = 0.3; 
yAxis.renderer.labels.template.fontSize = "18px";
yAxis.title.fontSize = 20;
yAxis.title.fontWeight = "Bold";
yAxis.numberFormatter.numberFormat = "#.##'%'";



var series = chart4.series.push(new am4charts.LineSeries());
series.dataFields.valueY = "AR Tactical Return Composite (Net)";
series.dataFields.valueX = "SD Tactical Return Composite (Net)";
series.dataFields.value = "value";
series.strokeOpacity = 0;
series.name = "Tactical Return Composite (Net)";

var series2 = chart4.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "AR Barclay CTA Index";
series2.dataFields.valueX = "SD Barclay CTA Index";
series2.dataFields.value = "value";
series2.strokeOpacity = 0;
series2.name = "Barclay CTA Index";

var series3 = chart4.series.push(new am4charts.LineSeries());
series3.dataFields.valueY = "AR S&P 500 TR Index";
series3.dataFields.valueX = "SD S&P 500 TR Index";
series3.dataFields.value = "value";
series3.strokeOpacity = 0;
series3.name = "S&P 500 TR Index";




var bullet = series.bullets.push(new am4charts.CircleBullet());
bullet.strokeOpacity = 0;
bullet.stroke = am4core.color("#ffffff");
bullet.fill = am4core.color("#08da94");
bullet.circle.radius = 10;

let labelBullet = series.bullets.push(new am4charts.LabelBullet());
labelBullet.strokeOpacity = 0;
labelBullet.label.text = "Tactical Return Composite (Net)";
labelBullet.label.dx = 125;
labelBullet.label.dy = 1;
labelBullet.strokeWidth = 0;



var bullet2 = series2.bullets.push(new am4charts.CircleBullet())
bullet2.strokeOpacity = 0;
bullet2.stroke = am4core.color("#ffffff");
bullet2.fill = am4core.color("#025268");
bullet2.circle.radius = 10;

let labelBullet2 = series2.bullets.push(new am4charts.LabelBullet());
labelBullet2.strokeOpacity = 0;
labelBullet2.label.text = "Barclay CTA Index";
labelBullet2.label.dx = 78;
labelBullet2.label.dy = 1;
labelBullet2.strokeWidth = 0;


var bullet3 = series3.bullets.push(new am4charts.CircleBullet());
bullet3.strokeOpacity = 0;
bullet3.stroke = am4core.color("#ffffff");
bullet3.fill = am4core.color("#b7b7bd");
bullet3.circle.radius = 10;


let labelBullet3 = series3.bullets.push(new am4charts.LabelBullet());
labelBullet3.strokeOpacity = 0;
labelBullet3.label.text = "S&P 500 TR Index";
labelBullet3.label.dx = 78;
labelBullet3.label.dy = 1;
labelBullet3.strokeWidth = 0;


chart4.legend = new am4charts.Legend();
chart4.legend.labels.template.text = "[bold]{name}[/]\nAnnualized Return: {valueY.close}\nStandard Deviation (Net): {valueX.close}";
chart4.legend.position = "top";
chart4.legend.itemContainers.template.marginBottom = 10;


// Export this stuff
chart4.exporting.menu = new am4core.ExportMenu();
chart4.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart4.exporting.filePrefix = "HRS_I_RiskRewardProfile";

// ################################   Export any charts OTHER THAN chart1 ################################################

function loadFrame() {
     chart1.exporting.export('svg');
     chart2.exporting.export('svg');
     chart3.exporting.export('svg');
     chart4.exporting.export('svg');
};

window.onload = setTimeout(loadFrame, 6000);
                           
                        
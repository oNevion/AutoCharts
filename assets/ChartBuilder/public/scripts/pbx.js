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
        width:1010px!important;
		height:535px!important;
    }

        #chartdiv2 {
        width:1010px!important;
		height:451px!important;
    }

     #chartdiv3 {
        width:1600px!important;
    height:680px!important;
    }

    #chartdiv4 {
        width:1330px!important;
    height:400px!important;
    }
`;

// append to DOM
document.head.appendChild(style);




// ################################   CHART 1  PBX - 10k Chart (Line) ################################################


// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart1 = am4core.create("chartdiv", am4charts.XYChart);

// Set up data source
chart1.dataSource.url = "../Data/Backups/Rational/PBX/PBX_EXPORT_10kChart.csv";
chart1.dataSource.parser = new am4core.CSVParser();
chart1.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart1.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart1.numberFormatter.numberFormat = "'$'#,###.";

// Create axes
var dateAxis = chart1.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "26px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.minGridDistance = 30;
dateAxis.renderer.labels.template.dx = -40;
dateAxis.renderer.labels.template.location = 0;
dateAxis.renderer.labels.template.rotation = -60;
dateAxis.renderer.labels.template.verticalCenter = "middle";
dateAxis.renderer.labels.template.horizontalCenter = "left";
dateAxis.dateFormats.setKey("month", "MM/yyyy");
dateAxis.periodChangeDateFormats.setKey("month", "MM/yyyy"); 
dateAxis.extraMax = 0.005; 

dateAxis.gridIntervals.setAll([
  { timeUnit: "month", count: 1 },
  { timeUnit: "month", count: 3 }
]);


var valueAxis = chart1.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "26px";
valueAxis.renderer.minGridDistance = 60;
valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart1.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "PBXIX";
series1.dataFields.dateX = "Date";
series1.name = "PBXIX";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.93;
series1.stroke = am4core.color("#08da94");

var series2 = chart1.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "Barclays Aggregate";
series2.dataFields.dateX = "Date";
series2.name = "Barclays Aggregate";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.tensionX = 0.93;
series2.stroke = am4core.color("#025268");

//var series3 = chart1.series.push(new am4charts.LineSeries());
//series3.dataFields.valueY = "S&P 500 TR Index";
//series3.dataFields.dateX = "Date";
//series3.name = "S&P 500 TR Index";
//series3.strokeWidth = 3;
//series3.tooltipText = "{valueY}";
//series3.tensionX = 0.93;
//series3.stroke = am4core.color("#b7b7bd");

// Add legend
chart1.legend = new am4charts.Legend();
chart1.legend.labels.template.fontSize = "26px";
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
chart1.exporting.filePrefix = "PBX_10k";




// ################################   CHART 2  PBX - Securities Asset (Pie) ################################################


// Create chart instance
var chart2 = am4core.create("chartdiv2", am4charts.PieChart);
chart2.innerRadius = am4core.percent(40);

// Set up data source
chart2.dataSource.url = "../Data/Backups/Rational/PBX/PBX_EXPORT_SecuritiesAssetPie.csv";
chart2.dataSource.parser = new am4core.CSVParser();
chart2.dataSource.parser.options.useColumnNames = true;



// Make the chart fade-in on init
chart2.hiddenState.properties.opacity = 0;

// Add series
var series = chart2.series.push(new am4charts.PieSeries());
series.ticks.template.disabled = true;
series.labels.template.disabled = true;
series.alignLabels = false;
series.labels.template.text = "[bold]{value.percent.formatNumber('#.0')}%";
series.labels.template.radius = am4core.percent(-25);
series.labels.template.fill = am4core.color("white");
series.labels.template.fontSize = "20px";
series.dataFields.value = "Value";
series.dataFields.category = "Label";
series.slices.template.stroke = am4core.color("#ffffff");
series.slices.template.strokeWidth = 2;
series.slices.template.strokeOpacity = 1;
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
chart2.legend = new am4charts.Legend();
chart2.legend.position = "right";
chart2.legend.maxWidth = undefined;
chart2.legend.maxheight = 400;
chart2.legend.valueLabels.template.align = "right";
chart2.legend.valueLabels.template.textAlign = "end";  
chart2.legend.labels.template.minWidth = 300;
chart2.legend.labels.template.truncate = false;
chart2.legend.scale = 1.4;




// Export this stuff
chart2.exporting.menu = new am4core.ExportMenu();
chart2.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart2.exporting.filePrefix = "PBX_SecuritiesAsset";


// ################################   CHART 3  PBX - Convertible Bonds Flyer Chart ################################################


// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart3 = am4core.create("chartdiv3", am4charts.XYChart);

// Add percent sign to all numbers
chart3.numberFormatter.numberFormat = "#.'%'";

// Set up data source
chart3.dataSource.url = "../Data/Backups/Rational/PBX/PBX_ConvertibleBonds_BarGraph.csv";
chart3.dataSource.parser = new am4core.CSVParser();
chart3.dataSource.parser.options.useColumnNames = true;

// Create axes
var categoryAxis = chart3.xAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "Label";
//categoryAxis.renderer.labels.template.fontWeight = "Bold";
categoryAxis.renderer.grid.template.disabled = false;
categoryAxis.renderer.grid.template.location = 0;
//categoryAxis.renderer.minGridDistance = 30;
categoryAxis.renderer.labels.template.fontSize = "25px";
categoryAxis.renderer.cellStartLocation = 0.1;
categoryAxis.renderer.cellEndLocation = 0.9;
categoryAxis.renderer.grid.template.strokeOpacity = .2;
//categoryAxis.renderer.inside = true;
categoryAxis.renderer.opposite = true;



var valueAxis = chart3.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.grid.template.disabled = true;
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "25px";
//valueAxis.numberFormatter.numberFormat = "#.00'%'";
//valueAxis.adjustLabelPrecision = false;




// Create series
var series = chart3.series.push(new am4charts.ColumnSeries());
series.dataFields.valueY = "Convertibles";
series.dataFields.categoryX = "Label";
series.name = "Convertibles";
series.clustered = true;
series.fill = am4core.color("#08da94");
series.strokeWidth = 0;
series.columns.template.width = am4core.percent(100);

var series2 = chart3.series.push(new am4charts.ColumnSeries());
series2.dataFields.valueY = "Equities";
series2.dataFields.categoryX = "Label";
series2.name = "Equities";
series2.clustered = true;
series2.fill = am4core.color("#0D345E");
series2.strokeWidth = 0;
series2.columns.template.width = am4core.percent(100);


var series3 = chart3.series.push(new am4charts.ColumnSeries());
series3.dataFields.valueY = "Government Bonds";
series3.dataFields.categoryX = "Label";
series3.name = "Government Bonds";
series3.clustered = true;
series3.fill = am4core.color("#6EB3FF");
series3.strokeWidth = 0;
series3.columns.template.width = am4core.percent(100);


var series4 = chart3.series.push(new am4charts.ColumnSeries());
series4.dataFields.valueY = "Treasuries";
series4.dataFields.categoryX = "Label";
series4.name = "Treasuries";
series4.clustered = true;
series4.fill = am4core.color("#c02026");
series4.strokeWidth = 0;
series4.columns.template.width = am4core.percent(100);

var series5 = chart3.series.push(new am4charts.ColumnSeries());
series5.dataFields.valueY = "Agg";
series5.dataFields.categoryX = "Label";
series5.name = "Agg";
series5.clustered = true;
series5.fill = am4core.color("#444444");
series5.strokeWidth = 0;
series5.columns.template.width = am4core.percent(100);

// Add legend
chart3.legend = new am4charts.Legend();
chart3.legend.labels.template.fontSize = "24px";
chart3.legend.labels.template.truncate = false;
chart3.legend.labels.template.text = "{name}[/] [bold {color}]";

// Export this stuff
chart3.exporting.menu = new am4core.ExportMenu();
chart3.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart3.exporting.filePrefix = "PBX_ConvertibleBondsChart";

// ################################   CHART 4  PBX Case Study - Convertible Issuance Bar ################################################


// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart4 = am4core.create("chartdiv4", am4charts.XYChart);


// Set up data source
chart4.dataSource.url = "../Data/Backups/Rational/PBX/PBX_CaseStudy_ConvertibleIssuanceBar.csv";
chart4.dataSource.parser = new am4core.CSVParser();
chart4.dataSource.parser.options.useColumnNames = true;

// Create axes
var categoryAxis = chart4.xAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "Year";
categoryAxis.renderer.labels.template.fontWeight = "Bold";
categoryAxis.renderer.grid.template.disabled = false;
categoryAxis.renderer.grid.template.location = 0;
categoryAxis.renderer.minGridDistance = 30;
categoryAxis.renderer.labels.template.fontSize = "30px";
categoryAxis.renderer.cellStartLocation = 0.1;
categoryAxis.renderer.cellEndLocation = 0.9;
categoryAxis.renderer.grid.template.strokeOpacity = .2;
categoryAxis.renderer.labels.template.textAlign = "middle";

var valueAxis = chart4.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.grid.template.disabled = true;
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "30px";
valueAxis.renderer.numberFormatter.numberFormat = "#";
valueAxis.min = 0;



// Create series
var series = chart4.series.push(new am4charts.ColumnSeries());
series.dataFields.valueY = "Convertibles";
series.dataFields.categoryX = "Year";
series.name = "Convertibles";
series.clustered = true;
series.fill = am4core.color("#08da94");
series.strokeWidth = 0;
series.columns.template.width = am4core.percent(80);


var bullet = series.bullets.push(new am4charts.LabelBullet());
bullet.label.text = "{valueY.value}";
bullet.label.hideOversized = false;
bullet.label.fontSize = "32px";
bullet.label.strokeWidth = 0;
bullet.label.adapter.add("verticalCenter", function(center, target) {
  if (!target.dataItem) {
    return center;
  }
  var values = target.dataItem.values;
  return values.valueY.value > values.openValueY.value
    ? "top"
    : "bottom";
});

// Add legend
chart4.legend = new am4charts.Legend();
chart4.legend.labels.template.fontSize = "30px";
chart4.legend.labels.template.truncate = false;
chart4.maskBullets = false


// Export this stuff
chart4.exporting.menu = new am4core.ExportMenu();
chart4.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart4.exporting.filePrefix = "PBX_CaseStudy_ConvertibleIssuanceBar";

// ################################   Export any charts OTHER THAN chart1 ################################################

function loadFrame() {
     chart1.exporting.export('svg');
     chart2.exporting.export('svg');
     chart3.exporting.export('svg');
     chart4.exporting.export('svg');
};

window.onload = setTimeout(loadFrame, 6000);
                           
                        
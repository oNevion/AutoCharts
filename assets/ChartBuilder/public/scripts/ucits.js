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
		height:350px!important;
    }

        #chartdiv2 {
        width:400px!important;
		height:400px!important;
    }

     #chartdiv3 {
        width:400px!important;
    height:400px!important;
    }

    #chartdiv4 {
        width:1500px!important;
    height:350px!important;
    }

`;

// append to DOM
document.head.appendChild(style);




// ################################   CHART 1 UCITS - Growth of 10k ################################################


// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart1 = am4core.create("chartdiv", am4charts.XYChart);

// Set up data source
chart1.dataSource.url = "../Data/Backups/Catalyst/UCITS/UCITS_10kChart.csv";
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
//dateAxis.renderer.minGridDistance = 40;
dateAxis.renderer.labels.template.location = 0;
dateAxis.renderer.labels.template.dx = -10;
//dateAxis.extraMax = 0.03;
dateAxis.renderer.labels.template.dy = 10;
dateAxis.dateFormats.setKey("month", "MM/yyyy");
dateAxis.periodChangeDateFormats.setKey("month", "MM/yyyy"); 
dateAxis.renderer.labels.template.rotation = -45;
dateAxis.renderer.labels.template.verticalCenter = "middle";
dateAxis.renderer.labels.template.horizontalCenter = "middle";
dateAxis.startLocation = 0.49;
dateAxis.endLocation = 0.7;



var valueAxis = chart1.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "24px";

valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart1.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "Fund";
series1.dataFields.dateX = "Date";
series1.name = "Founder USD";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.93;
series1.stroke = am4core.color("#293241");
series1.legendSettings.labelText = "{name}[/]";
series1.legendSettings.valueText = "[bold {color}]{valueY.close}";

var series2 = chart1.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "Bloomberg MBS TR Index";
series2.dataFields.dateX = "Date";
series2.name = "Bloomberg MBS TR Index";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.tensionX = 0.93;
series2.stroke = am4core.color("#6b8ead");
series2.legendSettings.labelText = "{name}[/]";
series2.legendSettings.valueText = "[bold {color}]{valueY.close}";

var series3 = chart1.series.push(new am4charts.LineSeries());
series3.dataFields.valueY = "Bloomberg Aggregate Bond TR Index";
series3.dataFields.dateX = "Date";
series3.name = "Bloomberg Aggregate Bond TR Index";
series3.strokeWidth = 3;
series3.tooltipText = "{valueY}";
series3.tensionX = 0.93;
series3.stroke = am4core.color("#79c99e");
series3.legendSettings.labelText = "{name}[/]";
series3.legendSettings.valueText = "[bold {color}]{valueY.close}";

// Add legend
chart1.legend = new am4charts.Legend();
chart1.legend.labels.template.truncate = false;
chart1.legend.labels.template.fontSize = "24px";
chart1.legend.valueLabels.template.fontSize = "24px";

// Export this stuff
chart1.exporting.menu = new am4core.ExportMenu();
chart1.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart1.exporting.filePrefix = "UCITS_10k_Chart";


// ################################ CHART 2 UCITS - Credit Breakdown Pie ################################################

// Create chart instance
var chart2 = am4core.create("chartdiv2", am4charts.PieChart);
chart2.innerRadius = am4core.percent(60);


// Set up data source
chart2.dataSource.url = "../Data/Backups/Catalyst/UCITS/UCITS_CreditBreakdown.csv";
chart2.dataSource.parser = new am4core.CSVParser();
chart2.dataSource.parser.options.useColumnNames = true;

// Add series
var series = chart2.series.push(new am4charts.PieSeries());

series.ticks.template.disabled = true;
series.labels.template.disabled = true;



series.dataFields.value = "Value";
series.dataFields.category = "Label";
series.slices.template.stroke = am4core.color("#ffffff");
series.slices.template.strokeWidth = 3;
series.slices.template.strokeOpacity = 1;
series.ticks.template.disabled = true;
series.slices.template.tooltipText = "";
series.colors.list = [
  am4core.color("#293241"),
  am4core.color("#3D5A80"),
  am4core.color("#6B8EAD"),
  am4core.color("#98C1D9"),

];


// Export this stuff
chart2.exporting.menu = new am4core.ExportMenu();
chart2.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart2.exporting.filePrefix = "UCITS_CreditBreakdownPie";


// ################################ CHART 3 UCITS - Liquidity Breakdown Pie ################################################

// Create chart instance
var chart3 = am4core.create("chartdiv3", am4charts.PieChart);
chart3.innerRadius = am4core.percent(60);


// Set up data source
chart3.dataSource.url = "../Data/Backups/Catalyst/UCITS/UCITS_LiquidityBreakdown.csv";
chart3.dataSource.parser = new am4core.CSVParser();
chart3.dataSource.parser.options.useColumnNames = true;

// Add series
var series = chart3.series.push(new am4charts.PieSeries());

series.ticks.template.disabled = true;
series.labels.template.disabled = true;


series.dataFields.value = "Value";
series.dataFields.category = "Label";
series.slices.template.stroke = am4core.color("#ffffff");
series.slices.template.strokeWidth = 3;
series.slices.template.strokeOpacity = 1;
series.ticks.template.disabled = true;
series.slices.template.tooltipText = "";
series.colors.list = [
  am4core.color("#293241"),
  am4core.color("#3D5A80"),
  am4core.color("#6B8EAD"),
  am4core.color("#98C1D9"),

];


// Export this stuff
chart3.exporting.menu = new am4core.ExportMenu();
chart3.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart3.exporting.filePrefix = "UCITS_LiquidityBreakdownPie";


// ################################   CHART 4  UCITS - Performance Table (Bar) ################################################


// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart4 = am4core.create("chartdiv4", am4charts.XYChart);

// Add percent sign to all numbers
chart4.numberFormatter.numberFormat = "#.#'%'";

// Set up data source
chart4.dataSource.url = "../Data/Backups/Catalyst/UCITS/UCITS_PerformanceBarGraph.csv";
chart4.dataSource.parser = new am4core.CSVParser();
chart4.dataSource.parser.options.useColumnNames = true;

// Create axes
var categoryAxis = chart4.xAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "Category";
categoryAxis.renderer.labels.template.fontWeight = "Bold";
categoryAxis.renderer.labels.template.fontSize = "24px";
categoryAxis.renderer.grid.template.disabled = false;
categoryAxis.renderer.grid.template.location = 0;
categoryAxis.renderer.minGridDistance = 30;
categoryAxis.renderer.labels.template.fontSize = "25px";
categoryAxis.renderer.cellStartLocation = 0.1;
categoryAxis.renderer.cellEndLocation = 0.9;
categoryAxis.renderer.grid.template.strokeOpacity = .2;



var valueAxis = chart4.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.grid.template.disabled = true;
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "24px";




// Create series
var series = chart4.series.push(new am4charts.ColumnSeries());
series.dataFields.valueY = "Founder USD";
series.dataFields.categoryX = "Category";
series.name = "Founder USD";
series.clustered = true;
series.fill = am4core.color("#293241");
series.strokeWidth = 0;
series.columns.template.width = am4core.percent(100);




var series2 = chart4.series.push(new am4charts.ColumnSeries());
series2.dataFields.valueY = "Bloomberg MBS TR Index";
series2.dataFields.categoryX = "Category";
series2.name = "Bloomberg MBS TR Index";
series2.clustered = true;
series2.fill = am4core.color("#6b8ead");
series2.strokeWidth = 0;
series2.columns.template.width = am4core.percent(100);


var series3 = chart4.series.push(new am4charts.ColumnSeries());
series3.dataFields.valueY = "Bloomberg Aggregate Bond TR Index";
series3.dataFields.categoryX = "Category";
series3.name = "Bloomberg Aggregate Bond TR Index";
series3.clustered = true;
series3.fill = am4core.color("#79c99e");
series3.strokeWidth = 0;
series3.columns.template.width = am4core.percent(100);

// Add legend
chart4.legend = new am4charts.Legend();
chart4.legend.labels.template.truncate = false;
chart4.legend.labels.template.fontSize = "24px";
chart4.legend.valueLabels.template.fontSize = "24px";

// Export this stuff
chart4.exporting.menu = new am4core.ExportMenu();
chart4.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart4.exporting.filePrefix = "UCITS_PerformanceTableBar";


// ################################   Export any charts OTHER THAN chart1 ################################################

function loadFrame() {
     chart1.exporting.export('svg');
     chart2.exporting.export('svg');
     chart3.exporting.export('svg');
     chart4.exporting.export('svg');
};

window.onload = setTimeout(loadFrame, 6000);
                           
                        
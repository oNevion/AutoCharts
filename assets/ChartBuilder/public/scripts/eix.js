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
        width:950px!important;
		height:400px!important;
    }

        #chartdiv2 {
        width:900px!important;
		height:411px!important;
    }

     #chartdiv3 {
        width:950px!important;
    height:500px!important;
    }

    #chartdiv4 {
        width:1330px!important;
    height:460px!important;
    }

`;

// append to DOM
document.head.appendChild(style);




// ################################   CHART 1 EIX 10k Chart (Line) ################################################


// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart1 = am4core.create("chartdiv", am4charts.XYChart);

// Set up data source
chart1.dataSource.url = "../Data/Backups/Catalyst/EIX/EIX_EXPORT_10kChart.csv";
chart1.dataSource.parser = new am4core.CSVParser();
chart1.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart1.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart1.numberFormatter.numberFormat = "'$'#,###.";




// Create axes
var dateAxis = chart1.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "20px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.minGridDistance = 70;
dateAxis.renderer.labels.template.dx = -40;
dateAxis.dateFormats.setKey("month", "MM/yyyy");
dateAxis.periodChangeDateFormats.setKey("month", "MM/yyyy"); 
dateAxis.renderer.labels.template.rotation = -45;
dateAxis.renderer.labels.template.verticalCenter = "middle";
dateAxis.renderer.labels.template.horizontalCenter = "middle";
dateAxis.gridIntervals.setAll([
  { timeUnit: "month", count: 1 },
  { timeUnit: "month", count: 2 }
]);


var valueAxis = chart1.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "20px";

valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart1.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "EIXIX";
series1.dataFields.dateX = "Date";
series1.name = "EIXIX";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.stroke = am4core.color("#08da94");

var series2 = chart1.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "Barclays U.S. Agg. Bond TR Index";
series2.dataFields.dateX = "Date";
series2.name = "Barclays U.S. Agg. Bond TR Index";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.stroke = am4core.color("#2d7abf");

// Add legend
chart1.legend = new am4charts.Legend();
chart1.legend.labels.template.fontSize = "20px";
chart1.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";
chart1.legend.labels.template.minWidth = 150;
chart1.legend.labels.template.truncate = false;



// Export this stuff
chart1.exporting.menu = new am4core.ExportMenu();
chart1.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart1.exporting.filePrefix = "EIX_10k";


// ################################ CHART 2 EIX Portfolio Allocation (Pie) ################################################

// Create chart instance
var chart2 = am4core.create("chartdiv2", am4charts.PieChart);
chart2.innerRadius = am4core.percent(40);
am4core.options.autoSetClassName = true;

// Set up data source
chart2.dataSource.url = "../Data/Backups/Catalyst/EIX/EIX_EXPORT_PortfolioAllocation.csv";
chart2.dataSource.parser = new am4core.CSVParser();
chart2.dataSource.parser.options.useColumnNames = true;




// Add series
var series2 = chart2.series.push(new am4charts.PieSeries());
series2.dataFields.value = "Inner-Value";
series2.dataFields.category = "Inner-Label";
series2.slices.template.stroke = am4core.color("#ffffff");
series2.slices.template.strokeWidth = 2;
series2.slices.template.strokeOpacity = 1;
series2.labels.template.disabled = true;
series2.ticks.template.disabled = true;
series2.slices.template.tooltipText = "";
series2.colors.list = [
    am4core.color("#08da94"),
    am4core.color("#61328d"),
    am4core.color("#26003d"),
    am4core.color("#2d7abf"),
];

// Add series
var series = chart2.series.push(new am4charts.PieSeries());
series.dataFields.value = "Outer-Value";
series.dataFields.category = "Outer-Label";
series.slices.template.stroke = am4core.color("#ffffff");
series.slices.template.strokeWidth = 2;
series.slices.template.strokeOpacity = 1;
series.labels.template.disabled = true;
series.ticks.template.disabled = true;
series.slices.template.tooltipText = "";
series.colors.list = [
    am4core.color("#133b59"),
        am4core.color("#0e996b"),

    am4core.color("#78bcfa"),

    am4core.color("#2d7abf"),
];


// Add legend
chart2.legend = new am4charts.Legend();
chart2.legend.position = "left";
chart2.legend.maxWidth = undefined;
chart2.legend.maxheight = 400;
chart2.legend.valueLabels.template.align = "right";
chart2.legend.valueLabels.template.textAlign = "end";
chart2.legend.labels.template.minWidth = 300;
chart2.legend.valueLabels.template.text = "{value.value.formatNumber('#.0')}%";
chart2.legend.labels.template.truncate = false;


// Export this stuff
chart2.exporting.menu = new am4core.ExportMenu();
chart2.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart2.exporting.filePrefix = "EIX_PortfolioAllocation";


// ################################ CHART 3 EIX Institutional 10k Chart (Line) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart3 = am4core.create("chartdiv3", am4charts.XYChart);

// Set up data source
chart3.dataSource.url = "../Data/Backups/Catalyst/EIX/EIX_I_GrowthOf10k.csv";
chart3.dataSource.parser = new am4core.CSVParser();
chart3.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart3.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart3.numberFormatter.numberFormat = "'$'#,###.";




// Create axes
var dateAxis = chart3.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "20px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.labels.template.location = 0;
dateAxis.renderer.minGridDistance = 30;
dateAxis.renderer.labels.template.rotation = -60;
dateAxis.renderer.labels.template.verticalCenter = "middle";
dateAxis.renderer.labels.template.horizontalCenter = "right";
dateAxis.dateFormats.setKey("month", "MM/yyyy");
dateAxis.periodChangeDateFormats.setKey("month", "MM/yyyy"); 

dateAxis.gridIntervals.setAll([
  { timeUnit: "month", count: 1 },
  { timeUnit: "month", count: 2 }
]);


var valueAxis = chart3.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "20px";

valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart3.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "Wickapogue Structured Credit Fund";
series1.dataFields.dateX = "Date";
series1.name = "Wickapogue Structured Credit Fund";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.stroke = am4core.color("#08da94");

var series2 = chart3.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "Barclays U.S. Agg. Bond TR Index";
series2.dataFields.dateX = "Date";
series2.name = "Barclays U.S. Agg. Bond TR Index";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.stroke = am4core.color("#2d7abf");

// Add legend
chart3.legend = new am4charts.Legend();
chart3.legend.labels.template.fontSize = "20px";
chart3.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";
chart3.legend.labels.template.minWidth = 190;
chart3.legend.labels.template.truncate = false;



// Export this stuff
chart3.exporting.menu = new am4core.ExportMenu();
chart3.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart3.exporting.filePrefix = "EIX_I_10k";


// ################################ CHART 4 EIX Presentation - Income Asset Class (Bar) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart4 = am4core.create("chartdiv4", am4charts.XYChart);

// Add percent sign to all numbers
chart4.numberFormatter.numberFormat = "#.#'%'";

// Set up data source
chart4.dataSource.url = "../Data/Backups/Catalyst/EIX/EIX_PRES_IncomeAssetClassBar.csv";
chart4.dataSource.parser = new am4core.CSVParser();
chart4.dataSource.parser.options.useColumnNames = true;

// Create axes
var categoryAxis = chart4.xAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "Label";
categoryAxis.renderer.labels.template.fontWeight = "Bold";
categoryAxis.renderer.labels.template.fontSize = "23px";
categoryAxis.renderer.grid.template.disabled = false;
categoryAxis.renderer.grid.template.location = 0;
categoryAxis.renderer.minGridDistance = 30;
categoryAxis.renderer.cellStartLocation = 0.1;
categoryAxis.renderer.cellEndLocation = 0.9;
categoryAxis.renderer.grid.template.strokeOpacity = .2;

var valueAxis = chart4.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.grid.template.disabled = true;
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "23px";



// Create series
var series = chart4.series.push(new am4charts.ColumnSeries());
series.dataFields.valueY = "Senior Legacy RMBS Index";
series.dataFields.categoryX = "Label";
series.name = "Senior Legacy RMBS Index";
series.clustered = true;
series.fill = am4core.color("#61328d");
series.strokeWidth = 0;
series.columns.template.width = am4core.percent(100);



var series2 = chart4.series.push(new am4charts.ColumnSeries());
series2.dataFields.valueY = "Agency MBS";
series2.dataFields.categoryX = "Label";
series2.name = "Agency MBS";
series2.clustered = true;
series2.fill = am4core.color("#0069c8");
series2.strokeWidth = 0;
series2.columns.template.width = am4core.percent(100);


var series3 = chart4.series.push(new am4charts.ColumnSeries());
series3.dataFields.valueY = "High Yield Bond Index";
series3.dataFields.categoryX = "Label";
series3.name = "High Yield Bond Index";
series3.clustered = true;
series3.fill = am4core.color("#0096d9");
series3.strokeWidth = 0;
series3.columns.template.width = am4core.percent(100);


var series4 = chart4.series.push(new am4charts.ColumnSeries());
series4.dataFields.valueY = "Aggregate Bond Index";
series4.dataFields.categoryX = "Label";
series4.name = "Aggregate Bond Index";
series4.clustered = true;
series4.fill = am4core.color("#00bbc1");
series4.strokeWidth = 0;
series4.columns.template.width = am4core.percent(100);

var series5 = chart4.series.push(new am4charts.ColumnSeries());
series5.dataFields.valueY = "Municipal Bond Index";
series5.dataFields.categoryX = "Label";
series5.name = "Municipal Bond Index";
series5.clustered = true;
series5.fill = am4core.color("#08da94");
series5.strokeWidth = 0;
series5.columns.template.width = am4core.percent(100);

// Add legend
chart4.legend = new am4charts.Legend();
chart4.legend.labels.template.fontSize = "23px";
chart4.legend.labels.template.truncate = false;


// Export this stuff
chart4.exporting.menu = new am4core.ExportMenu();
chart4.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart4.exporting.filePrefix = "EIX_PRES_IncomeAssetClassBar";


// ################################   Export any charts OTHER THAN chart1 ################################################

function loadFrame() {
     chart1.exporting.export('svg');
     chart2.exporting.export('svg');
     chart3.exporting.export('svg');
     chart4.exporting.export('svg');
};

window.onload = setTimeout(loadFrame, 1800);
                           
                        
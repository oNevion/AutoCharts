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
		height:560px!important;
    }

     #chartdiv3 {
        width:1200px!important;
    height:500px!important;
    }

     #chartdiv4 {
        width:1190px!important;
    height:591px!important;
    }

     #chartdiv5 {
        width:950px!important;
    height:550px!important;
    } 

    #chartdiv6 {
        width:950px!important;
    height:550px!important;
    }

    #chartdiv7 {
        width:1200px!important;
    height:450px!important;
    }

    #chartdiv8 {
        width:600px!important;
    height:450px!important;
    }

    #chartdiv9 {
        width:600px!important;
    height:450px!important;
    }

    #chartdiv10 {
        width:1200px!important;
    height:800px!important;
    }

    #chartdiv11 {
        width:1500px!important;
    height:950px!important;
    }

`;

// append to DOM
document.head.appendChild(style);




// ################################   CHART 1 RDM - Growth of 10k (Line) ################################################


// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart1 = am4core.create("chartdiv", am4charts.XYChart);

// Set up data source
chart1.dataSource.url = "../Data/Backups/Rational/RDM/RDM_EXPORT_10k.csv";
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
dateAxis.renderer.minLabelPosition = -0.05;

dateAxis.gridIntervals.setAll([
  { timeUnit: "month", count: 1 },
  { timeUnit: "month", count: 3 }
]);




var valueAxis = chart1.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "24px";
valueAxis.renderer.minGridDistance = 60;
valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart1.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "RDMIX";
series1.dataFields.dateX = "Date";
series1.name = "RDMIX";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.93;
series1.stroke = am4core.color("#08da94");

var series2 = chart1.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "BarclayHedge CTA Index";
series2.dataFields.dateX = "Date";
series2.name = "BarclayHedge CTA Index";
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
chart1.exporting.filePrefix = "RDM_10k";

// ################################ CHART 3 RDM - Volatility Chart ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart3 = am4core.create("chartdiv3", am4charts.XYChart);

// Set up data source
chart3.dataSource.url = "../Data/Backups/Rational/RDM/RDM_EXPORT_VolatilityChart.csv";
chart3.dataSource.parser = new am4core.CSVParser();
chart3.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart3.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart3.numberFormatter.numberFormat = "#,###.0'%'";

// Create axes
var dateAxis = chart3.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "24px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.minGridDistance = 60;
dateAxis.renderer.labels.template.dx = -54;
dateAxis.renderer.labels.template.location = 1;
dateAxis.renderer.labels.template.rotation = -45;
dateAxis.renderer.labels.template.verticalCenter = "middle";
dateAxis.renderer.labels.template.horizontalCenter = "left";
dateAxis.dateFormats.setKey("month", "MM/yyyy");
dateAxis.periodChangeDateFormats.setKey("month", "MM/yyyy"); 

var valueAxis = chart3.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "24px";
valueAxis.renderer.minGridDistance = 60;
valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "#,###.0'%'";

// Create series
var series1 = chart3.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "Rational/ReSolve Adaptive Asset Allocation Fund";
series1.dataFields.dateX = "Date";
series1.name = "Rational/ReSolve Adaptive Asset Allocation Fund";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.93;
series1.stroke = am4core.color("#08da94");

var series2 = chart3.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "MSCI All Country World Index";
series2.dataFields.dateX = "Date";
series2.name = "MSCI All Country World Index";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.tensionX = 0.93;
series2.stroke = am4core.color("#025268");

// Add legend
chart3.legend = new am4charts.Legend();
chart3.legend.labels.template.fontSize = "24px";
chart3.legend.labels.template.truncate = false;
chart3.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";

// Export this stuff
chart3.exporting.menu = new am4core.ExportMenu();
chart3.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart3.exporting.filePrefix = "RDM_Volatility";


// ################################ CHART 4 RDM - Strategy Highlights (Pie) ################################################

// Create chart instance
var chart4 = am4core.create("chartdiv4", am4charts.PieChart);
chart4.innerRadius = am4core.percent(40);

// Set up data source
chart4.dataSource.url = "../Data/Backups/Rational/RDM/RDM_EXPORT_StrategyHighlights.csv";
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
  am4core.color("#08da94"),
  am4core.color("#17c68c"),
  am4core.color("#1db184"),
  am4core.color("#209e7d"),
  am4core.color("#218b75"),
  am4core.color("#20786d"),
  am4core.color("#1e6565"),
  am4core.color("#1a545d"),
  am4core.color("#154255"),
  am4core.color("#0d324d"),

];
series.legendSettings.valueText = "{value.formatNumber('#.00%')}";


// Create initial animation
series.hiddenState.properties.opacity = 1;
series.hiddenState.properties.endAngle = -90;
series.hiddenState.properties.startAngle = -90;


// Add legend
chart4.legend = new am4charts.Legend();
chart4.legend.position = "right";
chart4.legend.maxWidth = undefined;
chart4.legend.maxheight = 500;
chart4.legend.valueLabels.template.align = "right";
chart4.legend.valueLabels.template.textAlign = "end";  
chart4.legend.labels.template.minWidth = 200;
chart4.legend.labels.template.truncate = false;
chart4.legend.scale = 1.4;
chart4.legend.marginTop = "40";
chart4.legend.itemContainers.template.paddingTop = 5;
chart4.legend.itemContainers.template.paddingBottom = 5;


// Export this stuff
chart4.exporting.menu = new am4core.ExportMenu();
chart4.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart4.exporting.filePrefix = "RDM_StrategyHighlights";



// ################################ CHART 5 RDM Long & Short 1/2 (Bar) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart5 = am4core.create("chartdiv5", am4charts.XYChart);

// Add percent sign to all numbers
chart5.numberFormatter.numberFormat = "#.#'%'";

// Set up data source
chart5.dataSource.url = "../Data/Backups/Rational/RDM/RDM_EXPORT_Top_5_Long_n_Short.csv";
chart5.dataSource.parser = new am4core.CSVParser();
chart5.dataSource.parser.options.useColumnNames = true;

// Create axes
var categoryAxis = chart5.yAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "Position";
categoryAxis.renderer.labels.template.fontWeight = "Bold";
categoryAxis.renderer.labels.template.fontSize = "25px";
categoryAxis.renderer.grid.template.disabled = false;
categoryAxis.renderer.grid.template.disabled = false;
categoryAxis.renderer.grid.template.location = 0;
categoryAxis.renderer.minGridDistance = 30;
categoryAxis.renderer.cellStartLocation = 0.1;
categoryAxis.renderer.cellEndLocation = 0.9;
categoryAxis.renderer.grid.template.strokeOpacity = .2;
categoryAxis.renderer.labels.template.textAlign = "left";

var label = categoryAxis.renderer.labels.template;
label.wrap = true;
label.maxWidth = 250;


var valueAxis = chart5.xAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.grid.template.disabled = true;
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "25px";
valueAxis.renderer.grid.template.location = 1;
valueAxis.renderer.labels.template.dx = -10;

// Create series
var series = chart5.series.push(new am4charts.ColumnSeries());
series.dataFields.valueX = "Risk-Weighted Allocation";
series.dataFields.categoryY = "Position";
series.name = "Top 5 Long Positions (Risk-Weighted)";
series.clustered = false;
series.fill = am4core.color("#08da94");
series.strokeWidth = 0;
series.columns.template.width = am4core.percent(100);

// Add legend
chart5.legend = new am4charts.Legend();
chart5.legend.labels.template.fontSize = "30px";
chart5.legend.labels.template.truncate = false;
chart5.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";
//chart5.legend.itemContainers.template.marginTop = -15;

// Export this stuff
chart5.exporting.menu = new am4core.ExportMenu();
chart5.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart5.exporting.filePrefix = "RDM_Long&Short1";


// ################################ CHART 6 RDM Long & Short 2/2 (Bar) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart6 = am4core.create("chartdiv6", am4charts.XYChart);

// Add percent sign to all numbers
chart6.numberFormatter.numberFormat = "#.##'%'";

// Set up data source
chart6.dataSource.url = "../Data/Backups/Rational/RDM/RDM_EXPORT_Top_5_Long_n_Short.csv";
chart6.dataSource.parser = new am4core.CSVParser();
chart6.dataSource.parser.options.useColumnNames = true;

// Create axes
var categoryAxis = chart6.yAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "Position2";
categoryAxis.renderer.labels.template.fontWeight = "Bold";
categoryAxis.renderer.labels.template.fontSize = "25px";
categoryAxis.renderer.grid.template.disabled = false;
categoryAxis.renderer.grid.template.disabled = false;
categoryAxis.renderer.grid.template.location = 0;
categoryAxis.renderer.minGridDistance = 30;
categoryAxis.renderer.cellStartLocation = 0.1;
categoryAxis.renderer.cellEndLocation = 0.9;
categoryAxis.renderer.grid.template.strokeOpacity = .2;
categoryAxis.renderer.labels.template.textAlign = "left";

var label = categoryAxis.renderer.labels.template;
label.wrap = true;
label.maxWidth = 250;


var valueAxis = chart6.xAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.grid.template.disabled = true;
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "25px";
valueAxis.renderer.grid.template.location = 1;
valueAxis.renderer.labels.template.dx = -25;

// Create series
var series = chart6.series.push(new am4charts.ColumnSeries());
series.dataFields.valueX = "Risk-Weighted Allocation2";
series.dataFields.categoryY = "Position2";
series.name = "Bottom 5 Short Positions (Risk-Weighted)";
series.clustered = true;
series.fill = am4core.color("#025268");
series.strokeWidth = 0;
series.columns.template.width = am4core.percent(100);

// Add legend
chart6.legend = new am4charts.Legend();
chart6.legend.labels.template.fontSize = "30px";
chart6.legend.labels.template.truncate = false;
chart6.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";
//chart6.legend.itemContainers.template.marginTop = -15;

// Export this stuff
chart6.exporting.menu = new am4core.ExportMenu();
chart6.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart6.exporting.filePrefix = "RDM_Long&Short2";


// ################################ CHART 7 RDM Brochure - Macro Vs. Equities (Line) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart7 = am4core.create("chartdiv7", am4charts.XYChart);

// Set up data source
chart7.dataSource.url = "../Data/Backups/Rational/RDM/RDM_BROCHURE_EXPORT_MacroVsEqui.csv";
chart7.dataSource.parser = new am4core.CSVParser();
chart7.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart7.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart7.numberFormatter.numberFormat = "'$'#,###.";

// Create axes
var dateAxis = chart7.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "24px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.minGridDistance = 20;
dateAxis.renderer.maxLabelPosition = 1.001;
dateAxis.renderer.labels.template.location = 0;
dateAxis.renderer.labels.template.rotation = -60;
dateAxis.renderer.labels.template.verticalCenter = "middle";
dateAxis.renderer.labels.template.horizontalCenter = "right";

var valueAxis = chart7.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "24px";
valueAxis.renderer.minGridDistance = 40;
valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart7.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "MSCI All Country World Index";
series1.dataFields.dateX = "Date";
series1.name = "MSCI All Country World Index";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.93;
series1.stroke = am4core.color("#08da94");

var series2 = chart7.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "HFRI Macro Systematic Diversified Index";
series2.dataFields.dateX = "Date";
series2.name = "HFRI Macro Systematic Diversified Index";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.tensionX = 0.93;
series2.stroke = am4core.color("#025268");

// Add legend
chart7.legend = new am4charts.Legend();
chart7.legend.labels.template.fontSize = "24px";
chart7.legend.labels.template.truncate = false;
chart7.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";
chart7.legend.itemContainers.template.marginTop = -15;

// Export this stuff
chart7.exporting.menu = new am4core.ExportMenu();
chart7.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart7.exporting.filePrefix = "RDM_Brochure_MacroVsEquities";


// ################################ CHART 8 RDM Brochure - Risk Parity vs. Equities (Line) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart8 = am4core.create("chartdiv8", am4charts.XYChart);

// Set up data source
chart8.dataSource.url = "../Data/Backups/Rational/RDM/RDM_BROCHURE_EXPORT_ParityVsEqu.csv";
chart8.dataSource.parser = new am4core.CSVParser();
chart8.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart8.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart8.numberFormatter.numberFormat = "'$'#,###.";

// Create axes
var dateAxis = chart8.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "20px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.minGridDistance = 40;
dateAxis.renderer.labels.template.location = 0;
dateAxis.renderer.labels.template.rotation = -60;
dateAxis.renderer.labels.template.verticalCenter = "middle";
dateAxis.renderer.labels.template.horizontalCenter = "right";
dateAxis.renderer.maxLabelPosition = 1.05;

var valueAxis = chart8.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "20px";
valueAxis.renderer.minGridDistance = 40;
valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart8.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "MSCI All Country World Index";
series1.dataFields.dateX = "Date";
series1.name = "MSCI All Country World Index";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.93;
series1.stroke = am4core.color("#08da94");

var series2 = chart8.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "S&P Risk Parity Index";
series2.dataFields.dateX = "Date";
series2.name = "S&P Risk Parity Index";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.tensionX = 0.93;
series2.stroke = am4core.color("#025268");

// Add legend
chart8.legend = new am4charts.Legend();
chart8.legend.labels.template.fontSize = "20px";
chart8.legend.labels.template.truncate = false;
chart8.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";
chart8.legend.itemContainers.template.marginTop = -15;

// Export this stuff
chart8.exporting.menu = new am4core.ExportMenu();
chart8.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart8.exporting.filePrefix = "RDM_Brochure_RiskParityVsEquities";


// ################################ CHART 9 RDM Brochure - Long Volatility vs. Equities (Line) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart9 = am4core.create("chartdiv9", am4charts.XYChart);

// Set up data source
chart9.dataSource.url = "../Data/Backups/Rational/RDM/RDM_BROCHURE_EXPORT_VolVsEquiti.csv";
chart9.dataSource.parser = new am4core.CSVParser();
chart9.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart9.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart9.numberFormatter.numberFormat = "'$'#,###.";

// Create axes
var dateAxis = chart9.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "20px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.minGridDistance = 40;
dateAxis.renderer.labels.template.location = 0;
dateAxis.renderer.labels.template.rotation = -60;
dateAxis.renderer.labels.template.verticalCenter = "middle";
dateAxis.renderer.labels.template.horizontalCenter = "right";
dateAxis.renderer.maxLabelPosition = 1.05;

var valueAxis = chart9.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "20px";
valueAxis.renderer.minGridDistance = 40;
valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart9.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "MSCI All Country World Index";
series1.dataFields.dateX = "Date";
series1.name = "MSCI All Country World Index";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.93;
series1.stroke = am4core.color("#08da94");

var series2 = chart9.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "CBOE Eurekahedge Long Volatility HF Index";
series2.dataFields.dateX = "Date";
series2.name = "CBOE Eurekahedge Long Volatility HF Index";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.tensionX = 0.93;
series2.stroke = am4core.color("#025268");

// Add legend
chart9.legend = new am4charts.Legend();
chart9.legend.labels.template.fontSize = "20px";
chart9.legend.labels.template.truncate = true;
chart9.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";
chart9.legend.itemContainers.template.marginTop = -15;

// Export this stuff
chart9.exporting.menu = new am4core.ExportMenu();
chart9.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart9.exporting.filePrefix = "RDM_Brochure_LongVolatilityVsEquities";


// ################################ CHART 10 RDM Brochure - 3 Styles vs. Global Equities (Line) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart10 = am4core.create("chartdiv10", am4charts.XYChart);

// Set up data source
chart10.dataSource.url = "../Data/Backups/Rational/RDM/RDM_BROCHURE_EXPORT_3StylesVsEq.csv";
chart10.dataSource.parser = new am4core.CSVParser();
chart10.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart10.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart10.numberFormatter.numberFormat = "'$'#,###.";

// Create axes
var dateAxis = chart10.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "24px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.minGridDistance = 40;
dateAxis.renderer.labels.template.location = 0;
dateAxis.renderer.labels.template.rotation = -60;
dateAxis.renderer.labels.template.verticalCenter = "middle";
dateAxis.renderer.labels.template.horizontalCenter = "right";
dateAxis.dateFormats.setKey("month", "MM/yyyy");
dateAxis.periodChangeDateFormats.setKey("month", "MM/yyyy"); 
dateAxis.renderer.maxLabelPosition = 1.001;

var valueAxis = chart10.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "24px";
valueAxis.renderer.minGridDistance = 40;
valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart10.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "MSCI All Country World Index";
series1.dataFields.dateX = "Date";
series1.name = "MSCI All Country World Index";
series1.strokeWidth = 6;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.93;
series1.stroke = am4core.color("#6aabdd");

var series2 = chart10.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "CBOE Eurekahedge Long Volatility Hedge Fund Index";
series2.dataFields.dateX = "Date";
series2.name = "CBOE Eurekahedge Long Volatility Hedge Fund Index";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.tensionX = 0.93;
series2.stroke = am4core.color("#c02026");

var series3 = chart10.series.push(new am4charts.LineSeries());
series3.dataFields.valueY = "HFRI Macro Systematic Diversified Index";
series3.dataFields.dateX = "Date";
series3.name = "HFRI Macro Systematic Diversified Index";
series3.strokeWidth = 3;
series3.tooltipText = "{valueY}";
series3.tensionX = 0.93;
series3.stroke = am4core.color("#08DA94");

var series4 = chart10.series.push(new am4charts.LineSeries());
series4.dataFields.valueY = "S&P Risk Parity Index";
series4.dataFields.dateX = "Date";
series4.name = "S&P Risk Parity Index - 8% Target Volatility";
series4.strokeWidth = 3;
series4.tooltipText = "{valueY}";
series4.tensionX = 0.93;
series4.stroke = am4core.color("#091829");

// Add legend
chart10.legend = new am4charts.Legend();
chart10.legend.labels.template.fontSize = "23px";
chart10.legend.labels.template.truncate = false;
chart10.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";
chart10.legend.itemContainers.template.marginTop = -15;

// Export this stuff
chart10.exporting.menu = new am4core.ExportMenu();
chart10.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart10.exporting.filePrefix = "RDM_Brochure_3StylesVsEquities";


// ################################ CHART 11 RDM Brochure - 15 Worst Quarters for Equities ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart11 = am4core.create("chartdiv11", am4charts.XYChart);

// Add percent sign to all numbers
chart11.numberFormatter.numberFormat = "#.#'%'";

// Set up data source
chart11.dataSource.url = "../Data/Backups/Rational/RDM/RDM_BROCHURE_15WorstQuarters.csv";
chart11.dataSource.parser = new am4core.CSVParser();
chart11.dataSource.parser.options.useColumnNames = true;

// Create axes
var categoryAxis = chart11.xAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "Quarter";
categoryAxis.renderer.labels.template.fontWeight = "Bold";
categoryAxis.renderer.grid.template.disabled = false;
categoryAxis.renderer.grid.template.location = 0;
categoryAxis.renderer.minGridDistance = 30;
categoryAxis.renderer.labels.template.fontSize = "20px";
categoryAxis.renderer.cellStartLocation = 0.1;
categoryAxis.renderer.cellEndLocation = 0.9;
categoryAxis.renderer.grid.template.strokeOpacity = .2;



var valueAxis = chart11.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.grid.template.disabled = true;
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "25px";




// Create series
var series = chart11.series.push(new am4charts.ColumnSeries());
series.dataFields.valueY = "US Equities";
series.dataFields.categoryX = "Quarter";
series.name = "US Equities";
series.clustered = true;
series.fill = am4core.color("#08da94");
series.strokeWidth = 0;
series.columns.template.width = am4core.percent(100);

var series2 = chart11.series.push(new am4charts.ColumnSeries());
series2.dataFields.valueY = "S&P Risk Parity Index - 8% Volatility";
series2.dataFields.categoryX = "Quarter";
series2.name = "S&P Risk Parity Index - 8% Volatility";
series2.clustered = true;
series2.fill = am4core.color("#2d7abf");
series2.strokeWidth = 0;
series2.columns.template.width = am4core.percent(100);

var series3 = chart11.series.push(new am4charts.ColumnSeries());
series3.dataFields.valueY = "HFRI Macro  Systematic Diversified Index";
series3.dataFields.categoryX = "Quarter";
series3.name = "HFRI Macro  Systematic Diversified Index";
series3.clustered = true;
series3.fill = am4core.color("#444444");
series3.strokeWidth = 0;
series3.columns.template.width = am4core.percent(100);

var series4 = chart11.series.push(new am4charts.ColumnSeries());
series4.dataFields.valueY = "CBOE Eurekahedge Long Volatility Hedge Fund Index";
series4.dataFields.categoryX = "Quarter";
series4.name = "CBOE Eurekahedge Long Volatility Hedge Fund Index";
series4.clustered = true;
series4.fill = am4core.color("#0d345e");
series4.strokeWidth = 0;
series4.columns.template.width = am4core.percent(100);

// Add legend
chart11.legend = new am4charts.Legend();
chart11.legend.labels.template.fontSize = "26px";
chart11.legend.labels.template.truncate = false;
chart11.legend.labels.template.text = "{name}[/] [bold {color}]";

// Export this stuff
chart11.exporting.menu = new am4core.ExportMenu();
chart11.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart11.exporting.filePrefix = "RDM_Brochure_Export_15WorstQuarters";


// ################################   Export any charts OTHER THAN chart1 ################################################

window.onload = setTimeout(loadFrame, 3300);


function loadFrame() {
     chart1.exporting.export('svg');
     chart3.exporting.export('svg');
     chart4.exporting.export('svg');
     chart5.exporting.export('svg');
     chart6.exporting.export('svg');
     chart7.exporting.export('svg');
     chart8.exporting.export('svg');
     chart9.exporting.export('svg');
     chart10.exporting.export('svg');
     chart11.exporting.export('svg');
};                           
                        
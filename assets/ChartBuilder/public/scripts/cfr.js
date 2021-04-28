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
		height:520px!important;
    }

        #chartdiv2 {
        width:950px!important;
		height:520px!important;
    }

     #chartdiv3 {
        width:790px!important;
    height:340px!important;
    }

     #chartdiv4 {
        width:1330px!important;
    height:500px!important;
    }

     #chartdiv5 {
        width:950px!important;
    height:450px!important;
    } 

    #chartdiv6 {
        width:950px!important;
    height:520px!important;
    }

`;

// append to DOM
document.head.appendChild(style);




// ################################   CHART 1 CFR 10k Chart (Line) ################################################


// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart1 = am4core.create("chartdiv", am4charts.XYChart);

// Set up data source
chart1.dataSource.url = "../Data/Backups/Catalyst/CFR/CFR_EXPORT_GrowthOf10k.csv";
chart1.dataSource.parser = new am4core.CSVParser();
chart1.dataSource.parser.options.useColumnNames = true;
chart1.exporting.useWebFonts = false;



// Set input format for the dates
chart1.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart1.numberFormatter.numberFormat = "'$'#,###.";




// Create axes
var dateAxis = chart1.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "20px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.labels.template.dy = 10;
dateAxis.renderer.minGridDistance = 60;
dateAxis.renderer.labels.template.location = 0;
dateAxis.extraMax = 0.04; 
dateAxis.renderer.minLabelPosition = -0.1;


var valueAxis = chart1.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "20px";

valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart1.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "CFRIX";
series1.dataFields.dateX = "Date";
series1.name = "CFRIX";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.93;
series1.stroke = am4core.color("#08da94");

var series2 = chart1.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "S&P LSTA Lvg. Loan 100";
series2.dataFields.dateX = "Date";
series2.name = "S&P LSTA Levg. Loan 100 TR Index";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.tensionX = 0.93;
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
chart1.exporting.filePrefix = "CFR_10k";


// ################################ CHART 2 CFR Brochure LSTAvsAGG Chart (Line) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart2 = am4core.create("chartdiv2", am4charts.XYChart);

// Set up data source
chart2.dataSource.url = "../Data/Backups/Catalyst/CFR/CFR_BROCHURE_LSTAvsAGG.csv";
chart2.dataSource.parser = new am4core.CSVParser();
chart2.dataSource.parser.options.useColumnNames = true;
chart2.exporting.useWebFonts = false;



// Set input format for the dates
chart2.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart2.numberFormatter.numberFormat = "'$'#,###.";




// Create axes
var dateAxis = chart2.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "20px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.labels.template.dy = 10;
dateAxis.renderer.minGridDistance = 60;
dateAxis.renderer.labels.template.location = 1;
dateAxis.renderer.labels.template.location = 0;
dateAxis.extraMax = 0.04; 
dateAxis.renderer.minLabelPosition = -0.1;

var valueAxis = chart2.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "20px";

valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart2.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "LSTA";
series1.dataFields.dateX = "Date";
series1.name = "S&P LSTA Lvg. Loan 100";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.93;
series1.stroke = am4core.color("#08da94");

var series2 = chart2.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "AGG";
series2.dataFields.dateX = "Date";
series2.name = "Barclays Agg";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.tensionX = 0.93;
series2.stroke = am4core.color("#2d7abf");

// Add legend
chart2.legend = new am4charts.Legend();
chart2.legend.labels.template.fontSize = "20px";
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
chart2.exporting.filePrefix = "CFR_Brochure_LSTAvsAGG";


// ################################ CHART 3 CFR Institutional 10k Chart (Line) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart3 = am4core.create("chartdiv3", am4charts.XYChart);

// Set up data source
chart3.dataSource.url = "../Data/Backups/Catalyst/CFR/CFR_I_GrowthOf10k.csv";
chart3.dataSource.parser = new am4core.CSVParser();
chart3.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart3.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart3.numberFormatter.numberFormat = "'$'#,###.";




// Create axes
var dateAxis = chart3.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "16px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.minGridDistance = 63;
dateAxis.renderer.labels.template.dy = 10;
dateAxis.renderer.minGridDistance = 60;
dateAxis.renderer.labels.template.location = 0;
dateAxis.extraMax = 0.04; 
dateAxis.renderer.minLabelPosition = -0.1;



var valueAxis = chart3.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "16px";

valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart3.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "CIFC Composite";
series1.dataFields.dateX = "Date";
series1.name = "CIFC Composite";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.93;
series1.stroke = am4core.color("#08da94");
series1.legendSettings.labelText = "{name}[/]";
series1.legendSettings.valueText = "[bold {color}]{valueY.close}";

var series2 = chart3.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "LSTA Leveraged Loan 100 TR Index";
series2.dataFields.dateX = "Date";
series2.name = "LSTA Leveraged Loan 100 TR Index";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.tensionX = 0.93;
series2.stroke = am4core.color("#2d7abf");
series2.legendSettings.labelText = "{name}[/]";
series2.legendSettings.valueText = "[bold {color}]{valueY.close}";

// Add legend
chart3.legend = new am4charts.Legend();
chart3.legend.labels.template.truncate = false;


// Export this stuff
chart3.exporting.menu = new am4core.ExportMenu();
chart3.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart3.exporting.filePrefix = "CFR_I_10k";


// ################################ CHART 4 CFR Case Study - Floating Rate Loans ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart4 = am4core.create("chartdiv4", am4charts.XYChart);

// Set up data source
chart4.dataSource.url = "../Data/Backups/Catalyst/CFR/CFR_CaseStudy.csv";
chart4.dataSource.parser = new am4core.CSVParser();
chart4.dataSource.parser.options.useColumnNames = true;

// Create axes
var categoryAxis = chart4.xAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "Category";
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
valueAxis.renderer.numberFormatter.numberFormat = "#'%'";



// Create series
var series = chart4.series.push(new am4charts.ColumnSeries());
series.dataFields.valueY = "Floating Rate Loans";
series.dataFields.categoryX = "Category";
series.name = "Floating Rate Loans";
series.clustered = true;
series.fill = am4core.color("#08da94");
series.strokeWidth = 0;
series.columns.template.width = am4core.percent(100);

var series2 = chart4.series.push(new am4charts.ColumnSeries());
series2.dataFields.valueY = "U.S. Aggregate";
series2.dataFields.categoryX = "Category";
series2.name = "U.S. Aggregate";
series2.clustered = true;
series2.fill = am4core.color("#61a8e8");
series2.strokeWidth = 0;
series2.columns.template.width = am4core.percent(100);

var series3 = chart4.series.push(new am4charts.ColumnSeries());
series3.dataFields.valueY = "U.S. Treasury";
series3.dataFields.categoryX = "Category";
series3.name = "U.S. Treasury";
series3.clustered = true;
series3.fill = am4core.color("#26003d");
series3.strokeWidth = 0;
series3.columns.template.width = am4core.percent(100);




// Add legend
chart4.legend = new am4charts.Legend();
chart4.legend.labels.template.fontSize = "30px";
chart4.legend.labels.template.truncate = false;


// Export this stuff
chart4.exporting.menu = new am4core.ExportMenu();
chart4.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart4.exporting.filePrefix = "CFR_CaseStudy";



// ################################ CHART 5 CFR Case Study - Fed Fund Rate ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart5 = am4core.create("chartdiv5", am4charts.XYChart);

// Set up data source
chart5.dataSource.url = "../Data/Backups/Catalyst/CFR/CFR_CS_FedFundsRate.csv";
chart5.dataSource.parser = new am4core.CSVParser();
chart5.dataSource.parser.options.useColumnNames = true;
chart5.exporting.useWebFonts = false;



// Set input format for the dates
chart5.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart5.numberFormatter.numberFormat = "#,###.00'%'";




// Create axes
var dateAxis = chart5.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "20px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.labels.template.dy = 10;
dateAxis.renderer.minGridDistance = 60;
dateAxis.renderer.labels.template.location = 0;
dateAxis.extraMax = 0.04; 
//dateAxis.renderer.minLabelPosition = -0.1;


var valueAxis = chart5.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "20px";

valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "#,###.##'%'";

// Create series
var series1 = chart5.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "Fed Funds Target Rate (%)";
series1.dataFields.dateX = "Date";
series1.name = "Fed Funds Target Rate (%)";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.93;
series1.stroke = am4core.color("#08da94");

// Add legend
chart5.legend = new am4charts.Legend();
chart5.legend.labels.template.fontSize = "20px";
chart5.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";
chart5.legend.labels.template.minWidth = 150;
chart5.legend.labels.template.truncate = false;


// Export this stuff
chart5.exporting.menu = new am4core.ExportMenu();
chart5.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart5.exporting.filePrefix = "CaseStudy-FedFundsRate";


// ################################ CHART 6 CFR Brochure US Yield Curve Chart (Line) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart6 = am4core.create("chartdiv6", am4charts.XYChart);

// Set up data source
chart6.dataSource.url = "../Data/Backups/Catalyst/CFR/CFR_BROCHURE_YieldCurve.csv";
chart6.dataSource.parser = new am4core.CSVParser();
chart6.dataSource.parser.options.useColumnNames = true;
chart6.exporting.useWebFonts = false;
chart6.numberFormatter.numberFormat = "#.0#";

// Create axes
var valueAxis1 = chart6.xAxes.push(new am4charts.ValueAxis());
valueAxis1.renderer.labels.template.fontWeight = "Bold";
valueAxis1.renderer.labels.template.fontSize = "20px";
valueAxis1.renderer.grid.template.disabled = true;
valueAxis1.dataFields.category = "Label";
valueAxis1.numberFormatter = new am4core.NumberFormatter();

var valueAxis = chart6.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "20px";
valueAxis.dataFields.category = "Yield";


// Create series
var series1 = chart6.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "Yield";
series1.dataFields.valueX = "Label";
series1.name = "Current U.S. Yield Curve";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.stroke = am4core.color("#08da94");

let circleBullet = series1.bullets.push(new am4charts.CircleBullet());
circleBullet.circle.stroke = am4core.color("#fff");
circleBullet.circle.fill = am4core.color("#08da94");
circleBullet.circle.strokeWidth = 2;

// Export this stuff
chart6.exporting.menu = new am4core.ExportMenu();
chart6.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart6.exporting.filePrefix = "CFR_Brochure_US_YieldCurve";

// ################################   Export any charts OTHER THAN chart1 ################################################

function loadFrame() {
     chart1.exporting.export('svg');
     chart2.exporting.export('svg');
     chart3.exporting.export('svg');
     chart4.exporting.export('svg');
     chart5.exporting.export('svg');
     chart6.exporting.export('svg');
};

window.onload = setTimeout(loadFrame, 1800);
                           
                        
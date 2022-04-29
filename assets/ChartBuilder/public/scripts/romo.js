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
        width:1100px!important;
		height:535px!important;
    }

        #chartdiv2 {
        width:1200px!important;
		height:640px!important;
    }

`;

// append to DOM
document.head.appendChild(style);




// ################################   CHART 1 ROMO - 10k Chart (Line) ################################################


// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart1 = am4core.create("chartdiv", am4charts.XYChart);

// Set up data source
chart1.dataSource.url = "../Data/Backups/StrategyShares/ROMO/ROMO_EXPORT_GrowthOf10k.csv";
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
dateAxis.renderer.minGridDistance = 50;
dateAxis.renderer.labels.template.location = 0;
dateAxis.dateFormats.setKey("month", "MM/yyyy");
dateAxis.periodChangeDateFormats.setKey("month", "MM/yyyy"); 
dateAxis.startLocation = 0.5;
dateAxis.endLocation = 0.4;
dateAxis.renderer.labels.template.dy = 20;
dateAxis.renderer.labels.template.rotation = -45;
dateAxis.renderer.labels.template.verticalCenter = "middle";
dateAxis.renderer.labels.template.horizontalCenter = "right";
dateAxis.extraMax = 0.04; 

var valueAxis = chart1.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "26px";
valueAxis.renderer.minGridDistance = 60;
valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart1.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "ROMO: NAV";
series1.dataFields.dateX = "Date";
series1.name = "ROMO: NAV";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
//series1.tensionX = 0.93;
series1.stroke = am4core.color("#08da94");

var series2 = chart1.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "ROMO: Market Price";
series2.dataFields.dateX = "Date";
series2.name = "ROMO: Market Price";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
//series2.tensionX = 0.93;
series2.stroke = am4core.color("#025268");

var series3 = chart1.series.push(new am4charts.LineSeries());
series3.dataFields.valueY = "S&P Tarket Risk Growth Index";
series3.dataFields.dateX = "Date";
series3.name = "S&P Tarket Risk Growth Index[baseline-shift: super; font-size: 16;]2";
series3.strokeWidth = 3;
series3.tooltipText = "{valueY}";
//series3.tensionX = 0.93;
series3.stroke = am4core.color("#b7b7bd");

// Add legend
chart1.legend = new am4charts.Legend();
chart1.legend.labels.template.fontSize = "26px";
chart1.legend.labels.template.truncate = false;
chart1.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";
chart1.legend.itemContainers.template.marginTop = 15;


// Export this stuff
chart1.exporting.menu = new am4core.ExportMenu();
chart1.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart1.exporting.filePrefix = "ROMO_10k";



// ################################ CHART 2 ROMO - Institutional 10k Chart (Line) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart2 = am4core.create("chartdiv2", am4charts.XYChart);

// Set up data source
chart2.dataSource.url = "../Data/Backups/StrategyShares/ROMO/ROMO_I_EXPORT_10k.csv";
chart2.dataSource.parser = new am4core.CSVParser();
chart2.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart2.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart2.numberFormatter.numberFormat = "'$'#,###.";

// Create axes
var dateAxis = chart2.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "22px";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.minGridDistance = 60;
dateAxis.renderer.labels.template.location = 0;
dateAxis.renderer.labels.template.rotation = -45;
dateAxis.renderer.labels.template.verticalCenter = "middle";
dateAxis.renderer.labels.template.horizontalCenter = "middle";
dateAxis.dateFormats.setKey("month", "MM/yyyy");
dateAxis.periodChangeDateFormats.setKey("month", "MM/yyyy"); 
dateAxis.startLocation = 0.49;
dateAxis.endLocation = 0.4;
dateAxis.renderer.labels.template.dy = 20;
dateAxis.renderer.minLabelPosition = -0.5;
dateAxis.extraMax = 0.01; 
dateAxis.groupData = true;
dateAxis.groupCount = 2000;

var valueAxis = chart2.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "22px";
valueAxis.renderer.minGridDistance = 60;
valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart2.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "Newfound/ReSolve Robust Equity Momentum TR Index";
series1.dataFields.dateX = "Date";
series1.name = "Newfound/ReSolve Robust Equity Momentum TR Index";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
//series1.tensionX = 0.99;
series1.stroke = am4core.color("#08da94");

var series2 = chart2.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "60/40 MSCI ACWI/Bloomberg Agg. Bond Index";
series2.dataFields.dateX = "Date";
series2.name = "60/40 MSCI ACWI/Bloomberg Agg. Bond Index";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
//series2.tensionX = 0.99;
series2.stroke = am4core.color("#025268");

// Add legend
chart2.legend = new am4charts.Legend();
chart2.legend.labels.template.fontSize = "22px";
chart2.legend.labels.template.truncate = false;
chart2.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";
chart2.legend.itemContainers.template.marginTop = 10;

// Export this stuff
chart2.exporting.menu = new am4core.ExportMenu();
chart2.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart2.exporting.filePrefix = "ROMO_I_10k";

// ################################   Export any charts OTHER THAN chart1 ################################################

function loadFrame() {
     chart1.exporting.export('svg');
     chart2.exporting.export('svg');
};

window.onload = setTimeout(loadFrame, 6000);
                           
                        
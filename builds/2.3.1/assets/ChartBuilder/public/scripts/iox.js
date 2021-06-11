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
		height:490px!important;
    }

`;

// append to DOM
document.head.appendChild(style);




// ################################   CHART 1 INS - Annual Return (Bar) ################################################


// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart1 = am4core.create("chartdiv", am4charts.XYChart);

// Add percent sign to all numbers
chart1.numberFormatter.numberFormat = "#.#'%'";

// Set up data source
chart1.dataSource.url = "../Data/Backups/Catalyst/IOX/IOX_EXPORT_10kChart.csv";
chart1.dataSource.parser = new am4core.CSVParser();
chart1.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart1.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart1.numberFormatter.numberFormat = "'$'#,###.";




// Create axes
var dateAxis = chart1.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontSize = "16px";
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.labels.template.location = 0;
dateAxis.renderer.labels.template.rotation = -60;
dateAxis.renderer.labels.template.verticalCenter = "middle";
dateAxis.renderer.labels.template.horizontalCenter = "middle";
dateAxis.dateFormats.setKey("month", "MM/yyyy");
dateAxis.periodChangeDateFormats.setKey("month", "MM/yyyy"); 
dateAxis.extraMax = 0.02; 

dateAxis.gridIntervals.setAll([
  { timeUnit: "month", count: 1 },
  { timeUnit: "month", count: 2 }
]);


var valueAxis = chart1.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "16px";

valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart1.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "IOXIX";
series1.dataFields.dateX = "Date";
series1.name = "IOXIX";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.93;
series1.stroke = am4core.color("#08da94");

var series2 = chart1.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "Bloomberg Barclays US MBS Index";
series2.dataFields.dateX = "Date";
series2.name = "Bloomberg Barclays US MBS Index";
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
chart1.exporting.filePrefix = "IOX_10k";

// ################################   Export any charts OTHER THAN chart1 ################################################

function loadFrame() {
     chart1.exporting.export('svg');
};

window.onload = setTimeout(loadFrame, 1800);
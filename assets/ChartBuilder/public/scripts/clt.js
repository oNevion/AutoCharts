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
        width:1060px!important;
		height:510px!important;
    }

        #chartdiv2 {
        width:540px!important;
		height:280px!important;
    }

`;

// append to DOM
document.head.appendChild(style);




// ################################   CHART 1 CLT 10k Chart (Line) ################################################


// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart1 = am4core.create("chartdiv", am4charts.XYChart);

// Set up data source
chart1.dataSource.url = "../Data/Backups/Catalyst/CLT/CLT_EXPORT_10kChart.csv";
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
dateAxis.renderer.minGridDistance = 60;
dateAxis.extraMax = 0.03; 
dateAxis.renderer.labels.template.dx = -20;



var valueAxis = chart1.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "20px";

valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart1.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "CLTAX";
series1.dataFields.dateX = "Date";
series1.name = "CLTAX";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.tensionX = 0.9;
series1.stroke = am4core.color("#08da94");

var series2 = chart1.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "Lipper";
series2.dataFields.dateX = "Date";
series2.name = "Lipper Flexible Portfolio Funds Index";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.tensionX = 0.9;
series2.stroke = am4core.color("#2d7abf");

// Add legend
chart1.legend = new am4charts.Legend();
chart1.legend.labels.template.fontSize = "20px";
chart1.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";
chart1.legend.labels.template.minWidth = 175;
chart1.legend.labels.template.truncate = false;


// Export this stuff
chart1.exporting.menu = new am4core.ExportMenu();
chart1.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart1.exporting.filePrefix = "CLT_10k";

// ################################   CHART 2 CLT Portfolio Sector (Pie) ################################################


// Create chart instance
var chart2 = am4core.create("chartdiv2", am4charts.PieChart);
chart2.innerRadius = am4core.percent(40);

// Set up data source
chart2.dataSource.url = "../Data/Backups/Catalyst/CLT/CLT_EXPORT_PortSectorAllocation.csv";
chart2.dataSource.parser = new am4core.CSVParser();
chart2.dataSource.parser.options.useColumnNames = true;

// Make the chart fade-in on init
chart2.hiddenState.properties.opacity = 0;

// Add series
var series = chart2.series.push(new am4charts.PieSeries());
series.dataFields.value = "Value";
series.dataFields.category = "Label";
series.slices.template.stroke = am4core.color("#ffffff");
series.slices.template.strokeWidth = 2;
series.slices.template.strokeOpacity = 0;
series.labels.template.disabled = true;
series.ticks.template.disabled = true;
series.slices.template.tooltipText = "";

series.colors.list = [
  am4core.color("#08da94"),
  am4core.color("#2d7abf"),
  am4core.color("#26003d"),
  am4core.color("#61328d"),

];


// Create initial animation
series.hiddenState.properties.opacity = 1;
series.hiddenState.properties.endAngle = -90;
series.hiddenState.properties.startAngle = -90;


// Add legend
chart2.legend = new am4charts.Legend();
chart2.legend.position = "left";
chart2.legend.maxWidth = undefined;
chart2.legend.maxheight = 400;
chart2.legend.labels.template.minWidth = 75;
chart2.legend.valueLabels.template.text = "{value.value.formatNumber('#.00')}%";
chart2.legend.labels.template.truncate = false;



// Export this stuff
chart2.exporting.menu = new am4core.ExportMenu();
chart2.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart2.exporting.filePrefix = "CLT_PortfolioSector";

// ################################   Export any charts OTHER THAN chart1 ################################################

function loadFrame() {
     chart1.exporting.export('svg');
     chart2.exporting.export('svg');
};

window.onload = setTimeout(loadFrame, 1800);
                           

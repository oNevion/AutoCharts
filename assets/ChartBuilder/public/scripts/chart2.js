am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart = am4core.create("chartdiv", am4charts.XYChart);

// Set up data source
chart.dataSource.url = "scripts/GLDB_I_EXPORT_10kChart.csv";
chart.dataSource.parser = new am4core.CSVParser();
chart.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart.numberFormatter.numberFormat = "'$'#,###.";

// Create axes
var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
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
dateAxis.extraMax = 0.06; 
dateAxis.groupData = true;
dateAxis.groupCount = 2000;

var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "22px";
valueAxis.renderer.minGridDistance = 60;
valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "Solactive Gold-Backed Bond Index";
series1.dataFields.dateX = "Date";
series1.name = "Solactive Gold-Backed Bond Index";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
//series1.tensionX = 0.99;
series1.stroke = am4core.color("#08da94");

var series2 = chart.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "Bloomberg Barclays US Corporate TR";
series2.dataFields.dateX = "Date";
series2.name = "Bloomberg Barclays U.S. Corporate TR";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
//series2.tensionX = 0.99;
series2.stroke = am4core.color("#025268");

// Add legend
chart.legend = new am4charts.Legend();
chart.legend.labels.template.fontSize = "22px";
chart.legend.labels.template.truncate = false;
chart.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.close}";
chart.legend.itemContainers.template.marginTop = 10;

// Export this stuff
chart.exporting.menu = new am4core.ExportMenu();
chart.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart.exporting.filePrefix = "GLDB_I_10k";
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
		height:650px!important;
    }

        #chartdiv2 {
        width:950px!important;
		height:650px!important;
    }

    #chartdiv3 {
        width:950px!important;
    height:550px!important;
    }

`;

// append to DOM
document.head.appendChild(style);




// ################################   CHART 1 SHI - Factsheet Graph ################################################


// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart1 = am4core.create("chartdiv", am4charts.XYChart);

// Set up data source
chart1.dataSource.url = "../Data/Backups/Catalyst/SHI/SHI_EXPORT_GraphData.csv";
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
dateAxis.renderer.labels.template.location = 0;
//dateAxis.renderer.minGridDistance = 30;
dateAxis.renderer.labels.template.rotation = -60;
dateAxis.renderer.labels.template.verticalCenter = "middle";
dateAxis.renderer.labels.template.horizontalCenter = "right";
dateAxis.dateFormats.setKey("month", "MM/yyyy");
dateAxis.periodChangeDateFormats.setKey("month", "MM/yyyy"); 
//dateAxis.extraMax = 0.04; 

var valueAxis = chart1.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "24px";
valueAxis.max = 120000; 

valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

var series2 = chart1.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "Rolling Floor";
series2.dataFields.dateX = "Date";
series2.name = "Rolling Floor";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.stroke = am4core.color("#08da94");
series2.fill = am4core.color("#6ee9c0");
series2.fillOpacity = 1;

// Create series
var series1 = chart1.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "Defined Shield";
series1.dataFields.dateX = "Date";
series1.name = "SHIIX";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.stroke = am4core.color("#4472c4");



var series3 = chart1.series.push(new am4charts.LineSeries());
series3.dataFields.valueY = "S&P 500 Index";
series3.dataFields.dateX = "Date";
series3.name = "S&P 500 PR Index";
series3.strokeWidth = 3;
series3.tooltipText = "{valueY}";
series3.stroke = am4core.color("#4d4d4f");



var series4 = chart1.series.push(new am4charts.LineSeries());
series4.dataFields.valueY = "Static Floor";
series4.dataFields.dateX = "Date";
series4.name = "Static Floor";
series4.strokeWidth = 3;
series4.tooltipText = "{valueY}";
series4.stroke = am4core.color("#ff6a5a");
series4.strokeDasharray = "5,5";

// Add legend
chart1.legend = new am4charts.Legend();
chart1.legend.labels.template.fontSize = "19px";
chart1.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.open}";
chart1.legend.labels.template.truncate = false;



// Export this stuff
chart1.exporting.menu = new am4core.ExportMenu();
chart1.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart1.exporting.filePrefix = "SHI_FS_Graph";


// ################################ CHART 2 SHI - Brochure Graph ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart2 = am4core.create("chartdiv2", am4charts.XYChart);

// Set up data source
chart2.dataSource.url = "../Data/Backups/Catalyst/SHI/SHI_EXPORT_GraphData.csv";
chart2.dataSource.parser = new am4core.CSVParser();
chart2.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart2.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart2.numberFormatter.numberFormat = "'$'#,###.";
chart2.seriesContainer.zIndex = -1


// Create axes
var dateAxis = chart2.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "24px";
dateAxis.renderer.grid.template.disabled = true;
//dateAxis.renderer.labels.template.location = .00000001;
dateAxis.renderer.minGridDistance = 40;
dateAxis.renderer.labels.template.rotation = -60;
dateAxis.renderer.labels.template.verticalCenter = "middle";
dateAxis.renderer.labels.template.horizontalCenter = "left";
dateAxis.dateFormats.setKey("month", "MM/yyyy");
dateAxis.periodChangeDateFormats.setKey("month", "MM/yyyy"); 
//dateAxis.extraMax = 0.05; 



var valueAxis = chart2.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "24px";

valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

var series2 = chart2.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "Rolling Floor";
series2.dataFields.dateX = "Date";
series2.name = "Rolling Floor";
series2.strokeWidth = 3;
series2.tooltipText = "{valueY}";
series2.stroke = am4core.color("#08da94");
series2.fill = am4core.color("#6ee9c0");
series2.fillOpacity = 1;

// Create series
var series1 = chart2.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "Defined Shield";
series1.dataFields.dateX = "Date";
series1.name = "SHIIX";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.stroke = am4core.color("#4472c4");

// Add legend
chart2.legend = new am4charts.Legend();
chart2.legend.labels.template.fontSize = "21px";
chart2.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.open}";
chart2.legend.labels.template.truncate = false;



// Export this stuff
chart2.exporting.menu = new am4core.ExportMenu();
chart2.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart2.exporting.filePrefix = "SHI_Brochure_Graph";

dateAxis.renderer.axisFills.template.disabled = false;
dateAxis.renderer.axisFills.template.fill = am4core.color("#4472c4");
dateAxis.renderer.axisFills.template.fillOpacity = 0.1;

dateAxis.fillRule = function(dataItem) {
  let date = new Date(dataItem.value);
  if (date.getMonth() == 3 || date.getMonth() == 4 || date.getMonth() == 5 || date.getMonth() == 5 || date.getMonth() == 6) {
    dataItem.axisFill.visible = true;
  }
  else {
    dataItem.axisFill.visible = false;
  }
}

// ################################   CHART 3 SHI - Flyer Covid Drop Graph ################################################


// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart3 = am4core.create("chartdiv3", am4charts.XYChart);

// Set up data source
chart3.dataSource.url = "../Data/Backups/Catalyst/SHI/SHI_FLYER_CovidDropGraph.csv";
chart3.dataSource.parser = new am4core.CSVParser();
chart3.dataSource.parser.options.useColumnNames = true;

// Set input format for the dates
chart3.dateFormatter.inputDateFormat = "yyyy-MM-dd";
chart3.numberFormatter.numberFormat = "'$'#,###.";

// Create axes
var dateAxis = chart3.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fontWeight = "Bold";
dateAxis.renderer.labels.template.fontSize = "24px";
//dateAxis.renderer.grid.template.disabled = true;
dateAxis.renderer.labels.template.location = 0;
//dateAxis.renderer.minGridDistance = 30;
//dateAxis.renderer.labels.template.rotation = -45;
dateAxis.renderer.labels.template.verticalCenter = "middle";
dateAxis.renderer.labels.template.horizontalCenter = "middle";
dateAxis.dateFormats.setKey("month", "MM/yyyy");
dateAxis.periodChangeDateFormats.setKey("month", "MM/yyyy"); 
dateAxis.renderer.maxLabelPosition = 1.3;
//dateAxis.renderer.minLabelPosition = -0.04;


var valueAxis = chart3.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "24px";

valueAxis.numberFormatter = new am4core.NumberFormatter();
valueAxis.numberFormatter.numberFormat = "'$'#,###";

// Create series
var series1 = chart3.series.push(new am4charts.LineSeries());
series1.dataFields.valueY = "Defined Shield";
series1.dataFields.dateX = "Date";
series1.name = "SHIIX";
series1.strokeWidth = 3;
series1.tooltipText = "{valueY}";
series1.stroke = am4core.color("#4472c4");



var series3 = chart3.series.push(new am4charts.LineSeries());
series3.dataFields.valueY = "S&P";
series3.dataFields.dateX = "Date";
series3.name = "S&P 500 PR Index";
series3.strokeWidth = 3;
series3.tooltipText = "{valueY}";
series3.stroke = am4core.color("#4d4d4f");



var series4 = chart3.series.push(new am4charts.LineSeries());
series4.dataFields.valueY = "Floor";
series4.dataFields.dateX = "Date";
series4.name = "Static Floor - 12.5%";
series4.strokeWidth = 3;
series4.tooltipText = "{valueY}";
series4.stroke = am4core.color("#ff6a5a");
series4.strokeDasharray = "5,5";

// Add legend
chart3.legend = new am4charts.Legend();
chart3.legend.labels.template.fontSize = "22px";
chart3.legend.labels.template.text = "{name}[/] [bold {color}]{valueY.open}";
chart3.legend.labels.template.truncate = false;



// Export this stuff
chart3.exporting.menu = new am4core.ExportMenu();
chart3.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart3.exporting.filePrefix = "SHI_FLYER_CovidDrop";

// ################################   Export any charts OTHER THAN chart1 ################################################

function loadFrame() {
     chart1.exporting.export('svg');
     chart2.exporting.export('svg');
     chart3.exporting.export('svg');
};

window.onload = setTimeout(loadFrame, 1800);
                           
                        
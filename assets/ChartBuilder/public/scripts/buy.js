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
		height:320px!important;
    }

        #chartdiv2 {
        width:800px!important;
		height:400px!important;
    }

`;

// append to DOM
document.head.appendChild(style);




// ################################   CHART 1  BUYIX - Annual Return (Bar) ################################################


// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart1 = am4core.create("chartdiv", am4charts.XYChart);

// Add percent sign to all numbers
chart1.numberFormatter.numberFormat = "#.#'%'";

// Set up data source
chart1.dataSource.url = "../Data/Backups/Catalyst/BUY/BUY_EXPORT_AnnualReturn.csv";
chart1.dataSource.parser = new am4core.CSVParser();
chart1.dataSource.parser.options.useColumnNames = true;

// Create axes
var categoryAxis = chart1.xAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "Date";
categoryAxis.renderer.labels.template.fontWeight = "Bold";
categoryAxis.renderer.grid.template.disabled = false;
categoryAxis.renderer.grid.template.location = 0;
categoryAxis.renderer.minGridDistance = 30;
categoryAxis.renderer.labels.template.fontSize = "25px";
categoryAxis.renderer.cellStartLocation = 0.1;
categoryAxis.renderer.cellEndLocation = 0.9;
categoryAxis.renderer.grid.template.strokeOpacity = .2;



var valueAxis = chart1.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.grid.template.disabled = true;
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "25px";




// Create series
var series = chart1.series.push(new am4charts.ColumnSeries());
series.dataFields.valueY = "Portfolio";
series.dataFields.categoryX = "Date";
series.name = "BUYIX";
series.clustered = true;
series.fill = am4core.color("#08da94");
series.strokeWidth = 0;
series.columns.template.width = am4core.percent(100);




var series2 = chart1.series.push(new am4charts.ColumnSeries());
series2.dataFields.valueY = "Index";
series2.dataFields.categoryX = "Date";
series2.name = "S&P 500 TR Index";
series2.clustered = true;
series2.fill = am4core.color("#2d7abf");
series2.strokeWidth = 0;
series2.columns.template.width = am4core.percent(100);




// Add legend
chart1.legend = new am4charts.Legend();
chart1.legend.labels.template.fontSize = "25px";
chart1.legend.labels.template.minWidth = 120;
chart1.legend.labels.template.truncate = false;


// Export this stuff
chart1.exporting.menu = new am4core.ExportMenu();
chart1.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart1.exporting.filePrefix = "BUY_AnnualReturn";



// ################################   BUYIX Portfolio Sector (Pie) ################################################



// Create chart instance
var chart2 = am4core.create("chartdiv2", am4charts.PieChart);
chart2.innerRadius = am4core.percent(40);


// Set up data source
chart2.dataSource.url = "../Data/Backups/Catalyst/BUY/BUY_EXPORT_PortfolioSector.csv";
chart2.dataSource.parser = new am4core.CSVParser();
chart2.dataSource.parser.options.useColumnNames = true;

// Add series
var series = chart2.series.push(new am4charts.PieSeries());
series.dataFields.value = "Data";
series.dataFields.category = "Label";
series.slices.template.stroke = am4core.color("#ffffff");
series.slices.template.strokeWidth = 2;
series.slices.template.strokeOpacity = 1;
series.labels.template.disabled = true;
series.ticks.template.disabled = true;
series.slices.template.tooltipText = "";
series.colors.list = [
  am4core.color("#08da94"),
  am4core.color("#00c9af"),
  am4core.color("#00b6c7"),
  am4core.color("#00a1d6"),
  am4core.color("#008ad9"),
  am4core.color("#0070cd"),
  am4core.color("#2d53b3"),
  am4core.color("#61328d"),

];

// Add legend
chart2.legend = new am4charts.Legend();
chart2.legend.position = "left";
chart2.legend.maxWidth = undefined;
//chart2.legend.maxheight = 400;
chart2.legend.labels.template.fontSize = "18px";
chart2.legend.valueLabels.template.fontSize = "18px";
chart2.legend.labels.template.minWidth = 250;
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
chart2.exporting.filePrefix = "BUY_PortfolioSector";

// ################################   Export any charts OTHER THAN chart1 ################################################

function loadFrame() {
     chart1.exporting.export('svg');
     chart2.exporting.export('svg');
};

window.onload = setTimeout(loadFrame, 1000);
                           
                        
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
        width:980px!important;
		height:570px!important;
    }

        #chartdiv2 {
        width:1330px!important;
		height:320px!important;
    }

`;

// append to DOM
document.head.appendChild(style);




// ################################   CHART 1 IIX Portfolio Allocation (Pie) ################################################


// Create chart instance
var chart1 = am4core.create("chartdiv", am4charts.PieChart);
chart1.innerRadius = am4core.percent(50);
chart1.radius = am4core.percent(70);

// Set up data source
chart1.dataSource.url = "../Data/Backups/Catalyst/IIX/IIX_EXPORT_PortSectorAllocation.csv";
chart1.dataSource.parser = new am4core.CSVParser();
chart1.dataSource.parser.options.useColumnNames = true;



// Make the chart fade-in on init
chart1.hiddenState.properties.opacity = 0;

// Add series
var series = chart1.series.push(new am4charts.PieSeries());
series.dataFields.value = "Value";
series.dataFields.category = "Label";
series.slices.template.stroke = am4core.color("#ffffff");
series.slices.template.strokeWidth = 2;
series.slices.template.strokeOpacity = 1;
series.labels.template.disabled = true;
series.ticks.template.disabled = true;
series.slices.template.tooltipText = "";
series.colors.list = [
  am4core.color("#61328d"),
  am4core.color("#4f548e"),
  am4core.color("#426d8f"),
  am4core.color("#368490"),
  am4core.color("#2a9a91"),
  am4core.color("#1faf92"),
  am4core.color("#13c593"),
  am4core.color("#08da94"),

];


// Add legend
chart1.legend = new am4charts.Legend();
chart1.legend.position = "right";
chart1.legend.valign = "middle";

chart1.legend.maxWidth = undefined;
chart1.legend.maxheight = 600;
chart1.legend.valueLabels.template.align = "right";
chart1.legend.valueLabels.template.textAlign = "end";  
chart1.legend.labels.template.fontSize = "18px";
chart1.legend.valueLabels.template.fontSize = "18px";
chart1.legend.labels.template.truncate = false;
chart1.legend.labels.template.wrap = true;
chart1.legend.labels.template.minWidth = 220;





// Export this stuff
chart1.exporting.menu = new am4core.ExportMenu();
chart1.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart1.exporting.filePrefix = "IIX_PortfolioSector";

// ################################ CHART 2 IIX - Annual Return (Bar) ################################################

// Themes begin
am4core.useTheme(am4themes_amcharts);
// Themes end

// Create chart instance
var chart2 = am4core.create("chartdiv2", am4charts.XYChart);

// Add percent sign to all numbers
chart2.numberFormatter.numberFormat = "#.#'%'";

// Set up data source
chart2.dataSource.url = "../Data/Backups/Catalyst/IIX/IIX_EXPORT_AnnualReturn.csv";
chart2.dataSource.parser = new am4core.CSVParser();
chart2.dataSource.parser.options.useColumnNames = true;

// Create axes
var categoryAxis = chart2.xAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "Year";
categoryAxis.renderer.labels.template.fontWeight = "Bold";
categoryAxis.renderer.labels.template.fontSize = "23px";
categoryAxis.renderer.grid.template.disabled = false;
categoryAxis.renderer.grid.template.location = 0;
categoryAxis.renderer.minGridDistance = 30;
categoryAxis.renderer.cellStartLocation = 0.1;
categoryAxis.renderer.cellEndLocation = 0.9;
categoryAxis.renderer.grid.template.strokeOpacity = .2;

var valueAxis = chart2.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.grid.template.disabled = true;
valueAxis.renderer.labels.template.fontWeight = "Bold";
valueAxis.renderer.labels.template.fontSize = "23px";




// Create series
var series = chart2.series.push(new am4charts.ColumnSeries());
series.dataFields.valueY = "IIXIX";
series.dataFields.categoryX = "Year";
series.name = "IIXIX";
series.clustered = true;
series.fill = am4core.color("#08da94");
series.strokeWidth = 0;
series.columns.template.width = am4core.percent(100);




var series2 = chart2.series.push(new am4charts.ColumnSeries());
series2.dataFields.valueY = "Barclays 1-3 Yr US Govt/Credit";
series2.dataFields.categoryX = "Year";
series2.name = "Barclays 1-3 Yr US Govt/Credit";
series2.clustered = true;
series2.fill = am4core.color("#2d7abf");
series2.strokeWidth = 0;
series2.columns.template.width = am4core.percent(100);




// Add legend
chart2.legend = new am4charts.Legend();
chart2.legend.labels.template.fontSize = "23px";
chart2.legend.labels.template.truncate = false;


// Export this stuff
chart2.exporting.menu = new am4core.ExportMenu();
chart2.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart2.exporting.filePrefix = "IIX_AnnualReturn";
// ################################   Export any charts OTHER THAN chart1 ################################################

function loadFrame() {
     chart1.exporting.export('svg');
     chart2.exporting.export('svg');
};

window.onload = setTimeout(loadFrame, 1800);
                           
                        
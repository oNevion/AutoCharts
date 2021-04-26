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
		height:451px!important;
    }

`;

// append to DOM
document.head.appendChild(style);




// ################################   CHART 1 TRI Diversified Portfolio (Pie) ################################################


// Create chart instance
var chart1 = am4core.create("chartdiv", am4charts.PieChart);
chart.innerRadius = am4core.percent(40);

// Set up data source
chart1.dataSource.url = "../Data/Backups/Catalyst/TRI/TRI_EXPORT_DiversifiedPortfolio.csv";
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
chart1.legend = new am4charts.Legend();
chart1.legend.position = "left";
chart1.legend.maxWidth = undefined;
chart1.legend.maxheight = 400;
chart1.legend.valueLabels.template.align = "right";
chart1.legend.valueLabels.template.textAlign = "end";  
chart1.legend.labels.template.minWidth = 200;
chart1.legend.labels.template.truncate = false;




// Export this stuff
chart1.exporting.menu = new am4core.ExportMenu();
chart1.exporting.menu.items = [{
  "label": "...",
  "menu": [
          { "type": "svg", "label": "SVG" },
  ]
}];
chart1.exporting.filePrefix = "TRI_DiversifiedPortfolio";
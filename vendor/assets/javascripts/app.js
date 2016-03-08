function buildCharts(jsonedData) {
  // var allReports = JSON.parse(jsonedData);

  var dates = [];
  var temp_values = [];
  var hum_values = [];
  var press_values = [];

  jsonedData.forEach(function(report, key, myArray) {
    var jsDate = new Date(report.created_at)
    var date = jsDate.getHours() + ":00";
    dates.push(date);
    temp_values.push(report['temperature']);
    hum_values.push(report['humidity']);
    press_values.push(report['pressure']);
  });

  var tData = {
    labels: dates,
    datasets: [{
      label: "Temperature data",
      fillColor: "rgba(30,220,30,0.2)",
      strokeColor: "rgba(30,220,30,1)",
      pointColor: "rgba(30,220,30,1)",
      pointStrokeColor: "#fff",
      pointHighlightFill: "#fff",
      pointHighlightStroke: "rgba(220,220,220,1)",
      data: temp_values
    }]
  };
  var hData = {
    labels: dates,
    datasets: [{
      label: "Humidity data",
      fillColor: "rgba(220,50,100,0.2)",
      strokeColor: "rgba(220,50,100,1)",
      pointColor: "rgba(220,50,100,1)",
      pointStrokeColor: "#fff",
      pointHighlightFill: "#fff",
      pointHighlightStroke: "rgba(220,220,220,1)",
      data: hum_values

    }]
  };
  var pData = {
    labels: dates,
    datasets: [{
      label: "Pressure data",
      fillColor: "rgba(50,50,180,0.2)",
      strokeColor: "rgba(50,50,180,1)",
      pointColor: "rgba(50,50,180,1)",
      pointStrokeColor: "#fff",
      pointHighlightFill: "#fff",
      pointHighlightStroke: "rgba(220,220,220,1)",
      data: press_values
    }]
  };

  var tCtx = document.getElementById("tChart").getContext("2d");
  var tLineChart = new Chart(tCtx, {
      type: 'line',
      data: tData
  });
  // new Chart(tCtx).Line(tData);
  var hCtx = document.getElementById("hChart").getContext("2d");
  var hLineChart =
  new Chart(hCtx, {
      type: 'line',
      data: hData
  });
  // new Chart(hCtx).Line(hData);
  var pCtx = document.getElementById("pChart").getContext("2d");
  var pLineChart = new Chart(pCtx, {
      type: 'line',
      data: pData
  });
  // new Chart(pCtx).Line(pData);
};

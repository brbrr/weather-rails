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
    press_values.push(report['pressure'] / 10.0);
  });

  var tData = {
    labels: dates,
    datasets: [{
      label: "Temperature",
      backgroundColor: "rgba(225,0,0,0.3)",
      data: temp_values
    }]
  };

  var hData = {
    labels: dates,
    datasets: [{
      label: "Humidity data",
      backgroundColor: "rgba(0,225,0,0.3)",
      data: hum_values
    }]
  };
  var pData = {
    labels: dates,
    datasets: [{
      label: "Pressure data",
      backgroundColor: "rgba(0,0,225,0.3)",
      data: press_values
    }]
  };

  var tCtx = document.getElementById("tChart").getContext("2d");
  window.tLine = new Chart(tCtx, {
    type: 'line',
    data: tData
  });

  var hCtx = document.getElementById("hChart").getContext("2d");
  window.hLine = new Chart(hCtx, {
      type: 'line',
      data: hData
    });
  var pCtx = document.getElementById("pChart").getContext("2d");
  window.pLine = new Chart(pCtx, {
    type: 'line',
    data: pData
  });

  // $.each(config.data.datasets, function(i, dataset) {
  //         //  dataset.borderColor = randomColor(0.4);
  //         //  dataset.backgroundColor = "rgba(225,0,0,0.8)"; //randomColor(0.5);
  //         //  dataset.pointBorderColor = randomColor(0.7);
  //         //  dataset.pointBackgroundColor = randomColor(0.5);
  //         //  dataset.pointBorderWidth = 1;
  //      });

  //
  // var tCtx = document.getElementById("tChart").getContext("2d");
  // var tLineChart = new Chart(tCtx, {
  //   type: 'line',
  //   data: tData
  // });
  //
  // var hCtx = document.getElementById("hChart").getContext("2d");
  // var hLineChart = new Chart(hCtx, {
  //     type: 'line',
  //     data: hData
  //   });
  //
  // var pCtx = document.getElementById("pChart").getContext("2d");
  // var pLineChart = new Chart(pCtx, {
  //   type: 'line',
  //   data: pData
  // });

  // Update the chart
  //     window.myLine.update();

  // window.onload = function() {

  // };
};

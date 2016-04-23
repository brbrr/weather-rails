var config = {};
config.ready = function() {
  $( document ).ready(function() {
      console.log( "ready!" );
      $('#load').click(function (e) {
          e.preventDefault();
          updateCharts();
      });
      var date = new Date();
      date.setDate(date.getDate() - 1);
      $('#from').val(date.toString());
      $('#to').val((new Date()).toString());
  });
};

$(document).ready(config.ready);
$(document).on('page:load', config.ready);

function updateCharts() {
  getRequestData();
  return $.getJSON("/reports", config.requestData, function(data) {
    config.data = data;
    buildCharts(data);
  });
};

function getRequestData() {
  config.requestData = {
    from: $('#from').val(),
    to: $('#to').val(),
    normalize: $('#hourly').is(':checked')
  };
};

function buildCharts(data) {
    var preparedData = prepareData(data);
    fillCharts(preparedData);
};

function prepareData(dataObj) {
  var dates = [];
  var temp_values = [];
  var hum_values = [];
  var press_values = [];

  dataObj.forEach(function(report, key, myArray) {
    var jsDate = new Date(report.created_at)
    var date = jsDate.getHours() + ":00";
    dates.push(date);
    temp_values.push(report['temperature']);
    hum_values.push(report['humidity']);
    press_values.push(report['pressure'] / 10.0);
  });

  var preparedData = {
    temp: {
    labels: dates,
    datasets: [{
      label: "Temperature",
      backgroundColor: "rgba(225,0,0,0.3)",
      data: temp_values
    }]},
    hum: {
      labels: dates,
      datasets: [{
        label: "Humidity data",
        backgroundColor: "rgba(0,225,0,0.3)",
        data: hum_values
      }]},
    press: {
      labels: dates,
      datasets: [{
        label: "Pressure data",
        backgroundColor: "rgba(0,0,225,0.3)",
        data: press_values
      }]}
  };

  return preparedData;
};

function fillCharts(prepadedData) {
  $.each(prepadedData, function(key, value) {
    var chart = document.getElementById(key).getContext("2d");
    window.tLine = new Chart(chart, {
      type: "line",
      data: value
    });
})};

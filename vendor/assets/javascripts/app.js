var config = {
  requestData: {},
  charts: {},
  resposeData: [],
};

config.ready = function() {
  $( document ).ready(function() {
      console.log( "ready!" );
      $('#load').click(function (e) {
          e.preventDefault();
          doRequest(updateCharts);
      });
      setDates();
      doRequest(createCharts);
  });
};

$(document).ready(config.ready);
$(document).on('page:load', config.ready);

function setDates() {
  var date = new Date();
  date.setDate(date.getDate() - 1);
  config.requestData.from = date.toString();
  config.requestData.to = (new Date()).toString();
  $('#from').val(config.requestData.from);
  $('#to').val(config.requestData.to);
};

function createCharts(data) {
  prepareData(data);
  $.each(config.chartData, function(key, value) {
    var chart = document.getElementById(key).getContext("2d");
    config.charts[key] = new Chart(chart, config.chartData[key]);
})};

function updateCharts(data) {
    prepareData(data);
  $.each(config.charts, function(key, value) {
    value.config.data = config.chartData[key].data;
    value.update();
  })
};

function doRequest(func) {
  config.requestData = {
    from: $('#from').val(),
    to: $('#to').val(),
    normalize: $('#hourly').is(':checked')
  };
  return $.getJSON("/reports", config.requestData, func);
};

function prepareData(resposeData) {
  placeholder = {
    dates: [],
    temp_values: [],
    hum_values: [],
    press_values: []
  };
  resposeData.forEach(function(report, key, myArray) {
    var jsDate = new Date(report.created_at)
    var date = jsDate.getHours() + ":00";
    placeholder.dates.push(date);
    placeholder.temp_values.push(report['temperature']);
    placeholder.hum_values.push(report['humidity']);
    placeholder.press_values.push(report['pressure'] / 10.0);
  });

  return composeChartData(placeholder);
};

function composeChartData(placeholder) {
  config.chartData = {
    temp: {
      type: "line",
      data: {
        labels: placeholder.dates,
        datasets: [{
          label: "Temperature",
          backgroundColor: "rgba(225,0,0,0.3)",
          data: placeholder.temp_values
        }]
      }},
    hum: {
      type: "line",
      data: {
        labels: placeholder.dates,
        datasets: [{
          label: "Humidity data",
          backgroundColor: "rgba(0,225,0,0.3)",
          data: placeholder.hum_values
        }]
      }},
    press: {
      type: "line",
      data: {
        labels: placeholder.dates,
        datasets: [{
          label: "Pressure data",
          backgroundColor: "rgba(0,0,225,0.3)",
          data: placeholder.press_values
        }]
      }}
  };
};

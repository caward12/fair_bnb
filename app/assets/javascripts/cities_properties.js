$(document).ready(function(){
  var svg = dimple.newSvg("#citiesPropertiesContainer", 800, 600);

  $.ajax({
              type: 'GET',
              contentType: 'application/json; charset=utf-8',
              url: '/api/v1/properties',
              dataType: 'json',
              success: function(data){
                format(data)
              },
              error: function(result){
                error();
              }

            });


function format(data){
  var new_data = []
  for(var i in data) {
    var city = {};
    city["id"] = data[i].id;
    city["city"] = data[i].city;
    new_data.push(city);
};
count(new_data)
};

function count(data){
  var cityPropertyCount ={}
  for (var i in data){
    if (!cityPropertyCount[data[i].city]) {
      cityPropertyCount[data[i].city] = 0;
    }
    cityPropertyCount[data[i].city]++;
  };
  sort(cityPropertyCount)
};

function sort(cityPropertyCount){
  var sortable = [];
  for (var city in cityPropertyCount) {
    sortable.push([city, cityPropertyCount[city]]);
  }

    sortable.sort(function(a, b) {
        return a[1] - b[1];
    });
    formatData(sortable.slice(Math.max(sortable.length - 15, 1)))
};

function formatData(data){
  var chart_data =[]
  for (var i in data){
    var city_data = {}
    city_data["city"] = data[i][0];
    city_data["count"] = data[i][1];
    chart_data.push(city_data)
  }
  draw(chart_data)
};

function draw(data){
  var chart = new dimple.chart(svg, data);
  chart.defaultColors = [
    new dimple.color("teal") // You can use #RGB here
  ];
  chart.addAxis("x", "city", null);
  chart.addMeasureAxis("y", "count");
  chart.addSeries(null, dimple.plot.bar);
  chart.draw();

  };
});
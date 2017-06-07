$(document).ready(function(){
var svg = dimple.newSvg("#propertyComparisonContainer", 800, 600);
$.ajax({
            type: 'GET',
            contentType: 'application/json; charset=utf-8',
            url: '/api/v1/properties/most_expensive',
            dataType: 'json',
            success: function(data){
              format(data)
            },
            error: function(result){
              error();
            }

          });

  function format(data){
    new_data =[]
    for (var i in data){
      property ={}
      property["id"] = data[i].id
      property["price-beds"] = "price"
      property["count"] = Number(data[i].price_per_night)
      new_data.push(property)
    }
    for (var i in new_data){
      property2 = {}
      property2["id"] = data[i].id
      property2["price-beds"] = "beds"
      property2["count"] = data[i].number_of_beds
      new_data.push(property2)
    }
    draw(new_data)
  };

  function draw(data){
    var myChart = new dimple.chart(svg, data);
    myChart.setBounds(60, 30, 510, 330)
    myChart.addCategoryAxis("x", ["id", "price-beds"]);
    myChart.addMeasureAxis("y", "count");
    myChart.addSeries("price-beds", dimple.plot.bar);
    myChart.addLegend(65, 10, 510, 20, "right");
    myChart.draw();
  };

});
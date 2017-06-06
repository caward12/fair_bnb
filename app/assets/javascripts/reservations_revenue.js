$(document).ready(function(){
    var svg = dimple.newSvg("#chartContainer", 590, 400);

    $.ajax({
                type: 'GET',
                contentType: 'application/json; charset=utf-8',
                url: '/api/v1/reservations/revenue_by_month',
                dataType: 'json',
                success: function(data){
                  format(data)
                },
                error: function(result){
                  error();
                }

              });

// function format(data){
//   if(!(data instanceof Array)){
//     data = [data];
//  }
//  draw(data)
// };

function format(data){
  var new_data = []
  for(var i in data) {
    var ret = {};
    ret["month"] = i;
    ret["revenue"] = Number(data[i].slice(1, -1));
    new_data.push(ret);
};
draw(new_data)
};

function draw(data){
  var myChart = new dimple.chart(svg, data);
     myChart.setBounds(60, 30, 505, 305);
     var x = myChart.addCategoryAxis("x", "month");
     x.addOrderRule("month");
     var y = myChart.addMeasureAxis("y", "revenue");
     var s = myChart.addSeries(null, dimple.plot.line);
     myChart.draw();
   };
 });
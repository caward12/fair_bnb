$(document).ready(function(){
var svg = dimple.newSvg("#monthContainer", 800, 600);
$.ajax({
            type: 'GET',
            contentType: 'application/json; charset=utf-8',
            url: '/api/v1/reservations/by_month',
            dataType: 'json',
            success: function(data){
              sort(data)
            },
            error: function(result){
              error();
            }

          });
var allMonths = ['January','February','March', 'April','May','June','July','August','September','October','November','December'];

function sort(data){
          data.sort(function(a, b) {
              return allMonths.indexOf(a.month.trim()) > allMonths.indexOf(b.month.trim());
          });
          draw(data)
        };

// function dates(data){
//   for (month in data){
//     if (data.hasOwnProperty(month)) {
//       debugger
//       (data[month].month = Date(Date.parse(data[month].month +"1,2017")));
//     }
//   }
//   draw(data)
// };

    function draw(data){
      var chart = new dimple.chart(svg, data);
      chart.addAxis("x", "month", null).addOrderRule("month");
      chart.addMeasureAxis("y", "count");
      chart.addSeries(null, dimple.plot.bar);
      chart.draw();
  };
});


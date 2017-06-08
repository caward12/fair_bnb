$(document).ready(function(){
  $('#user_revenue input[type="submit"]').on("click", function(){
    $('.userRevenueContainer').html("")
    var user = $(this).parent().find('input[name="user_id"]').val()
    var svg = dimple.newSvg(".userRevenueContainer", 800, 600);

    $.ajax({
                 type: 'GET',
                 contentType: 'application/json; charset=utf-8',
                 url: '/api/v1/users/' + user + '/revenue',
                 dataType: 'json',
                 success: function(data){
                   format(data)
                 },
                 error: function(result){
                   error();
                 }

               });

      function format(data){
        var rev = data["revenue"]
        delete data["revenue"]
        var new_data = []
        for (var i in data){
          var property={}
          property["property"]= i;
          property["revenue"] = (data[i]/rev * 100).toFixed(2) + "%";
          new_data.push(property);
        }

        draw(new_data)
      }

      function draw (data) {
        var myChart = new dimple.chart(svg, data);
        myChart.setBounds(20, 20, 460, 360)
        myChart.addMeasureAxis("p", "revenue");
        myChart.defaultColors = [
     new dimple.color("#329194", "#067579", 1), // blue
     new dimple.color("#945983", "#943278", 1), // red
     new dimple.color("#59945E", "#0E961A", 1), // green
     new dimple.color("#B44667", "#B4093D", 1), // purple
     new dimple.color("#EFC052", "#E3A71A", 1), // gray

 ];
        var ring = myChart.addSeries("property", dimple.plot.pie);
        ring.innerRadius = "50%";
        myChart.addLegend(500, 20, 90, 300, "left");
        myChart.draw();
      };
  });
});

var dataset = [1,2,3,4,5,6,7,8];
var w = 500;
var h = 100;
var barPadding = 1;


var svg = d3.select(".plot")
            .append("svg")
            .attr("width", w)
            .attr("height", h);


            svg.selectAll("rect")
            			   .data(dataset)
            			   .enter()
            			   .append("rect")
            			   .attr("x", function(d, i) {
            			   		return i * (w / dataset.length);
            			   })
            			   .attr("y", 0)
            			   .attr("width", w / dataset.length - barPadding)
            			   .attr("height", 100);

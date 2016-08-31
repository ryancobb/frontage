var graphs = {
  dashboard: function(test_suite_id) {
    $.ajax({
      type: "GET",
      contentType: "application/json; charset=utf-8",
      url: window.location.origin + "/test_suites/" + test_suite_id + "/last_20_runs",
      dataType:'json',
      success: function(data) {
        render(data);
      },
      error: function(result) {
        error();
      }
    });

    // Parse date / time
    var parseDate = d3.utcParse("%Y-%m-%dT%H:%M:%S.%L%Z")
    var formatDate = d3.timeFormat("%x %I:%M %p")

    // Set dimensions of canvas
    var outerWidth = $(".chart-" + test_suite_id).width();
    var outerHeight = 100;
    var barHeight = 75;
    var widthPadding = 4;

    var svg = d3.select(".chart-" + test_suite_id).append("svg")
      .attr("width", outerWidth)
      .attr("height", outerHeight);

    // Define the div for the tooltip
    var div = d3.select("body").append("div")
      .attr("class", "tooltip")
      .style("opacity", 0);

    function render(data) {

      // Set data range
      var xScale = d3.scaleLinear().range([0, outerWidth])
      var colorScale = d3.scaleOrdinal().range(["#90D4A1", "#D49090"]);

      xScale.domain([0, data.length]);
      colorScale.domain([0, 1]);


      // Bind data
      var group = svg.selectAll("g").data(data)
        .enter().append("g")
          .append("svg:a")
            .attr("xlink:href", function(d) {
              url = window.location.origin + "/test_suites/" + test_suite_id + "/test_suite_runs/" + d.id;
              return url;
            })
            .on("mouseover", function(d) {
              div.transition()
                .duration(200)
                .style("opacity", .9);
              div.html( formatDate(parseDate(d["timestamp"])) )
                .style("left", (d3.event.pageX) + "px")
                .style("top", (d3.event.pageY - 28) + "px");
            })
            .on("mouseout", function(d) {
              div.transition()
                .duration(500)
                .style("opacity", 0)
            });

        group.append("rect")
            .attr("x", function(d, i) { return xScale(i); })
            .attr("y", (barHeight/2) - (outerHeight-barHeight))
            .attr("width", (outerWidth/data.length) - widthPadding)
            .attr("height", barHeight)
            .attr("fill", function(d) { return colorScale(d["errs"] + d["failures"]) })

      group.exit().remove();
    }
  }
}

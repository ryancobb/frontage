var graphs = {
  dashboard: function() {
    $(".test-suite").each(function() {
      test_suite_id = $(this).attr("test-suite-id");
      $.ajax({
        type: "GET",
        contentType: "application/json; charset=utf-8",
        url: "test_suites/" + test_suite_id + "/test_suite_runs",
        dataType:'json',
        success: function(data) {
          render(data);
        },
        error: function(result) {
          error();
        }
      });

      var outerWidth = $(".chart-" + test_suite_id).width();
      var outerHeight = 150;

      var svg = d3.select(".chart-" + test_suite_id).append("svg")
        .attr("width", outerWidth)
        .attr("height", outerHeight);

        function render(data) {

          var xScale = d3.scaleLinear().range([0, outerWidth])
          var colorScale = d3.scaleOrdinal().range(["green", "red"]);

          xScale.domain([0, data.length]);
          colorScale.domain([0, 1]);

          // Bind data
          var rects = svg.selectAll("rect").data(data);

          // Enter
          rects.enter().append("svg:a")
          .attr("xlink:href", function(d) {
            url = "test_suites/" + test_suite_id + "/test_suite_runs/" + d.id;
            return url;
          })
          .append("rect")
            .attr("x", function(d, i) { return xScale(i); })
            .attr("y", 50)
            .attr("width", 15)
            .attr("height", 60)
            .attr("fill", function(d) { return colorScale(d["errs"]) });

          rects.exit().remove();
        }
    });
  }
}

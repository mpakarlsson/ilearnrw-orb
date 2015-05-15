var width = 860, height = 600, padding = 2, clusterPadding = 14, maxRadius = 12, scaleFactor = 4, n, m, color, clusters, nodes, circle;

function createCircles(inputData, categories, probsLength, lang) {
	data = inputData;

	// padding = 1.5, // separation between same-color circles
	// clusterPadding = 6, // separation between different-color circles

	n = data.length, // total number of circles
	m = probsLength; // number of distinct clusters

	if (lang == "GR")
		scaleFactor = 6;

	color = d3.scale.category10().domain(d3.range(m));

	// The largest node for each cluster.
	clusters = new Array(m);
	var cnt = 0;
	nodes = d3
			.range(n)
			.map(
					function() {
						var i = data[cnt][0], r = data[cnt][1] * scaleFactor, inf = data[cnt][2];
						if (r == 0)
							r = 2;
						var d = {
							cluster : i,
							radius : r,
							info : inf
						};
						cnt++;
						if (!clusters[i] || (r > clusters[i].radius))
							clusters[i] = d;
						return d;
					});

	var force = d3.layout.force().nodes(nodes).size([ width, height ]).gravity(
			0.001).charge(14).on("tick", tick).start();

	var svg = d3.select("#test").append("svg").attr("width", width).attr(
			"height", height);
	
	var svgDescriptions = d3.select("#descriptions").append("svg").attr("width", width).attr(
			"height", 180);
	

	svgDescriptions.selectAll("circle").data(categories).enter().append("circle").
		attr("r", 10)
			.style("fill", function(d, i) { return color(i+10); })
			.attr("cx", function (d, i) { return i>probsLength/2?20:420; })
			.attr("cy", function (d, i) { return i>probsLength/2?(i-probsLength/2+1)*30:(i+1)*30; });

	svgDescriptions.selectAll("text").data(categories).enter().append("text")
		.attr("x", function (d, i) { return i>probsLength/2?40:440; })
		.attr("y", function (d, i) { return 1+(i>probsLength/2?(i-probsLength/2+1)*30:(i+1)*30); })
		.attr("dy", ".35em")
		.attr("font-family", "sans-serif")
		.attr("font-size", "18px")
		.text(function(d) { return d; });
	
	
	
	circle = svg.selectAll("circle").data(nodes).enter().append("circle").attr(
			"r", function(d) {
				return d.radius;
			}).style("fill", function(d) {
		return color(d.cluster+10);
	}).on('mouseover', function(d) {
		var nodeSelection = d3.select(this).style({
			opacity : '0.7'
		});
	}).on('mouseout', function(d) {
		var nodeSelection = d3.select(this).style({
			opacity : '1'
		});
	}).call(force.drag);

	svg.selectAll("circle").data(nodes).append("svg:title").text(function(d) {
		return d.info;
	});
}
function tick(e) {
	circle.each(cluster(10 * e.alpha * e.alpha)).each(collide(.5)).attr("cx",
			function(d) {
				return d.x;
			}).attr("cy", function(d) {
		return d.y;
	});
}

// Move d to be adjacent to the cluster node.
function cluster(alpha) {
	return function(d) {
		var cluster = clusters[d.cluster], k = 1;

		// For cluster nodes, apply custom gravity.
		if (cluster === d) {
			cluster = {
				x : width / 2,
				y : height / 2,
				radius : -d.radius
			};
			k = .1 * Math.sqrt(d.radius);
		}

		var x = d.x - cluster.x, y = d.y - cluster.y, l = Math.sqrt(x * x + y
				* y), r = d.radius + cluster.radius;
		if (l != r) {
			l = (l - r) / l * alpha * k;
			d.x -= x *= l;
			d.y -= y *= l;
			cluster.x += x;
			cluster.y += y;
		}
	};
}

// Resolves collisions between d and all other circles.
function collide(alpha) {
	var quadtree = d3.geom.quadtree(nodes);
	return function(d) {
		var r = d.radius + maxRadius + Math.max(padding, clusterPadding), nx1 = d.x
				- r, nx2 = d.x + r, ny1 = d.y - r, ny2 = d.y + r;
		quadtree.visit(function(quad, x1, y1, x2, y2) {
			if (quad.point && (quad.point !== d)) {
				var x = d.x - quad.point.x, y = d.y - quad.point.y, l = Math
						.sqrt(x * x + y * y), r = d.radius
						+ quad.point.radius
						+ (d.cluster === quad.point.cluster ? padding
								: clusterPadding);
				if (l < r) {
					l = (l - r) / l * alpha;
					d.x -= x *= l;
					d.y -= y *= l;
					quad.point.x += x;
					quad.point.y += y;
				}
			}
			return x1 > nx2 || x2 < nx1 || y1 > ny2 || y2 < ny1;
		});
	};
}

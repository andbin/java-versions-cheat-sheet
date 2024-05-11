$(function() {
	function scrolltopToggle() {
		$("#scrolltop").toggle($(window).scrollTop() > 300);
	}

	function daysDiff(d1, d2) {
		return Math.floor((d1 - d2) / 86400000);
	}

	$(window).each(scrolltopToggle);
	$(window).scroll(scrolltopToggle);

	$("#scrolltop").on("click", function() {
		$("html, body").scrollTop(0);
		return false;
	});

	var now = Date.now();

	$("#jvcstable span.latest-build").each(function() {
		var releaseDateStr = $(this).data("release-date");
		if (releaseDateStr) {
			if (daysDiff(now, new Date(releaseDateStr)) < 90) {
				$(this).after(" ", "<span class='jv-new badge rounded-pill' title='This build was released less than 90 days ago'>NEW</span>");
			}
		}
	});

	var updatedAtMillis = $("#jvcsdaysago").data("millis");
	var updatedDaysAgo = daysDiff(now, new Date(Number(updatedAtMillis)));
	$("#jvcsdaysago").append("(" + updatedDaysAgo + " " + (updatedDaysAgo == 1 ? "day" : "days") + " ago)");

	$("[title]").tooltip({
		delay: { "show": 500, "hide": 0 },
		trigger: "hover",
		html: true
	});
});

$(function() {
	function scrolltopToggle() {
		$("#scrolltop").toggle($(window).scrollTop() > 300);
	}

	$(window).each(scrolltopToggle);
	$(window).scroll(scrolltopToggle);

	$("#scrolltop").on("click", function() {
		$("html, body").scrollTop(0);
		return false;
	});

	$("[title]").tooltip();
});

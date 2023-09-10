(function() {
    window.addEventListener("load", function(e) {
        document.querySelectorAll("[title]").forEach(function(elem) {
            new bootstrap.Tooltip(elem);
        });
    });
}());

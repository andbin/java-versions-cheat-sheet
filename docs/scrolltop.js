(function() {
    function scrollSetup() {
        scrollButton().onclick = scrollToTop;
        scrollHandler();
        window.addEventListener("scroll", function(e) {
            scrollHandler();
        });
    }

    function scrollHandler() {
        if (document.body.scrollTop > 50 || document.documentElement.scrollTop > 50) {
            scrollButton().style.display = "block";
        } else {
            scrollButton().style.display = "none";
        }
    }

    function scrollToTop() {
        if (document.body.scrollTop) {
            document.body.scrollTop = 0;
        } else if (document.documentElement.scrollTop) {
            document.documentElement.scrollTop = 0;
        }
    }

    function scrollButton() {
        return document.getElementById("scrolltop");
    }

    window.addEventListener("load", function(e) {
        scrollSetup();
    });
}());

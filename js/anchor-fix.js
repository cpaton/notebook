window.onhashchange = function (ev) {
    // Due the fixed navbar at the top when an anchor is scrolled to the top of the page it is hidden behind
    // the navbar.  Need to offset the scroll position by the height of this navbar
    var targetElement = document.getElementById(location.hash.substring(1));
    if (typeof(element) != 'undefined' && element != null)
    {
        targetElement.scrollTop;
    }
    else {
        var offsetBy = document.getElementById('header-nav-bar').clientHeight;
        window.scrollBy(0, (-1 * (offsetBy + 3)));
    }
}
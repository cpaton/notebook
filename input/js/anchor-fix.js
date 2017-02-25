window.onhashchange = function () {
    // Due the fixed navbar at the top when an anchor is scrolled to the top of the page it is hidden behind
    // the navbar.  Need to offset the scroll position by the height of this navbar
    window.scrollBy(0, -110);
}
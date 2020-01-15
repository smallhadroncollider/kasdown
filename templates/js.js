// needs to support iOS 6
(function (d) {
    var toArr = function (arr) {
        return Array.prototype.slice.call(arr)
    };

    var items = toArr(d.getElementsByTagName("li"));

    items.forEach(function (current) {
        var el, span;

        p = d.createElement("p");
        p.setAttribute("class", "clickable");

        els = toArr(current.childNodes).filter(function (el) {
            return el.tagName !== "UL";
        });

        current.insertBefore(p, current.firstChild);

        els.forEach(function (el) {
            p.appendChild(el);
        });
    })

    var clickables = toArr(d.getElementsByClassName("clickable"));

    clickables.forEach(function (current) {
        current.addEventListener("click", function () {
            current.setAttribute("class", "done");
        });
    });
})(document)

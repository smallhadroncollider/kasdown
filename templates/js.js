((d) => {
    document.addEventListener("click", e => {
        let clicked = e.target;

        if (clicked.tagName === "LI") {
            clicked.classList.add("done");
        }
    });
})(document)

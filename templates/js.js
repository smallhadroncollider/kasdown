((d) => {
    document.addEventListener("click", e => {
        let clicked = e.composedPath().find(el => el.tagName === "LI")

        if (clicked) {
            clicked.classList.add("done");
        }
    });
})(document)

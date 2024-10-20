const featureBoxes = document.querySelectorAll('.feature-box');

featureBoxes.forEach(box => {
    box.addEventListener('click', function() {
        const url = this.getAttribute('data-url');
        window.location.href = url;
    });
});

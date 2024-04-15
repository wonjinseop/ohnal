const imageTag = document.getElementById("ex_file");
imageTag.addEventListener('change', function () {
    console.log('파일선택');
    while (onnode.hasChildNodes()) {
        onnode.removeChild(onnode.firstChild);
    }
    loadImg(this);

});
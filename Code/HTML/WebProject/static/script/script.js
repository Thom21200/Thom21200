function onload() {
    setInterval(checkPrice, 100);
}

function checkPrice() {
    ql = document.getElementById("ql").value;
    qlt = ql*6.5;
    document.getElementById("qlt").value = qlt;

    qc = document.getElementById("qc").value;
    qct = qc*6.5;
    document.getElementById("qct").value = qct;

    total = qct + qlt;
    document.getElementById("qlt").value = total;
}

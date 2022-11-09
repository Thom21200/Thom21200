function onload() {
    setInterval(check, 100);
}

function check() {
    ql = document.getElementById("ql");
    checkQuantity(ql);

    qlt = ql.value*6.5;
    qlte = formatToEuro(qlt);
    document.getElementById("qlt").innerHTML = qlte;
    document.getElementById("qlp").innerHTML = ql.value;

    qc = document.getElementById("qc");
    checkQuantity(qc);

    qct = qc.value*6.5;
    qcte = formatToEuro(qct)
    document.getElementById("qct").innerHTML = qcte;
    document.getElementById("qcp").innerHTML = qc.value;

    total = qct + qlt;
    document.getElementById("total").innerHTML = formatToEuro(total);
}

function checkQuantity(elem) {
    if (elem.value < 0) {
        elem.value = 0;
    } else if (elem.value > 1000) {
        elem.value = 1000;
    }
}

function formatToEuro(val) {
    if (Math.round(val) == val) {
        return val + ".00€";
    } else {
        return val + "0€";
    }
}

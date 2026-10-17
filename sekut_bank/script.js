(function () {
  "use strict";

  var KUNCI = "saldo-app-data";

  var data = {
    saldo: 1000000,
    riwayat: [
      { nominal: 100000, waktu: "23:53, 16/10/2026", status: "tambah saldo" },
      { nominal: 90000, waktu: "14:32, 16/10/2026", status: "tarik saldo" },
      { nominal: 6000, waktu: "09:13, 16/10/2026", status: "tambah saldo" }
    ]
  };

  var mode = "tambah";

  var elSaldo = document.getElementById("saldo");
  var elNominal = document.getElementById("nominal");
  var elPesan = document.getElementById("pesan");
  var elBody = document.getElementById("riwayat-body");
  var elKosong = document.getElementById("kosong");
  var btnTambah = document.getElementById("btn-tambah");
  var btnKurang = document.getElementById("btn-kurang");
  var btnKonfirmasi = document.getElementById("btn-konfirmasi");

  function muat() {
    try {
      var tersimpan = localStorage.getItem(KUNCI);
      if (tersimpan) data = JSON.parse(tersimpan);
    } catch (e) {
      /* abaikan, pakai data awal */
    }
  }

  function simpan() {
    try {
      localStorage.setItem(KUNCI, JSON.stringify(data));
    } catch (e) {
      /* abaikan */
    }
  }

  function formatRupiah(angka) {
    return "Rp " + Number(angka).toLocaleString("en-US");
  }

  function dua(n) {
    return n < 10 ? "0" + n : String(n);
  }

  function formatWaktu(d) {
    return (
      dua(d.getHours()) + ":" + dua(d.getMinutes()) + ", " +
      dua(d.getDate()) + "/" + dua(d.getMonth() + 1) + "/" + d.getFullYear()
    );
  }

  function ambilAngka(teks) {
    return parseInt(teks.replace(/\D/g, ""), 10) || 0;
  }

  function tampilPesan(teks, sukses) {
    elPesan.textContent = teks;
    elPesan.classList.toggle("sukses", !!sukses);
  }

  function render() {
    elSaldo.textContent = formatRupiah(data.saldo);

    elBody.innerHTML = "";
    data.riwayat.forEach(function (item) {
      var tr = document.createElement("tr");

      var tdNominal = document.createElement("td");
      tdNominal.setAttribute("data-label", "Nominal");
      tdNominal.textContent = formatRupiah(item.nominal);

      var tdWaktu = document.createElement("td");
      tdWaktu.setAttribute("data-label", "Waktu");
      tdWaktu.textContent = item.waktu;

      var tdStatus = document.createElement("td");
      tdStatus.setAttribute("data-label", "Status");
      var badge = document.createElement("span");
      badge.className = "badge " + (item.status === "tambah saldo" ? "badge-tambah" : "badge-tarik");
      badge.textContent = item.status;
      tdStatus.appendChild(badge);

      tr.appendChild(tdNominal);
      tr.appendChild(tdWaktu);
      tr.appendChild(tdStatus);
      elBody.appendChild(tr);
    });

    elKosong.hidden = data.riwayat.length > 0;
  }

  function setMode(baru) {
    mode = baru;
    btnTambah.classList.toggle("aktif", mode === "tambah");
    btnKurang.classList.toggle("aktif", mode === "kurang");
    btnTambah.setAttribute("aria-pressed", mode === "tambah");
    btnKurang.setAttribute("aria-pressed", mode === "kurang");
    tampilPesan("");
  }

  function konfirmasi() {
    var nominal = ambilAngka(elNominal.value);

    if (nominal <= 0) {
      tampilPesan("Masukkan nominal lebih dari 0.");
      elNominal.focus();
      return;
    }

    if (mode === "kurang" && nominal > data.saldo) {
      tampilPesan("Saldo tidak cukup. Saldo kamu " + formatRupiah(data.saldo) + ".");
      elNominal.focus();
      return;
    }

    data.saldo += mode === "tambah" ? nominal : -nominal;
    data.riwayat.unshift({
      nominal: nominal,
      waktu: formatWaktu(new Date()),
      status: mode === "tambah" ? "tambah saldo" : "tarik saldo"
    });

    simpan();
    render();

    elNominal.value = "";
    tampilPesan(mode === "tambah" ? "Saldo berhasil ditambah." : "Saldo berhasil dikurangi.", true);
  }

  btnTambah.addEventListener("click", function () { setMode("tambah"); });
  btnKurang.addEventListener("click", function () { setMode("kurang"); });
  btnKonfirmasi.addEventListener("click", konfirmasi);

  elNominal.addEventListener("input", function () {
    var angka = ambilAngka(elNominal.value);
    elNominal.value = angka > 0 ? angka.toLocaleString("en-US") : "";
    tampilPesan("");
  });

  elNominal.addEventListener("keydown", function (e) {
    if (e.key === "Enter") konfirmasi();
  });

  muat();
  render();
  setMode("tambah");
})();
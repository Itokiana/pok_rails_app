function profil() {
  sessionStorage.setItem("profil", "true")
}

$(".btn-profil").click(event => {
  profil()
})
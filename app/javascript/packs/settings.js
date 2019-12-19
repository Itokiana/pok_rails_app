$("#time_check_inactivity_part").prop("disabled", true)
$("#time_check_inactivity").change((e) => {
  console.log( $("#time_check_inactivity").val(),  $("#time_check_inactivity_part").val() )
  let part = Math.floor(parseInt(e.target.value)/3)
  $("#time_check_inactivity_part").val(part + "")
})
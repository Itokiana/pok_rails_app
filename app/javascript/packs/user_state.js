import $ from 'jquery';
window.jQuery = $;
window.$ = $;

require('datatables.net-bs4');
import moment from 'moment';

console.log(moment().format())


let horodatorUser = $('#horodator_user').val()
let base_url = $("#base_url").val()

function minsec(second) {
  let hours = Math.floor(second / 3600);
  let minutes = Math.floor(second / 60);
  let seconds = second - minutes * 60;

  if(hours !== 0){
    return hours + "h" + minutes + "m" + seconds + "s";
  } else if(minutes !== 0) {
    return minutes + "m" + seconds + "s";
  } else {
    return seconds + "s";
  }
}

function dateFormat(d){
  let date = ("0"+d.getDate()).slice(-2)+"/"+("0"+(d.getMonth() + 1)).slice(-2)+"/"+d.getFullYear()+" à "+("0"+d.getHours()).slice(-2)+":"+("0"+d.getMinutes()).slice(-2)+":"+("0"+d.getSeconds()).slice(-2);
  return date
}

function getWindows(u) {
  $("#loading").show()
  $.ajax({
    type: 'get',
    url: base_url + '/user_state/'+ u +'/windows',
    success: (res) => {
      // console.log(res)
      $("#loading").hide()
      let rows = []
  
      if(res.length !== 0){
        for(let i = 0; i < res.length; i++){
          let start = new Date(res[i].started_at)
          let end = new Date(res[i].ended_at)
          console.log(start, end)
          rows.push([ 
            res[i].title, 
            res[i].platform, 
            res[i].x, 
            res[i].y, 
            res[i].width_screen, 
            res[i].height_screen,
            dateFormat(start),
            dateFormat(end),
            minsec(res[i].total_focus)
          ])
        }
        $('#windows').DataTable( {
          data: rows,
          "language": {
              "lengthMenu": "Afficher _MENU_ entrées",
              "zeroRecords": "Aucun résultat",
              "info": "Afficher _PAGE_ sur _PAGES_",
              "infoEmpty": "Aucune entrée",
              "infoFiltered": "(filtered from _MAX_ total records)",
              "search": "Rechercher:",
              "paginate": {
                  "first":      "Début",
                  "last":       "Fin",
                  "next":       "Suivant",
                  "previous":   "Précédent"
              }
          },
            columns: [
              { title: "Application" },
              { title: "Platforme" },
              { title: "X" },
              { title: "Y" },
              { title: "Largeur" },
              { title: "Hauteur" },
              { title: "Début" },
              { title: "Fin" },
              { title: "Total focus" }
          ],
          "bDestroy": true
        } )
      } else {
        $('#windows').DataTable().destroy();
      }
      
    }
  
  })
}

function getUrls(u) {
  $("#loading").show()
  $.ajax({
    type: 'get',
    url: base_url + '/user_state/'+ u +'/urls_visited',
    success: (res) => {
      // console.log(res)
      $("#loading").hide()
      let rows = []
  
      for(let i = 0; i < res.length; i++){
        let start = new Date(res[i].date_of_visit)
        let end = new Date(res[i].end_of_visit)

        rows.push([
          res[i].url,
          dateFormat(start),
          dateFormat(end),
          res[i].focus,
          minsec(res[i].total_focus)
        ])

        $('#urls').DataTable( {
          data: rows,
          "language": {
              "lengthMenu": "Afficher _MENU_ entrées",
              "zeroRecords": "Aucun résultat",
              "info": "Afficher _PAGE_ sur _PAGES_",
              "infoEmpty": "Aucune entrée",
              "infoFiltered": "(filtered from _MAX_ total records)",
              "search": "Rechercher:",
              "paginate": {
                  "first":      "Début",
                  "last":       "Fin",
                  "next":       "Suivant",
                  "previous":   "Précédent"
              }
          },
            columns: [
              { title: "URL" },
              { title: "Début de la visite" },
              { title: "Fin de la visite" },
              { title: "Focus" },
              { title: "Total focus" }
          ],
          "bDestroy": true
        } )
      }
      
    }
  
  })
}

function getInactivities(u) {
  $("#loading").show()
  $.ajax({
    type: 'get',
    url: base_url + '/user_state/'+ u +'/inactivities',
    success: (res) => {
      // console.log(res)
      $("#loading").hide()
      let rows = []

      for(let i = 0; i < res.length; i++){
        let start = new Date(res[i].since)
        let end = new Date(res[i].created_at)

        rows.push([
          res[i].mouse_x,
          res[i].mouse_y,
          dateFormat(start),
          dateFormat(end),
          minsec(res[i].total)
        ])

        $('#inactivities').DataTable( {
          data: rows,
          "language": {
              "lengthMenu": "Afficher _MENU_ entrées",
              "zeroRecords": "Aucun résultat",
              "info": "Afficher _PAGE_ sur _PAGES_",
              "infoEmpty": "Aucune entrée",
              "infoFiltered": "(filtered from _MAX_ total records)",
              "search": "Rechercher:",
              "paginate": {
                  "first":      "Début",
                  "last":       "Fin",
                  "next":       "Suivant",
                  "previous":   "Précédent"
              }
          },
            columns: [
              { title: "Positon souris X" },
              { title: "Positon souris Y" },
              { title: "De" },
              { title: "À" },
              { title: "Pendant" }
          ],
          "bDestroy": true
        } )
      }
      
    }
  
  })
}

getWindows(horodatorUser)
getUrls(horodatorUser)
getInactivities(horodatorUser)

$("#refresh-data").click((e) => {

  // alert("Refreshing...")
  $("#windows_card").empty()
  $("#windows_card").html(`
    <table class="table table-bordered" id="windows" width="100%"></table>
  `)

  $("#urls_card").empty()
  $("#urls_card").html(`
    <table class="table table-bordered" id="urls" width="100%"></table>
  `)

  $("#inactivities_card").empty()
  $("#inactivities_card").html(`
    <table class="table table-bordered" id="inactivities" width="100%"></table>
  `)
  // $('#windows').DataTable().destroy();
  getWindows(horodatorUser)
  // $('#urls').DataTable().destroy();
  getUrls(horodatorUser)
  // $('#inactivities').DataTable().destroy();
  getInactivities(horodatorUser)

})

$('#horodator_user').change((e) => {

  horodatorUser = e.target.value
  console.log(e.target.value)

  // alert("Refreshing...")
  
  $("#windows_card").empty()
  $("#windows_card").html(`
    <table class="table table-bordered" id="windows" width="100%"></table>
  `)

  $("#urls_card").empty()
  $("#urls_card").html(`
    <table class="table table-bordered" id="urls" width="100%"></table>
  `)

  $("#inactivities_card").empty()
  $("#inactivities_card").html(`
    <table class="table table-bordered" id="inactivities" width="100%"></table>
  `)
  // $('#windows').DataTable().destroy();
  getWindows(horodatorUser)
  // $('#urls').DataTable().destroy();
  getUrls(horodatorUser)
  // $('#inactivities').DataTable().destroy();
  getInactivities(horodatorUser)

})


if(sessionStorage.getItem("profil") !== null){
  $('#user-nav-tab a[href="#nav-profile"]').tab('show')
  sessionStorage.removeItem("profil")
}
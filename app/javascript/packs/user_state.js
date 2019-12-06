import $ from 'jquery';
window.jQuery = $;
window.$ = $;

require('datatables.net-bs4');


let horodatorUser = $('#horodator_user').val()
let base_url = $("#base_url").val()

function dateFormat(d){
  let date = ("0"+d.getDate()).slice(-2)+"/"+("0"+(d.getMonth() + 1)).slice(-2)+"/"+d.getFullYear()+" à "+("0"+d.getHours()).slice(-2)+":"+("0"+d.getMinutes()).slice(-2)+":"+("0"+d.getSeconds()).slice(-2);
  return date
}

function getWindows(u) {
  $.ajax({
    type: 'get',
    url: base_url + '/user_state/'+ u +'/windows',
    success: (res) => {
      console.log(res)
      let rows = []
  
      if(res.length !== 0){
        for(let i = 0; i < res.length; i++){
          let start = new Date(res[i].started_at)
          let end = new Date(res[i].created_at)
          rows.push([ 
            res[i].title, 
            res[i].platform, 
            res[i].x, 
            res[i].y, 
            res[i].width_screen, 
            res[i].height_screen,
            dateFormat(start),
            dateFormat(end),
            res[i].total_focus + ' sec(s)'
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
  $.ajax({
    type: 'get',
    url: base_url + '/user_state/'+ u +'/urls_visited',
    success: (res) => {
      console.log(res)
      let rows = []
  
      for(let i = 0; i < res.length; i++){
        let start = new Date(res[i].date_of_visit)
        let end = new Date(res[i].end_of_visit)

        rows.push([
          res[i].url,
          dateFormat(start),
          dateFormat(end),
          res[i].focus,
          res[i].total_focus + ' sec(s)'
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
  $.ajax({
    type: 'get',
    url: base_url + '/user_state/'+ u +'/inactivities',
    success: (res) => {
      console.log(res)
      let rows = []

      for(let i = 0; i < res.length; i++){
        let start = new Date(res[i].since)
        let end = new Date(res[i].created_at)

        rows.push([
          res[i].mouse_x,
          res[i].mouse_y,
          dateFormat(start),
          dateFormat(end),
          res[i].total + ' sec(s)'
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
  $('#windows').DataTable().destroy();
  getWindows(horodatorUser)
  $('#urls').DataTable().destroy();
  getUrls(horodatorUser)
  $('#inactivities').DataTable().destroy();
  getInactivities(horodatorUser)

})

$('#horodator_user').change((e) => {

  horodatorUser = e.target.value
  console.log(e.target.value)

  // alert("Refreshing...")
  
  $('#windows').DataTable().destroy();
  getWindows(e.target.value)
  $('#urls').DataTable().destroy();
  getUrls(e.target.value)
  $('#inactivities').DataTable().destroy();
  getInactivities(e.target.value)

})

let Chart = require('chart.js');
let base_url = $("#base_url").val();

// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#858796';


// Pie Chart Example
function dateDiffInSecond(date1, date2) {
  var diff = {}                           // Initialisation du retour
  var tmp = date2 - date1;

  tmp = Math.floor(tmp / 1000);
  diff.sec = tmp % 60;

  tmp = Math.floor((tmp - diff.sec) / 60);    // Nombre de minutes (partie entière)
  diff.min = tmp % 60;                    // Extraction du nombre de minutes

  tmp = Math.floor((tmp - diff.min) / 60);    // Nombre d'heures (entières)
  diff.hour = tmp % 24;                   // Extraction du nombre d'heures

  tmp = Math.floor((tmp - diff.hour) / 24);   // Nombre de jours restants
  diff.day = tmp;

  return diff.sec + (diff.min * 60) + (diff.hour * 3600) + (diff.day * 86400);
}


function schedule_states(){
  $.ajax({
    url: base_url + "/api/admin/total_schedule",
    type: 'get',
    success: (res) => {
      let journey = dateDiffInSecond(new Date(res.first_schedule), new Date(new Date().setHours(new Date(res.first_schedule).getHours() + 9 )))
      let activity = dateDiffInSecond(new Date(res.first_schedule), new Date())
      let activity_percent = (dateDiffInSecond(new Date(res.first_schedule), new Date()) * 100) / journey
      let inactivity_percent = (parseInt(res.total_inactivity) * 100) / activity
      let journey_percent = 100 - (activity_percent + inactivity_percent)
      
      let ctx = document.getElementById("pie-activity");
      let myPieChart = new Chart(ctx, {
        type: 'doughnut',
        data: {
          labels: ["Journée", "Activité", "Inactivités"],
          datasets: [{
            data: [journey_percent, activity_percent, inactivity_percent],
            backgroundColor: ['#4e73df', '#1cc88a', '#d95c50'],
            hoverBackgroundColor: ['#2e59d9', '#17a673', '#e74a3b'],
            hoverBorderColor: "rgba(234, 236, 244, 1)",
          }],
        },
        options: {
          maintainAspectRatio: false,
          tooltips: {
            backgroundColor: "rgb(255,255,255)",
            bodyFontColor: "#858796",
            borderColor: '#dddfeb',
            borderWidth: 1,
            xPadding: 15,
            yPadding: 15,
            displayColors: false,
            caretPadding: 10,
          },
          legend: {
            display: true
          },
          cutoutPercentage: 80,
        },
      });
    }
  })
}

function url_states() {
  $.ajax({
    url: base_url + '/api/admin/top_urls',
    type: 'get',
    success: (res) => {
      $("#top_url").empty()
      res.map((u) => {
        $("#top_url").append(`
          <tr>
            <td>${ u[0] }</td>
            <td>${ u[1] }</td>
          </tr>
        `)
      })
    }
  })
}

function app_states() {
  $.ajax({
    url: base_url + '/api/admin/top_apps',
    type: 'get',
    success: (res) => {
      $("#top_app").empty()
      res.map((a) => {
        $("#top_app").append(`
          <tr>
            <td>${ a[0] }</td>
            <td>${ a[1] }</td>
          </tr>
        `)
      })
    }
  })
}

function user_active() {
  $.ajax({
    url: base_url + '/api/admin/user_active',
    type: 'get',
    success: (res) => {
      $("#user_active").empty()
      res.map((u) => {
        $("#user_active").append(`
          <tr>
            <td>${u.email}</td>
            <td>${u.ip}</td>
            <td>${u.mac}</td>
            <td>${u.start}</td>
            <td>${u.top_inactivity.total} sec(s)</td>
            <td>
              <a href="${base_url}/user_state/${ u.user_id }" class="btn btn-sm btn-info btn-icon-split">
                <span class="icon text-white-50">
                  <i class="fas fa-flag"></i>
                </span>
                <span class="text">Status</span>
              </a>
            </td>
          </tr>
        `)
      })
    }
  })
}

schedule_states()
url_states()
app_states()
user_active()

setInterval(schedule_states(), 30000)

setInterval(() => {
  url_states()
  app_states()
  user_active()
}, 10000)
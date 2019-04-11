import places from 'places.js';


function initAutocomplete(){
  const userLocation = document.getElementById('user_location');
  const runStatLocation = document.getElementById('run_starting_point');
  const runLocationFilter = document.getElementById('run_location_filter');

  if (userLocation) { places({ container: userLocation }) }
  if (runStatLocation) { places({ container: runStatLocation }) }


  if (runLocationFilter) {
    let form = document.getElementById('runs_filter');
    var placesAutocomplete = places({
      container: run_location_filter
    })
    placesAutocomplete.on('change', function(e) {
      //Rails.fire(form, 'submit')
    });
    document.querySelector(".ap-input-icon, .ap-icon-clear").addEventListener("click", function(){
      let form = document.getElementById('runs_filter');
    })

  }
};


export {initAutocomplete}

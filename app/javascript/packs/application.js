import 'bootstrap';
import flatpickr from "flatpickr";
// import 'mapbox-gl/dist/mapbox-gl.css';
import places from 'places.js';
import $ from 'jquery'
import { initMapbox } from './init_mapbox';
initMapbox();

$(function () {
$('[data-toggle="tooltip"]').tooltip()
})


const initAutocomplete = () => {
  const userLocation = document.getElementById('user_location');
  const runStatLocation = document.getElementById('run_starting_point');
  if (userLocation) { places({ container: userLocation }) }
  if (runStatLocation) { places({ container: runStatLocation }) }
};


function loadFile(event) {
  var reader = new FileReader();
  reader.onload = function(){
    var output = document.getElementById('output');
    output.style.display ="block"
    output.src = reader.result;
  };
  reader.readAsDataURL(event.target.files[0]);
};


let photo_input = document.querySelector("#run_photo")
photo_input && document.querySelector("#run_photo").addEventListener("change", loadFile)
initAutocomplete()

let date_input = document.querySelector("#run_date")
date_input && date_input.flatpickr({
    enableTime: true,
    dateFormat: "d-m-Y H:i",
    minDate: "today"
}
);






var showInfoCard = document.querySelector("#show-info-card")
if (showInfoCard !== null){
  console.log("jkljkllkj")
  let showMap = document.querySelector("#show_map")
  let canvas = document.querySelector(".mapboxgl-canvas")
  showMap.style.maxHeight = showInfoCard.offsetHeight + "px"
}

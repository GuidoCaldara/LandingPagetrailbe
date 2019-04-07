import 'bootstrap';
import flatpickr from "flatpickr";
// import 'mapbox-gl/dist/mapbox-gl.css';
import places from 'places.js';
import $ from 'jquery'
import { initMapbox } from './init_mapbox';
import mapboxgl from 'mapbox-gl';

initMapbox();

$(function () {
$('[data-toggle="tooltip"]').tooltip()
})


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
      Rails.fire(form, 'submit')
    });
    document.querySelector(".ap-input-icon, .ap-icon-clear").addEventListener("change", function(){
      let form = document.getElementById('runs_filter');
      Rails.fire(form, 'submit')
    })


  }
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


let date_range_input = document.querySelector("#run-date-range")
date_range_input && date_range_input.flatpickr({
    mode: "range",
    enableTime: false,
    dateFormat: "d-m-Y",
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




const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
};



var mapElement = document.getElementById('index-map');

window.initIndexMap = function(element){
  if (element) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    window.indexMap = new mapboxgl.Map({
      container: 'index-map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });
    let markers = JSON.parse(element.dataset.markers);

    if (markers.length > 0){
      markers.forEach((marker) => {
        const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
          const element = document.createElement('div');
          element.className = 'marker';
          element.style.backgroundSize = 'contain';
          element.style.width = '25px';
          element.style.height = '25px';

        new mapboxgl.Marker()
          .setLngLat([ marker.lng, marker.lat ])
          .setPopup(popup)
          .addTo(indexMap);
      });
      fitMapToMarkers(indexMap, markers);

    }

  }
};

initIndexMap(mapElement);


window.updateMap = function(datas){
  let markers = JSON.parse(datas.replace(/&quot;/g,'"'))

  if (markers.length > 0){
    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
        const element = document.createElement('div');
        element.className = 'marker';
        element.style.backgroundSize = 'contain';
        element.style.width = '25px';
        element.style.height = '25px';
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(indexMap);
    });
    fitMapToMarkers(indexMap, markers);

  }

}



document.querySelector("#run-date-range").addEventListener("change", function(){
  let form = document.getElementById('runs_filter');
  "klòkòkòkòlkòlkkòlòkò"
  Rails.fire(form, 'submit')
})

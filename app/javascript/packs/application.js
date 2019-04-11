import 'bootstrap';
import flatpickr from "flatpickr";
// import 'mapbox-gl/dist/mapbox-gl.css';
import $ from 'jquery'
import { initMapbox } from './init_mapbox';
import { initIndexMap } from './index_map';
import { updateMap } from './index_map';
import { initAutocomplete } from './autocomplete';
import { loadFile } from './image_preview'
import mapboxgl from 'mapbox-gl';

//Map in show
initMapbox();
//Map in index
// var mapElement = document.getElementById('index-map');
// mapElement && initIndexMap(mapElement);
//Initialize tooltip in show
$(function () {
$('[data-toggle="tooltip"]').tooltip()
})
//Initialize autocomplete
initAutocomplete()
// Initialize Image Preview
let photo_input = document.querySelector("#run_photo")
photo_input && document.querySelector("#run_photo").addEventListener("change", loadFile)

// flatpickr
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
  let showMap = document.querySelector("#show_map")
  let canvas = document.querySelector(".mapboxgl-canvas")
  showMap.style.maxHeight = showInfoCard.offsetHeight + "px"
}







// form Index trigger
const dateInput = document.querySelector("#run-date-range")
dateInput && dateInput.addEventListener("change", function(e){
  const removeData = document.querySelector(".remove-date-icon")
  if (e.target.value == ""){
    removeData.style.display = "none"
  } else{
    removeData.style.display = "block"
  }
  removeData.addEventListener("click", () => {
    dateInput.value = ""
    //Rails.fire(form, 'submit')
  })
  let form = document.getElementById('runs_filter');
  //Rails.fire(form, 'submit')
})


window.addEventListener('DOMContentLoaded', (event) => {
  var mapElement = document.getElementById('index-map');
  if (mapElement){
    if (window.innerWidth > 1021){
      initIndexMap(mapElement, "index-map");
    } else {
      document.querySelector(".index-map-container").remove()
      initIndexMap(document.querySelector("#modal-index-map"), "modal-index-map" )
    }
  }

});

//
// document.querySelector('.map-modal-btn').addEventListener("click", function() {
//   console.log("lkòòlklklòklòklòkk");
//     indexMap.resize();
//   });

$('#indexMapModal').on('shown.bs.modal', function() {
  console.log("Lòklòòlkòlkò");
    indexMap.resize();
  });





const navBtn = document.querySelector("button, .navbar-toggler")
const links = document.querySelectorAll(".sidebar-link")
const sidebarContainer = document.querySelector("#sidebar-container")
const hideLink = (links) => {
  links.forEach((link) => {
    link.classList.toggle("sidebar-link-visible")
  })
}

navBtn && navBtn.addEventListener("click", () =>{
  document.querySelector("#sidebar-container").classList.toggle("sidebar-visible")
  document.querySelector("body").classList.toggle("no-overflow")
  hideLink(links)
})

sidebarContainer && sidebarContainer.addEventListener("click", () =>{
  if (document.querySelector("#sidebar-container").offsetWidth > 0){
     document.querySelector("#sidebar-container").classList.toggle("sidebar-visible")
     document.querySelector("body").classList.toggle("no-overflow")
     hideLink(links)
  }
})

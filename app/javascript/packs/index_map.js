import mapboxgl from 'mapbox-gl';

//center the map with multiple markers
const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
};




window.initIndexMap = function(element, map){
  if (element) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = element.dataset.mapboxApiKey;
    window.indexMap = new mapboxgl.Map({
      container: map,
      style: 'mapbox://styles/mapbox/streets-v10'
    });
    let markers = JSON.parse(element.dataset.markers);
    indexMap.scrollZoom.disable();
    indexMap.addControl(new mapboxgl.NavigationControl());

    if (markers.length > 0){
      markers.forEach((marker) => {
          const popup = new mapboxgl.Popup().setHTML(`<p class="small my-1">${marker.name}</p><p class="small my-1">${marker.distance}Km</p><p class="small my-1">${(marker.date).toString()}</p>`);
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
      console.log("inside indexmap");
      fitMapToMarkers(indexMap, markers);
    }
  }
};

window.updateMap = function(datas){
  var markers = JSON.parse(datas.replace(/&quot;/g,'"'))

  if (markers.length > 0){
    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(`<p class="small my-1">${marker.name}</p><p class="small my-1">${marker.distance}Km</p><p class="small my-1">${(marker.date).toString()}</p>`);
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


export { initIndexMap, updateMap }

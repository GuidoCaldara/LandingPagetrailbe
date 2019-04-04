import mapboxgl from 'mapbox-gl';

const initMapbox = () => {
  const mapElement = document.getElementById('show_map');
  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const lat = parseFloat(mapElement.dataset.latitude)
    const lng = parseFloat(mapElement.dataset.longitude)

    const map = new mapboxgl.Map({
      container: 'show_map',
      style: 'mapbox://styles/mapbox/streets-v10',
      maxZoom: 14
    });
    const bounds = new mapboxgl.LngLatBounds();
    bounds.extend([lng,lat])
    map.fitBounds(bounds)

    new mapboxgl.Marker()
  .setLngLat([lng,lat])
  .addTo(map);
  }
};

export { initMapbox };

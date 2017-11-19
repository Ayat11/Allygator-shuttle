var lat = 52.53;
var lng = 13.403;
var radius = 3500;
var positionCenter;
var vehicleIds = {};
var markersRecord = {};
var markersMap = [];
var svgPath;
var map;


function createCustomMarker(coords, map, title, oldPosition, newPosition) {
  var markerRotation = null;

  if (oldPosition && newPosition) {
    markerRotation = google.maps.geometry.spherical.computeHeading(oldPosition, newPosition);
  }

  var icon = {

    path: svgPath,
    fillColor: '#FF0000',
    fillOpacity: .6,
    anchor: new google.maps.Point(120, 250),
    strokeWeight: 0,
    scale: 0.07,
  }
  icon.rotation = markerRotation + 90;

  return new google.maps.Marker({
    position: coords,
    map: map,
    title: title,
    icon: icon
  });
}

function createMarker(coords, map, title) {
  var marker = new google.maps.Marker({
    position: coords,
    map: map,
    title: title
  });
  return marker;
}

function initMap() {
  map = new google.maps.Map($('#map-canvas')[0], {
    zoom: 14,
    center: positionCenter,
    mapTypeId: 'roadmap'
  });
}

function removeMarker(marker) {
  marker.setMap(null);
}

function clearMarkers() {

  for (var i = 0; i < markersMap.length; i++) {
    removeMarker(markersMap[i]);
  }
  markersMap = [];
}

function outOfBoundaries(position) {
  return (google.maps.geometry.spherical.computeDistanceBetween(positionCenter, position) > radius);
}

function updateMarkers() {
  clearMarkers();
  $.each(vehicleIds, function (id, location) {
    var previousMarker;
    if (markersRecord[id]) {
      previousMarker = markersRecord[id];
    }

    var position = new google.maps.LatLng(location['lat'], location['lng']);
    if (!outOfBoundaries(position)){
      var marker;
      if (previousMarker) {
        marker = createCustomMarker(
          position,
          map,
          'center',
          previousMarker.getPosition(),
          position);
      } else {
        marker = createCustomMarker(
          position,
          map,
          'center');
      }
      markersRecord[id] = marker;
      markersMap.push(marker)
    }
    
    // var markerCluster = new MarkerClusterer(map, markersMap,
    //   {imagePath: '../images/cluster/m'});

      
    // }  
  });
}

function hitDatabase() {
  $.ajax({
    type: 'GET',
    url: '/get_vehicles_updates',
    dataType: 'JSON',
    success: function (data) {
      vehicleIds = data.vehicles
    },
    error: function () {
      console.error('error');
    }
  });
  updateMarkers();
}

function initSVGPath() {
  $.ajax({
    url: '/assets/svg-car.svg',
    type: 'get',
    async: false,
    complete: function (response) {
      svgPath = response.responseText;
    }
  });
}


$(document).ready(function () {
  initSVGPath();
  positionCenter = new google.maps.LatLng(lat, lng);
  initMap();


      // var markerCluster = new MarkerClusterer(map, markersMap, {imagePath: '../images/m'});
      // console.log("markerCluster")
      // console.log(markerCluster)


  // need to hit the database every 5 seconds and get the new registered vehicles as well as the updated positions for each vehicle

  setInterval(hitDatabase, 3000);
});
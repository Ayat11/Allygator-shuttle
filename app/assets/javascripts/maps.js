var lat = 52.53;
var lng = 13.403;
var radius = 3500;
var positionCenter;
var vehicleIds = {};
var markersRecord = {};
var markersMap = [];
var map;

function createImage(url){
  var image = {
    url: url,
    size: new google.maps.Size(40, 40),
    origin: new google.maps.Point(0,0),
    anchor: new google.maps.Point(0, 20)
  };
  return image;
}

function createCustomMarker(coords,map,title){
  marker = new google.maps.Marker({
    position: coords,
    map: map,
    title: title,
    icon: createImage("/assets/car2.png")
  });
}

function createMarker(coords, map, title){
  var marker = new google.maps.Marker({
    position: coords,
    map: map,
    title: title
  });
  return marker;
}

// function createInfoWindow(text){
//   var infowindow = new google.maps.InfoWindow({
//     content: text
//   });
//   return infowindow;
// }

// var info = createInfoWindow("Congratulations!");
// google.maps.event.addListener(marker, 'click', function() {
//   info.open(map,marker);
// });
function initMap() {
  map = new google.maps.Map($('#map-canvas')[0], {
    zoom: 14,
    center: positionCenter,
    mapTypeId: 'roadmap'
  });
}

function removeMarker(marker){
  marker.setMap(null);
}

function clearMarkers() {
  
  for (var i = 0; i < markersMap.length; i++) {
    markersMap[i].setMap(null);
  }
  markersMap = [];
}

function outOfBoundaries(position){
  return (google.maps.geometry.spherical.computeDistanceBetween(positionCenter, position) > radius);
}

function updateMarkers(){
  console.log('markers before ', markersMap)
  clearMarkers();
  console.log('markers after ', markersMap)
  $.each(vehicleIds, function (id, location) {
    if (id in markersRecord){
      previousMarker = markersRecord[id];
      // calculate bearing
    }
    
    var position = new google.maps.LatLng(location['lat'], location['lng']);
    // if (!outOfBoundaries(position)){
      var marker = createMarker(position, map, 'center');
      markersRecord[id] = marker;
      markersMap.push(marker)
    // }  
  });
}

function hitDatabase(){
  $.ajax({
    type: 'GET',
    url: '/get_vehicles_updates',
    dataType:'JSON',
    success: function(data){
      console.log('hellooooo ', data.vehicles);
      vehicleIds = data.vehicles
    },
    error: function(){
      console.log('error');
    }
  });
 console.log(vehicleIds);
  updateMarkers();
}


$(document).ready(function(){
  positionCenter = new google.maps.LatLng(lat, lng);
  initMap();
  // need to hit the database every 5 seconds and get the new registered vehicles as well as the updated positions for each vehicle
  
  setInterval(hitDatabase, 3000);

  // var position = new google.maps.LatLng(lat, lng);
  // var marker = createCustomMarker(position, map, 'center')
});
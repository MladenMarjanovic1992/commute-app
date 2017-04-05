var geocoder;
var map;
var originLat = document.getElementById('origin-lat')
var originLong = document.getElementById('origin-long')
var destinationLat = document.getElementById('destination-lat')
var destinationLong = document.getElementById('destination-long')

function initMap() {
  geocoder = new google.maps.Geocoder();
  var mapOptions = {
    zoom: 8,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  map = new google.maps.Map(document.getElementById('map'), mapOptions);
    if (originLat != undefined) {
      marker1 = new google.maps.Marker({
        map: map,
        draggable: true,
        position: {
          lat: parseFloat(originLat.textContent),
          lng: parseFloat(originLong.textContent)
        }
      });
    
      marker2 = new google.maps.Marker({
        map: map,
        draggable: true,
        position: {
          lat: parseFloat(destinationLat.textContent),
          lng: parseFloat(destinationLong.textContent)
        }
      });
      var bounds = new google.maps.LatLngBounds();
      bounds.extend(marker1.getPosition());
      bounds.extend(marker2.getPosition());
      map.fitBounds(bounds);
    } else {
      map.setCenter(new google.maps.LatLng(44.787197, 20.457273));
    }
  
}

function codeAddress() {
  var originCity = document.getElementById('origin-city').value;
  var destinationCity = document.getElementById('destination-city').value;
  geocoder.geocode( { 'address': originCity}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
        marker1 = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
      });
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
  geocoder.geocode( { 'address': destinationCity}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      marker2 = new google.maps.Marker({
        map: map,
        position: results[0].geometry.location
      });
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
  var bounds = new google.maps.LatLngBounds();
  bounds.extend(marker1.getPosition());
  bounds.extend(marker2.getPosition());
  map.fitBounds(bounds);
}




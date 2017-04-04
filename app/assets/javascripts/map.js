var geocoder;
var map;
function initMap() {
  geocoder = new google.maps.Geocoder();
  var mapOptions = {
    zoom: 8,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  map = new google.maps.Map(document.getElementById('map'), mapOptions);
  marker1 = new google.maps.Marker({
    map: map,
    draggable: true,
    position: {
      lat: parseFloat(document.getElementById('origin-lat').textContent),
      lng: parseFloat(document.getElementById('origin-long').textContent)
    }
  });

  marker2 = new google.maps.Marker({
    map: map,
    draggable: true,
    position: {
      lat: parseFloat(document.getElementById('destination-lat').textContent),
      lng: parseFloat(document.getElementById('destination-long').textContent)
    }
  });

  var bounds = new google.maps.LatLngBounds();
  bounds.extend(marker1.getPosition());
  bounds.extend(marker2.getPosition())
  map.fitBounds(bounds);
}

function codeAddress() {
  var address = document.getElementById('origin-city').value;
  geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      map.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
      });
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}




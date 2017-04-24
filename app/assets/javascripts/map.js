var geocoder;
var map;
var marker1;
var marker2;
var markerCount = 0;
var originLat = document.getElementById('origin-lat')
var originLong = document.getElementById('origin-long')
var destinationLat = document.getElementById('destination-lat')
var destinationLong = document.getElementById('destination-long')
var originCity = document.getElementById('origin-city');
var destinationCity = document.getElementById('destination-city');

function initMap() {
  geocoder = new google.maps.Geocoder();
  var mapOptions = {
    zoom: 7,
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
        google.maps.event.addListener(map, 'click', function(event) {
          if (markerCount < 2 && marker1 == null) {
            marker1 = new google.maps.Marker({
                position: event.latLng,
                label: "A",
                map: map
            });
            markerCount++;
            geocodeLatLng(geocoder, map, marker1, originCity);
            marker1.addListener("dblclick", function() {
              marker1.setMap(null);
              marker1 = null;
              originCity.value = "";
              markerCount--;
            });
          } else if (markerCount < 2 && marker2 == null) {
            marker2 = new google.maps.Marker({
                position: event.latLng,
                label: "B",
                map: map
            });
            markerCount++;
            geocodeLatLng(geocoder, map, marker2, destinationCity);
            marker2.addListener("dblclick", function() {
              marker2.setMap(null);
              marker2 = null;
              destinationCity.value = "";
              markerCount--;
            });
          }
        }); 
        
      }
}

function geocodeLatLng(geocoder, map, marker, field) {
  var latlng = {lat: marker.position.lat(), lng: marker.position.lng()};
  geocoder.geocode({'location': latlng}, function(results, status) {
    if (status === 'OK') {
      if (results[1]) {
        field.value = results[1].formatted_address;
      } else {
        window.alert('No results found');
      }
    } else {
      window.alert('Geocoder failed due to: ' + status);
    }
  });
}

$(function() {
  $("#origin-city").geocomplete();
  $("#destination-city").geocomplete();
});


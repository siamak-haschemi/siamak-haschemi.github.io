var map;

function init() {
    map = L.map('map', {doubleClickZoom: false}).locate({setView: true, maxZoom: 16});

    L.tileLayer('https://tile.thunderforest.com/atlas/{z}/{x}/{y}.png?apikey={accessToken}', {
        attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, Imagery © <a href="http://www.thunderforest.com/">Thunderforest</a>',
        maxZoom: 18,
        id: 'thunderforest/atlas',
        accessToken: 'a794617134d14b1f82f1cd09d35bca51'
    }).addTo(map);

    // Fetch GeoJSON file
    fetch('./data/campgrounds.geojson')
        .then(function (response) {
            return response.json();
        })
        .then(function (data) {
            L.geoJSON(data, {onEachFeature: onEachFeature}).addTo(map);

            map.on('locationfound', onLocationFound);
            map.on('locationerror', onLocationError);

            var locateBtn = L.control({position: 'topright'});
            locateBtn.onAdd = function (map) {
                var div = L.DomUtil.create('div', '');
                div.innerHTML = '<button class="locate-btn">Locate Me</button>';
                div.firstChild.onmousedown = div.firstChild.ondblclick = L.DomEvent.stopPropagation;
                L.DomEvent.on(div.firstChild, 'click', L.DomEvent.stop).on(div.firstChild, 'click', function () {
                    map.locate({setView: true, maxZoom: 16});
                });
                return div;
            };
            locateBtn.addTo(map);
        })
        .catch(function (error) {
            console.log('Error loading the GeoJSON file: ' + error.message);
        });
};


function onLocationFound(e) {
    var radius = e.accuracy;

    L.marker(e.latlng).addTo(map)
        .bindPopup("You are within " + radius + " meters from this point").openPopup();

    L.circle(e.latlng, radius).addTo(map);
};

function onLocationError(e) {
    alert(e.message);
}

function onEachFeature(feature, layer) {

    if (feature.properties && feature.geometry) {
        var coords = feature.geometry.coordinates;
        // Assuming the GeoJSON is in the standard format where coordinates are [longitude, latitude]
        var lat = coords[1];
        var lng = coords[0];
        layer.bindPopup(createPopupContent(feature.properties, lat, lng));
    }

};

// Function to create a popup content string
function createPopupContent(properties, lat, lng) {
    var googleMapsUrl = `https://www.google.com/maps/dir/?api=1&destination=${lat},${lng}`;

    return `
        <strong>${properties.name}</strong><br>
        ${properties.description}<br>
        <a href="mailto:${properties.link}" target="_blank">${properties.link}</a><br>
        <a href="${googleMapsUrl}" target="_blank">Open in Google Maps</a>
    `;
};
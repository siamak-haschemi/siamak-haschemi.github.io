var map;

function init() {

    let open_topo_map = L.tileLayer.provider('OpenTopoMap');
    let osm_de = L.tileLayer.provider('OpenStreetMap.DE');
    let osm_france = L.tileLayer.provider('OpenStreetMap.France');
    let open_cycle_map = new L.TileLayer('https://tile.thunderforest.com/cycle/{z}/{x}/{y}{r}.png?apikey=db5ae1f5778a448ca662554581f283c5', {
        maxZoom: 18
    });


    let baseMaps = {
        "OpenTopoMap": open_topo_map,
        "OpenStreetMap.DE": osm_de,
        "OpenStreetMap.France": osm_france,
        "OpenCycleMap": open_cycle_map
    };

    let overlays = {//add any overlays here

    };

    map = L.map('map', {
        doubleClickZoom: false,
        zoomControl: false
    }).locate({setView: true, maxZoom: 18});

    osm_france.addTo(map);

    L.control.layers(baseMaps, overlays, {position: 'topleft'}).addTo(map);

    L.control.zoom({
        position: 'bottomright'
    }).addTo(map);

    L.tileLayer('https://tile.thunderforest.com/atlas/{z}/{x}/{y}.png?apikey={accessToken}', {
        attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, Imagery © <a href="http://www.thunderforest.com/">Thunderforest</a>',
        maxZoom: 18,
        id: 'thunderforest/atlas',
        accessToken: 'a794617134d14b1f82f1cd09d35bca51'
    }).addTo(map);

    let scale = L.control.scale({position: 'topright'}); // Creating scale control
    scale.addTo(map); // Adding scale control to the map

    var locateBtn = L.control({position: 'bottomright'});
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

    const provider = new window.GeoSearch.OpenStreetMapProvider();
    const search = new GeoSearch.GeoSearchControl({
        provider: provider,
        style: 'button',
        updateMap: true,
        autoClose: true,
        autoComplete: true, // optional: true|false  - default true
        autoCompleteDelay: 250, // optional: number      - default 250
    }); // Include the search box with usefull params. Autoclose and updateMap in my case. Provider is a compulsory parameter.

    map.addControl(search);


    // Fetch GeoJSON file
    fetch('./data/campgrounds.geojson')
        .then(function (response) {
            return response.json();
        })
        .then(function (data) {
            L.geoJSON(data, {onEachFeature: onEachFeature}).addTo(map);

            map.on('locationfound', onLocationFound);
            map.on('locationerror', onLocationError);
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
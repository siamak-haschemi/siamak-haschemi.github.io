var map;

function loadGeoJson(url, fillColor, L, map) {
    // Fetch GeoJSON file
    fetch(url)
        .then(function (response) {
            return response.json();
        })
        .then(function (data) {

            L.vectorGrid.slicer(data, {
                rendererFactory: L.svg.tile,
                vectorTileLayerStyles: {
                    sliced: function (properties, zoom) {
                        return {
                            fillColor: fillColor,
                            fillOpacity: 0.5,
                            stroke: false,
                            fill: true,
                            color: 'black',
                            radius: 11,
                            weight: 0,
                        }
                    }
                },
                interactive: true,
            })
                .on('click', function (e) {
                    L.popup()
                        .setContent(createPopupContent(e.layer.properties, e.latlng.lat, e.latlng.lng))
                        .setLatLng(e.latlng)
                        .openOn(map);
                })
                .addTo(map);
        })
        .catch(function (error) {
            console.log('Error loading the GeoJSON file: ' + error.message);
        });
}

function init() {
    map = L.map('map', {
        doubleClickZoom: false,
        zoomControl: false
    }).locate({setView: true, maxZoom: 18});

    let cartodbAttribution = '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, &copy; <a href="http://cartodb.com/attributions">CartoDB</a>';

    L.tileLayer('https://{s}.basemaps.cartocdn.com/light_nolabels/{z}/{x}/{y}.png', {
        attribution: cartodbAttribution,
        opacity: 1
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


    loadGeoJson('./data/campgrounds.geojson', "#ff7800", L, map);
    loadGeoJson('./data/bettundbike.geojson', "#556700", L, map);
    loadGeoJson('./data/ioverlander.geojson', "#0067FF", L, map);
    loadGeoJson('./data/alpacacamping.geojson', "#FF0000", L, map);
    loadGeoJson('./data/hinterland.geojson', "#FFFF00", L, map);

};


function onLocationFound(e) {
    let radius = e.accuracy;
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
    let googleMapsDirectionUrl = `https://www.google.com/maps/dir/?api=1&destination=${lat},${lng}&travelmode=bicycling`;
    let googleMapsPositionUrl = `https://www.google.com/maps/search/?api=1&query=${lat},${lng}`
    let googleMapsStreetViewUrl = `https://maps.google.com/maps?q=&layer=c&cbll=${lat},${lng}`
    let googleMapsStreetViewUrl2 = `comgooglemaps://?center=${lat},${lng}&mapmode=streetview`

    return `
        <strong>${properties.name}</strong><br>
        ${properties.description}<br>
        E-Mail: <a href="mailto:${properties.link}" target="_blank">${properties.link}</a><br>
        <hr/>
        Geo-Position: <pre>${lat},${lng}</pre>
        <a href="${googleMapsPositionUrl}" target="_blank">Open Map</a><br>
        <a href="${googleMapsDirectionUrl}" target="_blank">Get Directions</a><br>
        <a href="${googleMapsStreetViewUrl}" target="_blank">Street View</a><br>   
        <a href="${googleMapsStreetViewUrl2}" target="_blank">Street View (mobile)</a><br>               
        <hr/>
    `;
};
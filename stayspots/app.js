var map;

var vectorTileLayerStyles = {
    warmshowers: function (properties, zoom) {
        return {
            fillColor: "#FFFF00",
            fillOpacity: 0.8,
            stroke: true,
            fill: true,
            color: 'black',
            radius: 11,
            weight: 3,
        }
    },
    onenighttent: function (properties, zoom) {
        return {
            fillColor: "#EE7F00",
            fillOpacity: 0.8,
            stroke: true,
            fill: true,
            color: 'black',
            radius: 11,
            weight: 3,
        }
    },
    bettundbike: function (properties, zoom) {
        return {
            fillColor: "#B23C01",
            fillOpacity: 0.8,
            stroke: true,
            fill: true,
            color: 'black',
            radius: 11,
            weight: 3,
        }
    },
    ioverlander: function (properties, zoom) {
        return {
            fillColor: "#8F4EC7",
            fillOpacity: 0.8,
            stroke: true,
            fill: true,
            color: 'black',
            radius: 11,
            weight: 3,
        }
    },
    alpacacamping: function (properties, zoom) {
        return {
            fillColor: "#137071",
            fillOpacity: 0.8,
            stroke: true,
            fill: true,
            color: 'black',
            radius: 11,
            weight: 3,
        }
    },
    hinterland: function (properties, zoom) {
        return {
            fillColor: "#000000",
            fillOpacity: 0.8,
            stroke: true,
            fill: true,
            color: 'black',
            radius: 11,
            weight: 3,
        }
    }
};

L.Control.ImportGPX = L.Control.extend({
    onAdd: function(map) {
        var label = L.DomUtil.create('label');
        label.innerHTML = 'Import GPX';
        label.style.backgroundColor = 'white';
        label.style.padding = '5px';
        label.setAttribute('for', 'fileinput'); // Ensure this matches the input's id
        label.style.cursor = 'pointer'; // Make it look clickable

        var input = L.DomUtil.create('input');
        input.id = 'fileinput';
        input.type = 'file';
        input.style.display = 'none';
        input.onchange = e => {
            var file = e.target.files[0];
            if (file) {
                var reader = new FileReader();
                reader.onload = function(event) {
                    let gpx = event.target.result; // This is the GPX content
                    new L.GPX(gpx, {async: true}).on('loaded', function(e) {
                        map.fitBounds(e.target.getBounds());
                    }).addTo(map);
                };
                reader.readAsText(file);
            }
        };


        var container = L.DomUtil.create('div');
        container.appendChild(label);
        container.appendChild(input);

        return container;
    },

    onRemove: function(map) {
        // Nothing to remove
    }
});

L.control.importgpx = function(opts) {
    return new L.Control.ImportGPX(opts);
}

function loadGeoJson(name, url, L, map) {
    // Fetch GeoJSON file
    fetch(url)
        .then(function (response) {
            return response.json();
        })
        .then(function (data) {
            L.vectorGrid.slicer(data, {
                maxZoom: 18,
                buffer: 500,
                vectorTileLayerName: name,
                rendererFactory: L.svg.tile,
                zIndex: 3,
                vectorTileLayerStyles: vectorTileLayerStyles,
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

    // let open_topo_map = L.tileLayer.provider('OpenTopoMap',
    //     {
    //         zIndex: 1
    //     });
    let osm_de = L.tileLayer.provider('OpenStreetMap.DE',
        {
            zIndex: 1
        });

    // let osm_france = L.tileLayer.provider('OpenStreetMap.France',
    //     {
    //         zIndex: 1
    //     });

    let open_cycle_map = new L.TileLayer('https://tile.thunderforest.com/cycle/{z}/{x}/{y}{r}.png?apikey=db5ae1f5778a448ca662554581f283c5', {
        maxZoom: 18,
        zIndex: 1
    });
    //
    // let baseMaps = {
    //     "OpenTopoMap": open_topo_map,
    //     "OpenStreetMap.DE": osm_de,
    //     "OpenStreetMap.France": osm_france,
    //     "OpenCycleMap": open_cycle_map
    // };


    // let overlays = {//add any overlays here
    //
    // };

    map = L.map('map', {
        doubleClickZoom: false,
        zoomControl: false
    });

    map.on('locationfound', onLocationFound);
    map.on('locationerror', onLocationError);

    map.locate({setView: true, maxZoom: 18});

    // L.control.layers(overlays, {position: 'topleft'}).addTo(map);

    L.control.zoom({
        position: 'bottomright'
    }).addTo(map);

    osm_de.addTo(map);

    let scale = L.control.scale({position: 'topright'}); // Creating scale control
    scale.addTo(map); // Adding scale control to the map

    let locateBtn = L.control({position: 'bottomright'});
    locateBtn.onAdd = function (map) {
        var div = L.DomUtil.create('div', '');
        div.innerHTML = '<button class="locate-btn">Locate Me</button>';
        div.firstChild.onmousedown = div.firstChild.ondblclick = L.DomEvent.stopPropagation;
        L.DomEvent.on(div.firstChild, 'click', L.DomEvent.stop).on(div.firstChild, 'click', function () {
            map.locate({setView: true, maxZoom: 18});
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

    L.control.importgpx({ position: 'topleft' }).addTo(map);


    loadGeoJson('onenighttent', './data/o.geojson', L, map);
    loadGeoJson('bettundbike', './data/b.geojson', L, map);
    loadGeoJson('ioverlander', './data/i.geojson', L, map);
    loadGeoJson('alpacacamping', './data/a.geojson', L, map);
    loadGeoJson('hinterland', './data/h.geojson', L, map);
    loadGeoJson('warmshowers', './data/w.geojson', L, map);
};


function onLocationFound(e) {
    let radius = e.accuracy / 2;
    let location = e.latlng
    L.marker(location).addTo(map)
    L.circle(location, radius).addTo(map);
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
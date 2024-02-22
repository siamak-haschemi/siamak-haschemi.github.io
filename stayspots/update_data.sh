#!/bin/sh

rm -rf data/*

curl -o \
  data/campgrounds.geojson \
  https://1nitetent.com/app/themes/1nitetent/assets/json/campgrounds.geojson

curl 'https://www.bettundbike.de/unterkuenfte-finden/karte?tx_bettundbikesearch_map_search%5Baction%5D=api&tx_bettundbikesearch_map_search%5Bcontroller%5D=MapSearch&tx_typoscriptrendering%5Bcontext%5D=%7B%22record%22%3A%22tt_content_4207%22%2C%22path%22%3A%22tt_content.list.20.bettundbikesearch_map_search%22%7D&cHash=4d70e3b32012596e678d757f1df45e3d' \
  -H 'authority: www.bettundbike.de' \
  -H 'accept: application/json, text/javascript, */*; q=0.01' \
  -H 'accept-language: en-US,en;q=0.9,de;q=0.8' \
  -H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' \
  -H 'origin: https://www.bettundbike.de' \
  -H 'referer: https://www.bettundbike.de/unterkuenfte-finden/karte' \
  -H 'sec-ch-ua: "Not A(Brand";v="99", "Google Chrome";v="121", "Chromium";v="121"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "macOS"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36' \
  -H 'x-requested-with: XMLHttpRequest' \
  --data-raw 'tx_bettundbikesearch_map_search%5Bparams%5D=%7B%22endpoint%22%3A%22get_results_in_bounds%22%2C%22options%22%3A%7B%22bounds%22%3A%7B%22min%22%3A%7B%22lat%22%3A44.67519809026754%2C%22lng%22%3A0.6730162885652293%7D%2C%22max%22%3A%7B%22lat%22%3A57.65488696363009%2C%22lng%22%3A17.239837813935658%7D%7D%2C%22filters%22%3A%7B%22criteria%22%3A%5B%5D%2C%22countries%22%3A%5B%5D%2C%22states%22%3A%5B%5D%2C%22regions%22%3A%5B%5D%2C%22cities%22%3A%5B%5D%2C%22routes%22%3A%5B%5D%7D%7D%7D' \
  --compressed > data/bettundbike.json

jq '{ type: "FeatureCollection", features: [ .[] | { type: "Feature", properties: { name: .title, description: ("From <b><a href=\"https://www.bettundbike.de" + .website + "\">Bett und Bike</a>:</b>"), link: "", "marker-color": "#00FF00", "marker-symbol": "commercial"}, geometry: { type: "Point", coordinates: [ .position.lng, .position.lat ] } }] }' data/bettundbike.json > data/bettundbike.geojson

curl -o data/ioverlander.json 'https://www.ioverlander.com/places/search.json?searchboxmin=46,5&searchboxmax=56,15' \
  -H 'authority: www.ioverlander.com' \
  -H 'accept: application/json, text/javascript, */*; q=0.01' \
  -H 'accept-language: en-US,en;q=0.9,de;q=0.8' \
  -H 'cookie: cf_clearance=FKi9jABgRcjsvePX4ck_PLYui8lX8Zdr5hUiA3YgfOY-1708624023-1.0-AXhXni1xcc18u4dKDG1Eah4DTFm0FDwIrs1BMGdK5wO3EMezN8LKn7kFlYy+Od3BSngh8asGndU1Ucm+9/CsOpY=; _i_overlander_on_rails_session=fxkVvZaBweFGBLNMZ2eHEk88ruNXSPaoz%2Fwivlz8b2GVE3RI%2FJzwsFrAwPXjeWcVJi2fswp8IwIMmzZQ1g3yTLttYZUOs1mLRjK37lZ9qZGyQuEwKZZj20ZddaaXcn5LNk0BUL4lSOtyLhv6WSbAWsUJLBp67JKdOeJ1k08xBuhLkyrO%2ByW7vX9E8yg1joArs8aiUizuWQbJqyeB5Ys%2Fx2bVae7%2BOY2u7flApQhH3qpgPdxSjc%2BS1l8AvY1ovML76im%2BM8YB2DKIzyw5lf5Cg6eS3zQd%2B1vJSWhU%2FadmOQ%2F6Sq6Vcsf7d0NVRdYF6nR4LBbZkImZ1mgULUQOK1qJ%2BfY2Tx0auqyHK5lCBdTj5QnSVAcTzJBJKe88bg2DZQoTqyb7DyUn--b%2BZ%2BlEvncZcru4Qs--Bd3ncRsMXnF4Drzg%2F4rx5Q%3D%3D' \
  -H 'referer: https://www.ioverlander.com/' \
  -H 'sec-ch-ua: "Not A(Brand";v="99", "Google Chrome";v="121", "Chromium";v="121"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "macOS"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36' \
  -H 'x-csrf-token: 29ZCinHJtKI1r-bXNmcN-CWaaORyK_y9N0XXXQexnDBQjo0JhArKCXuwmRQ3go8_LOtPIFxjA4D2Ujzg35Cz5Q' \
  -H 'x-requested-with: XMLHttpRequest' \
  --compressed

jq '{ type: "FeatureCollection", features: [ .[] | { type: "Feature", properties: { name: .name, description: ("From <b><a href=\"https://www.ioverlander.com/places/" + (.id|tostring) + "\">iOverlander</a>:</b>" + "<br>" + .description + "<br>date_verified: " + .date_verified+ "<br>" + "category: " + .category), link: "", "marker-color": "#00FF00", "marker-symbol": "commercial" }, geometry: { type: "Point", coordinates: [ .location.longitude, .location.latitude ] } }] }' data/ioverlander.json > data/ioverlander.geojson

####################

curl 'https://search.alpacacamping.de/api/search?page=1&count=10000&language=de&property_type=1&min_lat=46.10820385478601&min_long=5.866315000000213&max_lat=56.08554613029534&max_long=15.041831999999658' \
  -H 'authority: search.alpacacamping.de' \
  -H 'accept: */*' \
  -H 'accept-language: en-US,en;q=0.9,de;q=0.8' \
  -H 'cache-control: no-cache' \
  -H 'origin: https://www.alpacacamping.de' \
  -H 'pragma: no-cache' \
  -H 'referer: https://www.alpacacamping.de/' \
  -H 'sec-ch-ua: "Not A(Brand";v="99", "Google Chrome";v="121", "Chromium";v="121"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "macOS"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-site' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36' \
  -H 'x-api-key: fdf9FJK70Jskk897FHKssd99r' \
  --compressed > data/alpacacamping.json

  jq '{ type: "FeatureCollection", features: [ .hits[] | { type: "Feature", properties: { name: .name, description: ("From <b><a href=\""+ .detail_page_link + "\">aplacacamping</a></b><br><img width=\"200px\" src=\"" + .medium_cover_photo + "\"/>"), link: "", "marker-color": "#00FF00", "marker-symbol": "commercial" }, geometry: { type: "Point", coordinates: [ .property_address.longitude, .property_address.latitude ] } }] }' data/alpacacamping.json > data/alpacacamping.geojson
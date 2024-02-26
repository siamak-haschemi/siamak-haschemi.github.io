#!/bin/sh

#rm -rf data/*
#
#curl -o \
#  data/campgrounds.geojson \
#  https://1nitetent.com/app/themes/1nitetent/assets/json/o.geojson
#
#curl 'https://www.bettundbike.de/unterkuenfte-finden/karte?tx_bettundbikesearch_map_search%5Baction%5D=api&tx_bettundbikesearch_map_search%5Bcontroller%5D=MapSearch&tx_typoscriptrendering%5Bcontext%5D=%7B%22record%22%3A%22tt_content_4207%22%2C%22path%22%3A%22tt_content.list.20.bettundbikesearch_map_search%22%7D&cHash=4d70e3b32012596e678d757f1df45e3d' \
#  -H 'authority: www.bettundbike.de' \
#  -H 'accept: application/json, text/javascript, */*; q=0.01' \
#  -H 'accept-language: en-US,en;q=0.9,de;q=0.8' \
#  -H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' \
#  -H 'origin: https://www.bettundbike.de' \
#  -H 'referer: https://www.bettundbike.de/unterkuenfte-finden/karte' \
#  -H 'sec-ch-ua: "Not A(Brand";v="99", "Google Chrome";v="121", "Chromium";v="121"' \
#  -H 'sec-ch-ua-mobile: ?0' \
#  -H 'sec-ch-ua-platform: "macOS"' \
#  -H 'sec-fetch-dest: empty' \
#  -H 'sec-fetch-mode: cors' \
#  -H 'sec-fetch-site: same-origin' \
#  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36' \
#  -H 'x-requested-with: XMLHttpRequest' \
#  --data-raw 'tx_bettundbikesearch_map_search%5Bparams%5D=%7B%22endpoint%22%3A%22get_results_in_bounds%22%2C%22options%22%3A%7B%22bounds%22%3A%7B%22min%22%3A%7B%22lat%22%3A44.67519809026754%2C%22lng%22%3A0.6730162885652293%7D%2C%22max%22%3A%7B%22lat%22%3A57.65488696363009%2C%22lng%22%3A17.239837813935658%7D%7D%2C%22filters%22%3A%7B%22criteria%22%3A%5B%5D%2C%22countries%22%3A%5B%5D%2C%22states%22%3A%5B%5D%2C%22regions%22%3A%5B%5D%2C%22cities%22%3A%5B%5D%2C%22routes%22%3A%5B%5D%7D%7D%7D' \
#  --compressed > data/b.json
#
#jq '{ type: "FeatureCollection", features: [ .[] | { type: "Feature", properties: { name: .title, description: ("From <b><a href=\"https://www.bettundbike.de" + .website + "\">Bett und Bike</a>:</b>"), link: "", "marker-color": "#00FF00", "marker-symbol": "commercial"}, geometry: { type: "Point", coordinates: [ .position.lng, .position.lat ] } }] }' data/bettundbike.json > data/bettundbike.geojson
#
#########################
#
#curl -o data/ioverlander.json 'https://www.ioverlander.com/places/search.json?searchboxmin=42,-9&searchboxmax=53,22' \
#  -H 'authority: www.ioverlander.com' \
#  -H 'accept: application/json, text/javascript, */*; q=0.01' \
#  -H 'accept-language: en-US,en;q=0.9,de;q=0.8' \
#  -H 'cookie: cf_clearance=FKi9jABgRcjsvePX4ck_PLYui8lX8Zdr5hUiA3YgfOY-1708624023-1.0-AXhXni1xcc18u4dKDG1Eah4DTFm0FDwIrs1BMGdK5wO3EMezN8LKn7kFlYy+Od3BSngh8asGndU1Ucm+9/CsOpY=; _i_overlander_on_rails_session=fxkVvZaBweFGBLNMZ2eHEk88ruNXSPaoz%2Fwivlz8b2GVE3RI%2FJzwsFrAwPXjeWcVJi2fswp8IwIMmzZQ1g3yTLttYZUOs1mLRjK37lZ9qZGyQuEwKZZj20ZddaaXcn5LNk0BUL4lSOtyLhv6WSbAWsUJLBp67JKdOeJ1k08xBuhLkyrO%2ByW7vX9E8yg1joArs8aiUizuWQbJqyeB5Ys%2Fx2bVae7%2BOY2u7flApQhH3qpgPdxSjc%2BS1l8AvY1ovML76im%2BM8YB2DKIzyw5lf5Cg6eS3zQd%2B1vJSWhU%2FadmOQ%2F6Sq6Vcsf7d0NVRdYF6nR4LBbZkImZ1mgULUQOK1qJ%2BfY2Tx0auqyHK5lCBdTj5QnSVAcTzJBJKe88bg2DZQoTqyb7DyUn--b%2BZ%2BlEvncZcru4Qs--Bd3ncRsMXnF4Drzg%2F4rx5Q%3D%3D' \
#  -H 'referer: https://www.ioverlander.com/' \
#  -H 'sec-ch-ua: "Not A(Brand";v="99", "Google Chrome";v="121", "Chromium";v="121"' \
#  -H 'sec-ch-ua-mobile: ?0' \
#  -H 'sec-ch-ua-platform: "macOS"' \
#  -H 'sec-fetch-dest: empty' \
#  -H 'sec-fetch-mode: cors' \
#  -H 'sec-fetch-site: same-origin' \
#  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36' \
#  -H 'x-csrf-token: 29ZCinHJtKI1r-bXNmcN-CWaaORyK_y9N0XXXQexnDBQjo0JhArKCXuwmRQ3go8_LOtPIFxjA4D2Ujzg35Cz5Q' \
#  -H 'x-requested-with: XMLHttpRequest' \
#  --compressed
#
#jq '{ type: "FeatureCollection", features: [ .[] | { type: "Feature", properties: { name: .name, description: ("From <b><a href=\"https://www.ioverlander.com/places/" + (.id|tostring) + "\">iOverlander</a>:</b>" + "<br>" + .description + "<br>date_verified: " + .date_verified+ "<br>" + "category: " + .category), link: "", "marker-color": "#00FF00", "marker-symbol": "commercial" }, geometry: { type: "Point", coordinates: [ .location.longitude, .location.latitude ] } }] }' data/i.json > data/ioverlander.geojson
#
#####################
#
#curl 'https://search.alpacacamping.de/api/search?page=1&count=10000&language=de&property_type=1&min_lat=42.52981433693957&min_long=-9.996562389927476&max_lat=53.547656401470704&max_long=22.698750110072524' \
#  -H 'authority: search.alpacacamping.de' \
#  -H 'accept: */*' \
#  -H 'accept-language: en-US,en;q=0.9,de;q=0.8' \
#  -H 'cache-control: no-cache' \
#  -H 'origin: https://www.alpacacamping.de' \
#  -H 'pragma: no-cache' \
#  -H 'referer: https://www.alpacacamping.de/' \
#  -H 'sec-ch-ua: "Not A(Brand";v="99", "Google Chrome";v="121", "Chromium";v="121"' \
#  -H 'sec-ch-ua-mobile: ?0' \
#  -H 'sec-ch-ua-platform: "macOS"' \
#  -H 'sec-fetch-dest: empty' \
#  -H 'sec-fetch-mode: cors' \
#  -H 'sec-fetch-site: same-site' \
#  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36' \
#  -H 'x-api-key: fdf9FJK70Jskk897FHKssd99r' \
#  --compressed > data/alpacacamping.json
#
#  jq '{ type: "FeatureCollection", features: [ .hits[] | { type: "Feature", properties: { name: .name, description: ("From <b><a href=\""+ .detail_page_link + "\">aplacacamping</a></b><br><img width=\"200px\" src=\"" + .medium_cover_photo + "\"/>"), link: "", "marker-color": "#00FF00", "marker-symbol": "commercial" }, geometry: { type: "Point", coordinates: [ .property_address.longitude, .property_address.latitude ] } }] }' data/alpacacamping.json > data/a.geojson
#
#  ###################
#
#  curl 'https://api.hinterland.camp/location?page=0&pageSize=10000&sw_lat=42.52981433693957&sw_lng=-9.996562389927476&ne_lat=53.547656401470704&ne_lng=22.698750110072524&view=map&status=2' \
#    -H 'authority: api.hinterland.camp' \
#    -H 'accept: */*' \
#    -H 'accept-language: en-US,en;q=0.9,de;q=0.8' \
#    -H 'cache-control: no-cache' \
#    -H 'hl-lang: de' \
#    -H 'origin: https://hinterland.camp' \
#    -H 'pragma: no-cache' \
#    -H 'sec-ch-ua: "Not A(Brand";v="99", "Google Chrome";v="121", "Chromium";v="121"' \
#    -H 'sec-ch-ua-mobile: ?0' \
#    -H 'sec-ch-ua-platform: "macOS"' \
#    -H 'sec-fetch-dest: empty' \
#    -H 'sec-fetch-mode: cors' \
#    -H 'sec-fetch-site: same-site' \
#    -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36' \
#    --compressed > data/hinterland.json
#
#  jq '{ type: "FeatureCollection", features: [ .content[] | { type: "Feature", properties: { name: .title, description: ("From <b><a href=\"https://hinterland.camp/locations/"+ (.id|tostring) + "\">hinterland</a></b><br>" + .description), link: "", "marker-color": "#00FF00", "marker-symbol": "commercial" }, geometry: { type: "Point", coordinates: [ .position.longitude, .position.latitude ] } }] }' data/hinterland.json > data/h.geojson


####################

function warmshowers() {

  if [ -f ./data/warmshowers_$1.json ]; then
    echo "File ./data/warmshowers_$1.json exists!"
  else
    echo "File ./data/warmshowers_$1.json does not exists! Will download ..."

    curl 'https://de.warmshowers.org/services/rest2/hosts/by_location' \
      -H 'authority: de.warmshowers.org' \
      -H 'accept: application/json, text/javascript, */*; q=0.01' \
      -H 'accept-language: en-US,en;q=0.9,de;q=0.8' \
      -H 'cache-control: no-cache' \
      -H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' \
      -H 'origin: https://de.warmshowers.org' \
      -H 'pragma: no-cache' \
      -H 'referer: https://de.warmshowers.org/search' \
      -H 'sec-ch-ua: "Not A(Brand";v="99", "Google Chrome";v="121", "Chromium";v="121"' \
      -H 'sec-ch-ua-mobile: ?0' \
      -H 'sec-ch-ua-platform: "macOS"' \
      -H 'sec-fetch-dest: empty' \
      -H 'sec-fetch-mode: cors' \
      -H 'sec-fetch-site: same-origin' \
      -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36' \
      -H 'x-csrf-token: pZ9XnJAu7-Fn-NEpYMDZwZAZjf2NVNNr3-eRdw2Enfg' \
      -H 'x-requested-with: XMLHttpRequest' \
      --data-raw "$2&limit=2000&showinactivemembers=&maxcyclists=&lodging=&food=&other-logistics=&local-services=" \
      --compressed > ./data/warmshowers_$1.json

      sleep 5
  fi
}

warmshowers "0" "minlat=51.634899032542066&maxlat=52.64123271194841&minlon=11.655389724151926&maxlon=13.534051833526926&centerlat=52.14090802749245&centerlon=12.594720778839426"
warmshowers "1" "minlat=50.92018000082711&maxlat=51.94240504204647&minlon=10.499078688995676&maxlon=12.377740798370676&centerlat=51.43415165546225&centerlon=11.438409743683176"
warmshowers "2" "minlat=50.04461990256902&maxlat=51.08610261869502&minlon=9.046136794464426&maxlon=10.924798903839426&centerlat=50.568238823916445&centerlon=9.985467849151926"
warmshowers "3" "minlat=49.25149545965941&maxlat=50.310219716592584&minlon=7.5849551538394255&maxlon=9.463617263214426&centerlat=49.78374957844783&centerlon=8.524286208526926"
warmshowers "4" "minlat=48.509147259401&maxlat=49.58383141648415&minlon=7.2141665796206755&maxlon=9.092828688995676&centerlat=49.049392868424775&centerlon=8.153497634308176"
warmshowers "5" "minlat=47.86090708514505&maxlat=48.94938513120001&minlon=6.6675967554019255&maxlon=8.546258864776926&centerlat=48.40805815659814&centerlon=7.6069278100894255"
warmshowers "6" "minlat=47.373991490880584&maxlat=48.47274195342605&minlon=5.9177798608706755&maxlon=7.7964419702456755&centerlat=47.92628420958022&centerlon=6.8571109155581755"
warmshowers "7" "minlat=47.24922335599365&maxlat=48.35059369812832&minlon=5.1707095483706755&maxlon=7.0493716577456755&centerlat=47.802827275505834&centerlon=6.1100406030581755"
warmshowers "8" "minlat=46.68694587030154&maxlat=47.80005994885476&minlon=4.6653384546206755&maxlon=6.5440005639956755&centerlat=47.2464266682578&centerlon=5.6046695093081755"
warmshowers "9" "minlat=46.547341651130765&maxlat=47.66335545106799&minlon=4.1077823022769255&maxlon=5.9864444116519255&centerlat=47.10827338295874&centerlon=5.0471133569644255"
warmshowers "10" "minlat=46.01585090385406&maxlat=47.14284540387561&minlon=3.9182681421206755&maxlon=5.7969302514956755&centerlat=46.582276448993966&centerlon=4.8575991968081755"
warmshowers "11" "minlat=45.42525372903576&maxlat=46.56433976829144&minlon=3.8441104272769255&maxlon=5.7227725366519255&centerlat=45.99772773443413&centerlon=4.7834414819644255"
warmshowers "12" "minlat=44.68017932198746&maxlat=45.83435199929313&minlon=3.9512271264956755&maxlon=5.8298892358706755&centerlat=45.260198300031725&centerlon=4.8905581811831755"
warmshowers "13" "minlat=43.94122241625091&maxlat=45.11017086570501&minlon=4.0253848413394255&maxlon=5.9040469507144255&centerlat=44.528629000515814&centerlon=4.9647158960269255"
warmshowers "14" "minlat=43.33097481853034&maxlat=44.5119832936951&minlon=4.0391177514956755&maxlon=5.9177798608706755&centerlat=43.92440974265144&centerlon=4.9784488061831755"
warmshowers "15" "minlat=42.90393837239199&maxlat=44.09330889504621&minlon=4.3549746850894255&maxlon=6.2336367944644255&centerlat=43.50155237394524&centerlon=5.2943057397769255"

jq -n 'reduce inputs as $d (.; .accounts += $d.accounts)' ./data/warmshowers_*.json > ./data/warmshowers_merged.json

jq '{ type: "FeatureCollection", features: [ .accounts[] | { type: "Feature", properties: { name: .name, description: ("From <b><a href=\"https://de.warmshowers.org/user/"+ (.uid|tostring) + "\">Wamshowers</a></b><br>" + .fullname + "<br>" + .street + "<br>" + .city + "<br>"), link: "", "marker-color": "#00FF00", "marker-symbol": "commercial" }, geometry: { type: "Point", coordinates: [ .longitude, .latitude ] } }] }' ./data/warmshowers_merged.json > ./data/w.geojson

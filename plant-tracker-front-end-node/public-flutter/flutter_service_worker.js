'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "3c3f34c232baa297dcfb57ca037dfd1a",
"assets/AssetManifest.json": "eb4ed8a414489f685f7f067588e23fc1",
"assets/assets/config/dev.json": "6c0044566a24321c3603cdc481e28a9d",
"assets/assets/config/prod.json": "399a8934724c5a966785c72320fa6b17",
"assets/assets/images/africa.jpg": "27fc2c6667bd5bd7bba8117fafe28d86",
"assets/assets/images/animals.jpg": "2e218a94e7842a946d772082ac8c5590",
"assets/assets/images/antarctica.jpg": "71e86242fca831839833d1caa23f107e",
"assets/assets/images/aquatic.jpg": "17a3908f385144c2f75a8a436772d6bc",
"assets/assets/images/aquatic_plants/anubias.jpg": "6d9725abbb3ae9cc972822562ac56545",
"assets/assets/images/aquatic_plants/bucephalandra.jpg": "999710c21682158480dd8a6f6cdbd7ca",
"assets/assets/images/aquatic_plants/java-fern.jpg": "49575d26fd4dee8092bfaf39bfbc5780",
"assets/assets/images/aquatic_plants/rotala-rotundifolia-singapore-blood-red.jpg": "c19cf7580732cd177ae60e6dc584fc9e",
"assets/assets/images/aquatic_plants/rotala_green.jpg": "2f9c3fe1a825b807135f4586ceb10461",
"assets/assets/images/aquatic_plants/valisnaria.jpg": "3be53a57d6dfb07b0e90eb5e574c5a2b",
"assets/assets/images/asia.jpg": "bbcf97c1be29e77360e8407b7e2eaa05",
"assets/assets/images/australia.jpg": "6170e8a703652c6b814dca7020050086",
"assets/assets/images/background.png": "0564de0c80dbcae74ffce0f6a09dc3c0",
"assets/assets/images/background1.jpg": "1d3484cd9306763e1fc1f347b57239e6",
"assets/assets/images/cover.jpg": "e1e4b2e46b8d6eabb7330afb0c0d30ff",
"assets/assets/images/epified.jpg": "41b3a66c9c650de53edebbb80d637822",
"assets/assets/images/epified_plants/AirPlant.jpg": "3563ec7518a5cfedb82f38257f32cbf9",
"assets/assets/images/epified_plants/Alamy.jpg": "ff569053fceec78bae006d6e83082739",
"assets/assets/images/epified_plants/anubias.jpg": "d6bb556a0e6a6d9a0334438e78f54807",
"assets/assets/images/epified_plants/birdplant.jpg": "47ce6fef8eae835617bbece6ef6abd5e",
"assets/assets/images/epified_plants/Britanica.jpg": "a464759ce995b518f7d191f2e61410e5",
"assets/assets/images/epified_plants/bromilia.jpg": "c841654ba8699e24d4ce8063a447789e",
"assets/assets/images/epified_plants/bucephalandra-pygmaea.jpg": "1ac6cb9abee1bb3ce2da4c8bffd879ae",
"assets/assets/images/europe.jpg": "29a721b78efc7f928faf042c88806468",
"assets/assets/images/login.png": "e56b841924ac729935e858cb59535fb7",
"assets/assets/images/moss/FlameMoss.jpg": "59ba4c4ba1f83d90c7baa813b3e973c6",
"assets/assets/images/moss/Java-moss.jpg": "e2933660632280abd0bb286b157b2bf4",
"assets/assets/images/moss/Mini_pelia.jpg": "65d8351708076f2e1db6338a17129f36",
"assets/assets/images/moss/Peacock-Moss.jpg": "20f0cad71311369810edaf023e000df2",
"assets/assets/images/moss/pearl.jpg": "fa9116574e915bb70dd8713621e0f905",
"assets/assets/images/moss/riccardia-chamedryfolia.jpg": "0f45f4371ab67f6e36cda658f0a3c68e",
"assets/assets/images/moss.jpg": "b5d5137d544d4acffd7c0b8d35d261ac",
"assets/assets/images/north_america.jpg": "867d729d34a03bf38136bd45954ec218",
"assets/assets/images/photography.jpeg": "b0d14d6d4a94d33404a7df1344e7533b",
"assets/assets/images/south_america.jpg": "1920c86e11a06921b339f00ff1d0ddea",
"assets/assets/images/test1.jpeg": "9bb4e188581240286417187e232c4b38",
"assets/assets/images/test2.jpeg": "11346c7dce688552f9b834067e2120d5",
"assets/assets/images/test3.jpeg": "74e1950d7c75cce212743bfd5a0bf432",
"assets/assets/images/trekking.jpg": "283eae13ae9587874b93fed5c9b4a118",
"assets/assets/images/tropical.jpg": "2c6b6fb1ccb4840d40177f1d4eb62fc0",
"assets/assets/images/tropical_plants/AGLEIL.jpg": "d0a4feb6d219770639135b8f46d4897b",
"assets/assets/images/tropical_plants/AGLKRE.jpg": "31a3730453c053701c57a389a9dd7a8a",
"assets/assets/images/tropical_plants/AGLNIG.jpg": "15ce113490464c87a7d55b6f902225c3",
"assets/assets/images/tropical_plants/AGLSIAAUR.jpg": "04a0aaddf40a18fa3ab19f34ca5fb30e",
"assets/assets/images/tropical_plants/AGLTOT.jpg": "8a0684e1f100ed3457b7ac8157267e4e",
"assets/assets/images/tropical_plants/ALOPOL.jpg": "91c1e64a7887e06d4e41ea186c24a4a2",
"assets/FontManifest.json": "daf1f817658c2d4328a27ae7e3af9150",
"assets/fonts/Electrolize-Regular.ttf": "1be3e0aaeb2bbd1985615a49da7f2eaf",
"assets/fonts/MaterialIcons-Regular.otf": "629fb9059ca4804626c139ae470e51b1",
"assets/fonts/Montserrat-Regular.ttf": "ee6539921d713482b8ccd4d0d23961bb",
"assets/NOTICES": "bbe807c89cd540a24119248b48970a7a",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "5caccb235fad20e9b72ea6da5a0094e6",
"canvaskit/canvaskit.wasm": "d9f69e0f428f695dc3d66b3a83a4aa8e",
"canvaskit/chromium/canvaskit.js": "ffb2bb6484d5689d91f393b60664d530",
"canvaskit/chromium/canvaskit.wasm": "393ec8fb05d94036734f8104fa550a67",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "3644d14f5053dcb19dd4c8ca549e4619",
"/": "3644d14f5053dcb19dd4c8ca549e4619",
"js/keycloak-adapter.js": "2d10694662b5223a215c25e84f843563",
"main.dart.js": "db8c4e4b88c218cfca9824cced76209c",
"manifest.json": "695d04ec4e1b7a96bd8917e6604201ee",
"version.json": "bc38bca369ee63c64a093e4eba820207"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}

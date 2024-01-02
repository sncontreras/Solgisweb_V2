'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "229fe8f46ec0535ebad9605b74caadc3",
"assets/AssetManifest.json": "6df83944803a79487215d139a78d8f1a",
"assets/assets/gifs/loader-gris.gif": "28a6b978bb5c41dbc14d243e08a21bf2",
"assets/assets/gifs/loader.gif": "3b4e109d6b621ed5a9249769afbd4dfa",
"assets/assets/gifs/loading.gif": "e3aea2df77f76ec479bb2a819e95f8c3",
"assets/assets/jpgs/background-login.jpg": "c6c037e886ae5d1d2e9682cabfc99682",
"assets/assets/jpgs/torre.jpg": "b95836cc05db811f5186a7a219d8b0ab",
"assets/assets/pngs/ALMAFIN.png": "aa48d98ca9948a89fdcd7f2c8be5d3a1",
"assets/assets/pngs/AUSTRAL.png": "fa3f9c757d95fd288eeb9ef270e26d5f",
"assets/assets/pngs/BAYOVAR.png": "02986dffd501d9bb9abca5d17a658e1f",
"assets/assets/pngs/bravopapa.png": "a5635dfdb984f38bc6f84d5553fc2564",
"assets/assets/pngs/CAPRICORNIO.png": "dd1fbf847a711ec3821d45139bad2820",
"assets/assets/pngs/cargo.png": "64f2047912aa8adcc23347f369501df3",
"assets/assets/pngs/CENTINELA.png": "abbd28136c9c929750d6517663c82485",
"assets/assets/pngs/CHEC.png": "85fed72ee37f377c0e3dc726126bee95",
"assets/assets/pngs/CITIKOLD.png": "92318640451edb5a7e5af7b750eb769d",
"assets/assets/pngs/CONPEPAC.png": "ab7fb1455fd0162eb1b7be5bceb0b3b4",
"assets/assets/pngs/COREMASA.png": "46189e1801766580babd8a801662c001",
"assets/assets/pngs/COSCO.png": "1a62967e011178c3595758821374c298",
"assets/assets/pngs/CREC%252010.png": "b3c58770c041dbb36f0577b50c5ca7fc",
"assets/assets/pngs/DEL%2520VALLE%2520CORP.png": "498931956fe6aa711793bd8004e65603",
"assets/assets/pngs/DOIL%2520INTERNATIONAL.png": "4371ee4b7e119b75b72feb77a68000c0",
"assets/assets/pngs/DOIL%2520TRANSPORTES.png": "e96d167633601533866f83a605ca6f68",
"assets/assets/pngs/ECOPACKING%2520CARTONES.png": "1c66c58d82ae2475977330834bf48434",
"assets/assets/pngs/ECOPACKING.png": "6f67b2298ccece0f7718bd65f5feb552",
"assets/assets/pngs/ENGIE.png": "fd98e2ab628e62e9d84cadf9840aafb6",
"assets/assets/pngs/EXALMAR.png": "bafb3c6f82c361e5e255835701243b57",
"assets/assets/pngs/HAYDUK.png": "eea34a244d1958229e9c89760eac2ec8",
"assets/assets/pngs/icon-solmar-login.png": "3c453dc515fa9c6a4f5f2527e84e8873",
"assets/assets/pngs/IMAGE.png": "1da7e4bd3247a127b5490ea0b9a5a41b",
"assets/assets/pngs/LIGURIA.png": "eb169dd235f9c59cec783b65cc2822a0",
"assets/assets/pngs/MARNETS.png": "77e65ae2ad4f7ee3ef79432219a91cd8",
"assets/assets/pngs/MONTE%2520AZUL%2520CENTRO.png": "6389fcccacf63bf0997c7cd58ce8e0c4",
"assets/assets/pngs/MONTE%2520AZUL%2520SUR.png": "6389fcccacf63bf0997c7cd58ce8e0c4",
"assets/assets/pngs/MONTE%2520AZUL.png": "6389fcccacf63bf0997c7cd58ce8e0c4",
"assets/assets/pngs/MOTA-ENGIL%2520PERU%2520S.A..png": "af48c2dd52babcda91c8819bd7123c6c",
"assets/assets/pngs/no-image-create.png": "1bdef0b5837fe56734fd7d7d93a83ee5",
"assets/assets/pngs/no-image-rectangle.png": "452bd16aa785355d1ffc96bd11b5d92b",
"assets/assets/pngs/no-image.png": "0682e5a1ebe7550670f76a063bdb7311",
"assets/assets/pngs/operador.png": "e5161b3b86fb2129c7d08bb907111fde",
"assets/assets/pngs/OPORSA.png": "2b36ccffa3e49a43b46c19ed7cd84e61",
"assets/assets/pngs/PELAYO.png": "5ea380f674c0702a2b07ef900f9563f9",
"assets/assets/pngs/people.png": "c83cf975512fb54d745d2e7360925b74",
"assets/assets/pngs/PERU%2520FROST.png": "102b493200c0dc492886d3f9cebff304",
"assets/assets/pngs/PERUVIAN%2520SEA%2520FOOD.png": "84df7eecd10b08c74c6c7b822e6bdd7a",
"assets/assets/pngs/PEUSAC.png": "1532d6066c76fe651047f3d8cb5b2319",
"assets/assets/pngs/RH.png": "b4fae06cb3b76053eee1769778a0f676",
"assets/assets/pngs/ROQUEL.png": "f734551dbb8d585ada472adf4ef1f725",
"assets/assets/pngs/saasa.png": "5632f9706bde7526d57e3fa812a48937",
"assets/assets/pngs/SALAVERRY.png": "5c6d91af493dd02ea5e3cca236e6b4b7",
"assets/assets/pngs/SAN%2520MARTIN%2520CONTR.%2520GRALES..png": "1436389065fc4c041f67397a8098f060",
"assets/assets/pngs/SHOUGANG.png": "db4519d50c60a09425aa347695b4e51c",
"assets/assets/pngs/SHOUXIN.png": "03ee1857cfcd811b4b0c21f99c7c5d31",
"assets/assets/pngs/SOLGIS.png": "a4d3c2016fc56fd307a224b4d702a58f",
"assets/assets/pngs/SOLGOD.png": "549ddeee2fd5eeaedd5a30ff4a22f0be",
"assets/assets/pngs/SOLMAR.png": "a49ea9fbc753a53e90d73fefdbd70745",
"assets/assets/pngs/TASA.png": "f1158592812943dc2b515cca80da011a",
"assets/assets/pngs/TERRANO.png": "87adad5c224345e716f59cfd91a5dae7",
"assets/assets/pngs/YOBEL%2520SCM.png": "2ceec7f5c95e1a26393ce5e9fd65467b",
"assets/assets/svgs/alert.svg": "a4327f419bd03b889da1edb5a629f20a",
"assets/assets/svgs/bravopapa.svg": "e004b92628b6dd6c3a59205b2d8144ea",
"assets/assets/svgs/cargo-003.svg": "6e2e84876d1f65104271cabc97553eff",
"assets/assets/svgs/cargo.svg": "588f17494446e5e91947bf7a92c106ca",
"assets/assets/svgs/driver-no-found.svg": "d19e623b4f7d98e788bfd71ac67a2e00",
"assets/assets/svgs/girl-phone.svg": "66e14a9f9adfac7acde7380394216a7f",
"assets/assets/svgs/guard.svg": "1560a10095f6d1c4c13731b1f298c09e",
"assets/assets/svgs/image.svg": "c298eca21450c3b025dade1a0da1445a",
"assets/assets/svgs/patrol.svg": "0653e4834aad6a057b7ae0e4ab8baeae",
"assets/assets/svgs/pending-page.svg": "059ab3cf8d6f533bee7a46c1403ba1aa",
"assets/assets/svgs/people.svg": "15891b090a02a3445890de26ab1f6503",
"assets/assets/svgs/phone-page.svg": "7addaf70b0927461d5f0b877338aafb1",
"assets/assets/svgs/refused-page.svg": "912ae754da9928d40c4cf54be6e7030a",
"assets/assets/svgs/solgod.svg": "74af5a78eda0d37ce551c243c10e8b6a",
"assets/assets/svgs/work.svg": "c7e5b77362829b008716317c8cb473eb",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/fonts/MaterialIcons-Regular.otf": "fe8029c051036eebf17ceefe9eef0cae",
"assets/NOTICES": "2edf7efc999920db03a4aa5b6ed40050",
"assets/packages/awesome_snackbar_content/assets/back.svg": "ba1c3aebba280f23f5509bd42dab958d",
"assets/packages/awesome_snackbar_content/assets/bubbles.svg": "1df6817bf509ee4e615fe821bc6dabd9",
"assets/packages/awesome_snackbar_content/assets/types/failure.svg": "cb9e759ee55687836e9c1f20480dd9c8",
"assets/packages/awesome_snackbar_content/assets/types/help.svg": "7fb350b5c30bde7deeb3160f591461ff",
"assets/packages/awesome_snackbar_content/assets/types/success.svg": "6e273a8f41cd45839b2e3a36747189ac",
"assets/packages/awesome_snackbar_content/assets/types/warning.svg": "cfcc5fcb570129febe890f2e117615e0",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "48e5f7406fe0f4cfe4733e8cfab06f60",
"assets/packages/flutter_image_compress_web/assets/pica.min.js": "6208ed6419908c4b04382adc8a3053a2",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "7d8d4306237845212974af924b1ab33d",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "c2281cf0a22c29917ebf755ba9d11e50",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "8e0542a7d7eec9dbada78c8605db3ccd",
"assets/packages/im_stepper/assets/me.jpg": "487511e754834bdf2e6771376d59707e",
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
"index.html": "dd9c677b76ed53eb8f045f3a7ec6f794",
"/": "dd9c677b76ed53eb8f045f3a7ec6f794",
"main.dart.js": "b124410cd639242db6b790a8c7f50917",
"manifest.json": "e652da5f5be8e371fd636053ee10878c",
"version.json": "7182ec03d66f2742ef2ea3468c7693cb"};
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

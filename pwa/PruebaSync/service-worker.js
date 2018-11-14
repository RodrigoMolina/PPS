var dataCacheName = "DataAPI"
var cacheName = 'cacheName';
var filesToCache = [
  '.',
  'index.html'
];

self.addEventListener('install', function(e) {

  e.waitUntil(
    caches.open(cacheName).then(function(cache) {
      return cache.addAll(filesToCache);
    })
  );
});

self.addEventListener('activate', function(e) {


  e.waitUntil(
    caches.keys().then(function(keyList) {
      return Promise.all(keyList.map(function(key) {
        if (key !== cacheName && key !== dataCacheName) {
          return caches.delete(key);
        }
      }));
    })
  );

    return self.clients.claim();
});


self.addEventListener('sync', function (event) {
  if (event.tag === 'image-fetch') {
    event.waitUntil(fetchDogImage());
  }
});

function fetchDogImage () {
    fetch('./clear.png')
      .then(function (response) {
        return response;
      })
      .then(function (text) {
        console.log('Aca esta la respuesta :)', text);
      })
      .catch(function (error) {
        console.log('La respuesta fallo :/', error);
      });
  }
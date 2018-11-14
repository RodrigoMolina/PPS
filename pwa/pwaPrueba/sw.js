var dataCacheName = "DataAPI"
var cacheName = 'cacheName';
var filesToCache = [
  '.',
  'index.html',
  'users.html',
  'albums.html',
  'init.js',
  'icons/images.png',
  'icons/1.svg',
  'styles/stylesheet.css',
  'manifest.json'
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



self.addEventListener('fetch', function(e) {
 

  if (e.request.url.indexOf(dataUrl) > -1) {
   
    e.respondWith(
      caches.open(dataCacheName).then(function(cache) {
        return fetch(e.request).then(function(response){
          cache.put(e.request.url, response.clone());
          return response;
        });
      })
    );
    
  } else {
   
    e.respondWith(
      caches.match(e.request).then(function(response) {
        return response || fetch(e.request);
      })
    );
  }
});


self.addEventListener('sync', function(e) {
  if (event.tag == 'myFirstSync') {
    event.waitUntil(doSomeStuff());

    // doSomeStuff() devuelve una promesa con la respuesta de si puede hacerlo o no
    //si falla se reprograma la sincronizacion
  }
});

self.addEventListener('push', function(e) {
 
});

/*

self.addEventListener('notificationclick', function(event) {
  // assuming only one type of notification right now
  event.notification.close();
  clients.openWindow(`${location.origin}/wiki/${event.notification.data}`);
});

self.addEventListener('message', event => {
  if (event.data == 'skipWaiting') {
    self.skipWaiting();
  }
});

*/
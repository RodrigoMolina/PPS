//==========================================================================

if ('serviceWorker' in navigator) {
  navigator.serviceWorker.register('sw.js').then(function(registration) {
    
    console.log('Registration succeeded.');
  }).catch(function(error) {
   
    console.log('Registration failed with ' + error);
  });
  
  // Then later, request a one-off sync:
  navigator.serviceWorker.ready.then(function(swRegistration) {
    return swRegistration.sync.register('myFirstSync');
  });

};

//==========================================================================

    var text="notfound";
    var estaEnCache;

    
    if ('caches' in window) {
    
      caches.match('https://jsonplaceholder.typicode.com/posts').then(function(response) {
        if (response) {
          response.json().then(function updateFromCache(json) {
  
       
            if(text!="found")
            {
              for (var j = 0; j < json.length; j++){
                
                document.getElementById('miContainer').innerHTML += "<div itemscope itemtype = 'http://schema.org/BlogPosting'><h1>"+ json[j].title + "</h1>" ;
                document.getElementById('miContainer').innerHTML += "<button  onclick=' showID( " + json[j].id + " ) '> Ver mas </button></div>" ;
              } 
            }
            
  

          });
        }
        
      });
     
      

    }



      fetch('https://jsonplaceholder.typicode.com/posts')
        .then( function(response ){
          return response.json();
        }).then(function (json){
          for (var i = 0; i < json.length; i++) {
         
              
                document.getElementById('miContainer').innerHTML += "<div itemscope itemtype = 'http://schema.org/BlogPosting' ><h1>"+ json[i].title + "</h1>" ;
                document.getElementById('miContainer').innerHTML += "<button  onclick=' showID( " + json[i].id + " ) '> Ver mas </button></div>" ;
          } 
           text = "found";
          });




       

        function showID(id){
         
          ruta = 'https://jsonplaceholder.typicode.com/posts/'+ id;
                   fetch(ruta)
            .then(function(respuesta){
                  return respuesta.json();
            }).then(function (post){
                    document.getElementById('miContainer').innerHTML = "<div itemscope itemtype = 'http://schema.org/BlogPosting'><h1>"+ post.title + "</h1><p articleBody= 'body' >" + post.body + "</p></div>" ;

                    document.getElementById('miContainer').innerHTML += "<h3>Comentarios</h3>";
                    document.getElementById('miContainer').innerHTML += "<button  onclick=' Comentarios( " + id + " ) '> Mostrar Comentarios </button></div>" ;
                    text="found";
            });
        }

        function Comentarios(id){
            fetch('https://jsonplaceholder.typicode.com/posts/'+ id +'/comments')
            .then(function(respuesta){
                  return respuesta.json();
            }).then(function (coment){
                    
                for (var i = 0; i < coment.length; i++) {
               
              
                  document.getElementById('comment').innerHTML += "<div ><h4> Comentario hecho por: "+ coment[i].name + "</h4>" ;
                  document.getElementById('comment').innerHTML += "<h4> E-mail: "+ coment[i].email + "</h4>" ;

                  document.getElementById('comment').innerHTML += "<p> Dijo: "+ coment[i].body + "</p></div></n></n>" ;
               }  
                text="found";

            });


        }


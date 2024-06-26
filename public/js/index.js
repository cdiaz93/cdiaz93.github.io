//Inicializar FancyBox Image
// Fancybox.bind("[data-fancybox]", {});


// new WOW().init();
var typed;

$(window).load(function() {
    $(".loader").fadeOut("slow");
    $(".titulo_nombre").addClass(" animate__animated animate__bounceInDown animate__delay-1s");

    typed = new Typed('#typed-container-1', {
        strings: parrafoCompleto,
        typeSpeed: 30,
        backSpeed: 1,
        startDelay: 2000, //Milisegundos
        onComplete: function() {
            if (!verPortafolioClicked) {
                animacionesPagina();
            }
        } 
    });
    
});




var primerElemento = document.querySelector("ol.carousel_list > li");

// Seleccionar todos los elementos <li> dentro del <ol> con la clase "carousel_list"
var elementosLi = document.querySelectorAll("ol.carousel_list > li");

// Iterar sobre todos los elementos <li> excepto el primero
for (var i = 1; i < elementosLi.length; i++) {
    // Eliminar cada elemento <li> excepto el primero
    elementosLi[i].parentNode.removeChild(elementosLi[i]);
}


// Inicializar Tooltip de Bootstrap 5 
var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
  return new bootstrap.Tooltip(tooltipTriggerEl)
})


//------------------------------------------------
// TYPED_JS - ANIMACION DE ESCRITURA PARA TEXTOS 
//-------------------------------------------------------------------------------------------------------------------------------------------
// Texto que se usara con typedJS


// var parrafo1= [
//     "Desarrollador web, con experiencia en la creación de interfaces digitales atractivas y funcionales."
// ];
// var parrafo2= [
//     "He contribuido al desarrollo de sitios web corporativos y aplicativos web de diversa índole."
// ];

var parrafoCompleto =[
    "Desarrollador web, con experiencia en la creación de interfaces digitales atractivas y funcionales. <br><br>"+
    "He participado en el desarrollo de sitios web corporativos y aplicativos web de diversa índole."
];

var habilidades =[
    "Fronted",
    "Backend",
    "Bases Datos",
    "Otros",
]


//Bandera para saber si ejecutar o no onComplete de typed
let verPortafolioClicked = false; 

function eliminarCursor(){
    var cursorElement = document.querySelector('.typed-cursor');
    if (cursorElement) {
        cursorElement.remove();
    }
}





// Cambia la velocidad  de escritura de typedJS para Parrafos
document.getElementById('ver_portafolio').addEventListener('click', function() {
    verPortafolioClicked = true; 
    typed.typeSpeed = 0;
    typed.stop();
});
//-------------------------------------------------------------------------------------------------------------------------------------------


// Evento que maneja el click en el botón
document.addEventListener("DOMContentLoaded", function() {
    // Agregar evento de click al botón ver_portafolio
    var botonScroll = document.getElementById("ver_portafolio");
    botonScroll.addEventListener("click", animacionesPagina);
});

function desplazarseHacia(id){
    section = document.getElementById(id);
    section.scrollIntoView({ behavior: "smooth", block: "start" });
}



//Elimina todas las class que se usan para activar animaciones de Animate.css
function eliminarAnimaciones(){

    contenedorPortafolio = document.getElementById("contenido_portafolio");
    contenedorPortafolio.classList.remove("animate__animated", "animate__bounce");

    // Animaciones para elementos del protafolio 
    var diseno = document.querySelectorAll(".diseno");
    diseno.forEach(function(elemento) {
        elemento.classList.remove("animate__animated", "animate__swing", "animate__fast");
    });

    var programacion = document.querySelectorAll(".programacion");
    programacion.forEach(function(elemento) {
        elemento.classList.remove("animate__animated", "animate__swing", "animate__fast");
    });

    var macro = document.querySelectorAll(".macro");
    macro.forEach(function(elemento) {
        elemento.classList.remove("animate__animated", "animate__swing", "animate__fast");
    });


}

//Muestra variedad de animaciones en la presentación del portafolio.
//La velocidad de animacion varia dependiendo si la animacion sigue su curso normal o si se omite la presentacion (clic al boton ver_portafolio)
function animacionesPagina() {

    var tiempo= 1000;  //Milisegundos
    var section;
    var netwok;
    var dowmArrow;
    var btnPortafolio;
    var contenedorPortafolio;
    var presentacion;
    var cursor 
    var bienvenido;
    var habilidades;
    var titulo_habilidades;
    var footer;

    // -----------------------------------------------------------------------------------
    // NOTA: 'verPortafolioClicked' se usa para determinar si se omitio la presentacion
    // -----------------------------------------------------------------------------------

    // 1. Desaparece el boton de ver portafoilio y realiza animacion de salida
    presentacion = document.getElementById("typed-container-1");
    presentacionDiv = document.getElementById("div-typed-container");
    btnPortafolio = document.getElementById("ver_portafolio");

 
    // NOTA: Provoca une fecto visual en la parte final de la pagina no deseada, se elimino la animacion 
    setTimeout(function() {
        btnPortafolio.disabled = true;
        btnPortafolio.className += (" animate__animated animate__bounceOut");
        if(verPortafolioClicked){
            // presentacionDiv.classList.add("animate__animated", "animate__bounceOut");
            cursor = document.querySelectorAll('.typed-cursor');
            cursor.forEach(function(cur) { cur.remove();});
        }
    }, 0);
    // ----------------------------------------------------------------------------------------------------

    // 2. Hace visible y realiza animacion de entrada para los botones de network_options (Github, CV)
    setTimeout(function() {
        if(verPortafolioClicked){
            presentacionDiv.classList.add("d-none");
            presentacion.innerHTML  = parrafoCompleto;
            presentacionDiv.classList.remove("animate__animated", "animate__bounceOut", "d-none");
            presentacionDiv.classList.add("animate__animated", "animate__bounceIn");
        }
      
        netwok = document.getElementById("network_options");
        netwok.classList.remove('d-none');
        if(!verPortafolioClicked){
            netwok.className += (" animate__animated animate__backInLeft");
        }else{
            netwok.className += (" animate__animated animate__backInLeft");
        }
    }, tiempo);

    // 3. Hace visible y realiza animacion de entrada para el boton flecha abajo
    setTimeout(function() {
        dowmArrow = document.getElementById("down_arrow");
        dowmArrow.classList.remove('d-none');

        // Verificar si el elemento habilidades es visible en la pantalla
        var habilidades = document.querySelector('#section-habilidades');
        var rect = habilidades.getBoundingClientRect();
        var isVisible = (rect.top >= 0 && rect.bottom <= window.innerHeight);
        if (isVisible) {
            habilidades.classList.remove('d-none');
            new WOW().init(); // Iniciar la animación con Wow.js
        }
 
        // Hace visible la seccion de habilidades, portafolio y footer
        section = document.getElementById("contenido_portafolio");
        section.classList.remove('d-none');

        footer = document.getElementById("footer");
        footer.classList.remove('d-none');
      
        

        // presentacion = document.getElementById("section-presentacion");
        // presentacion.classList.remove('vh-100');

        if(!verPortafolioClicked){
            // bienvenido.classList.add("animate__animated", "animate__fadeInUpBig");
            dowmArrow.classList.add("animate__animated", "animate__zoomIn");

        }else{
            // bienvenido.classList.add("animate__animated", "animate__backInUp");
            dowmArrow.classList.add("animate__animated", "animate__backInUp");
        }

        // titulo_habilidades = document.getElementById("titulo-habilidades");
        // titulo_habilidades.classList.add("wow", "animate__animated", "animate__bounceInDown");
    }, tiempo*2);




    // 4. Solo si verPortafolioClicked=true : Desplaza el scroll hacia la seccion del contenido_portafolio, y realiza animación de rapidez
    if(verPortafolioClicked){
        setTimeout(function() {
            

            // btnPortafolio.className += (" d-none");
            section.scrollIntoView({ behavior: "auto", block: "start" });
            
            // animacion para el contenedor del portafolio 
            contenedorPortafolio = document.getElementById("contenido_portafolio");
            contenedorPortafolio.classList.remove('d-none');
            contenedorPortafolio.className += (" animate__animated animate__bounce");
    
            // Animaciones para elementos del protafolio 
            var diseno = document.querySelectorAll(".diseno");
            diseno.forEach(function(elemento) {
                elemento.classList.add("animate__animated", "animate__swing", "animate__fast");
            });
    
            var programacion = document.querySelectorAll(".programacion");
            programacion.forEach(function(elemento) {
                elemento.classList.add("animate__animated", "animate__swing", "animate__fast");
            });
    
            var macro = document.querySelectorAll(".macro");
            macro.forEach(function(elemento) {
                elemento.classList.add("animate__animated", "animate__swing", "animate__fast");
            });
        }, tiempo*3); 

        setTimeout(function() {
            eliminarAnimaciones();
        }, tiempo*4); 

       

    }
   
}


// -------------------------------------------------------------------------------------
//CHORRERAS DE PERICO: Permite alternar la imagen fullscreen entre original/modificada
// -------------------------------------------------------------------------------------
function cambiarVersion(version){
    var elementos = document.getElementsByClassName("version-text");
    var imagen = document.getElementById("version-img");
    if (version==1){
        for (var i = 0; i < elementos.length; i++) {
            elementos[i].textContent = "Versión Original";
        }
        imagen.src = "public/images/pagina_competa/chorrerasV1_fullscrren.png";

    }else if(version ==2){
        for (var i = 0; i < elementos.length; i++) {
            elementos[i].textContent = "Versión Modificada";
        }
        imagen.src = "public/images/pagina_competa/chorrerasV2_fullscrren.png";
    }
}
// -------------------------------------------------------------------------------------



// -----------------------------------------
// FILTRO PERSONALIZADO
// ---------------------------------------------------------------------------
function mostrar(divId) {
    
    var disenos = document.querySelectorAll(".diseno");
    var programaciones = document.querySelectorAll(".programacion");
    var macros = document.querySelectorAll(".macro" );

    if(divId === "todas"){
        disenos.forEach(function(diseno){
            diseno.classList.remove('fade-out');
            diseno.classList.add('fade-in');
            diseno.style.display = 'block';
        });
        programaciones.forEach(function(programacion){
            programacion.classList.remove('fade-out');
            programacion.classList.add('fade-in');
            programacion.style.display = 'block';
        });
        macros.forEach(function(macro){
            macro.classList.remove('fade-out');
            macro.classList.add('fade-in');
            macro.style.display = 'block';
        });

    }else if(divId === "diseno"){
        disenos.forEach(function(diseno){
            diseno.classList.remove('fade-out');
            diseno.classList.add('fade-in');
            diseno.style.display = 'block';
        });
        programaciones.forEach(function(programacion){
            programacion.classList.remove('fade-in');
            programacion.classList.add('fade-out');
            programacion.style.display = 'none';
        });
        macros.forEach(function(macro){
            macro.classList.remove('fade-in');
            macro.classList.add('fade-out');
            macro.style.display = 'none';
        });

    }else if(divId === "programacion"){
        programaciones.forEach(function(programacion){
            programacion.classList.remove('fade-out');
            programacion.classList.add('fade-in');
            programacion.style.display = 'block';
        });
        disenos.forEach(function(diseno){
            diseno.classList.remove('fade-in');
            diseno.classList.add('fade-out');
            diseno.style.display = 'none';
        });
        macros.forEach(function(macro){
            macro.classList.remove('fade-out');
            macro.classList.add('fade-in');
            macro.style.display = 'none';
        });
        
    }else if(divId === "macro"){
        macros.forEach(function(macro){
            macro.classList.remove('fade-out');
            macro.classList.add('fade-in');
            macro.style.display = 'block';
        });
        programaciones.forEach(function(programacion){
            programacion.classList.remove('fade-in');
            programacion.classList.add('fade-out');
            programacion.style.display = 'none';
        });
        disenos.forEach(function(diseno){
            diseno.classList.remove('fade-out');
            diseno.classList.add('fade-in');
            diseno.style.display = 'none';
        });
        
    }
}
// ---------------------------------------------------------------------------

   
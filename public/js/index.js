






//Inicializar FancyBox Image
Fancybox.bind("[data-fancybox]", {});








//En el div princial de información un proyecto pasa al siguiente div para mostrar más detalles.
function siguiente(){
    const tiempo= 1000;
    informacion1 = document.getElementById("informacion-1");
    informacion2 = document.getElementById("informacion-2");
    informacion1.classList.add("animate__animated", "animate__fadeOutDownBig", "animate__fast");
    setTimeout(function() {
        informacion1.classList.remove("animate__animated", "animate__fadeOutDownBig", "animate__fast");
        informacion1.classList.add( "d-none");
        informacion2.classList.add("animate__animated", "animate__fadeInUpBig", "animate__fast");
        informacion2.classList.remove( "d-none");
    }, tiempo);
}

//En el div princial de información un proyecto pasa al siguiente div para mostrar más detalles.
function atras(){
    const tiempo= 1000;
    informacion1 = document.getElementById("informacion-1");
    informacion2 = document.getElementById("informacion-2");

    informacion2.classList.remove("animate__animated", "animate__fadeInUpBig", "animate__fast");
    informacion2.classList.add("animate__animated", "animate__fadeOutDownBig", "animate__fast");

    setTimeout(function() {
        informacion2.classList.remove("animate__animated", "animate__fadeOutDownBig", "animate__fast");
        informacion2.classList.add( "d-none");
        informacion1.classList.add("animate__animated", "animate__fadeInUpBig", "animate__fast");
        informacion1.classList.remove( "d-none");
    }, tiempo);
}


//------------------------------------------------
// TYPED_JS - ANIMACION DE ESCRITURA PARA TEXTOS 
//-------------------------------------------------------------------------------------------------------------------------------------------
// Texto que se usara con typedJS

var textoCompletoCorto =[
    "Hola aqui va la descripción corta de mi persona, describo mis habildiades <br> invito a portafolio."
];
var textoCompleto  = [
    "<h4>¡Hola! Soy Carlos Diaz. </h4> <br>"+ 
    "Un apasionado diseñador web con experiencia en la creación de interfaces digitales atractivas y funcionales. "+
    "A lo largo de mi carrera, he contribuido al desarrollo de sitios web corporativos y aplicativos web de diversa índole. <br><br>"+
    "Mis habilidades incluyen trabajar con una variedad de tecnologías web, incluyendo HTML, CSS, JavaScript, PHP y los stacks "+ 
    "MERN (MongoDB, Express.js, React.js, Node.js) y MEVN (MongoDB, Express.js, Vue.js, Node.js). " +
    "Tambien, he demostrado mis habilidades en la creación de macros en Excel usando VBA, para la automatización de procesos. <br><br>"+
    "Te invito a explorar mi portafolio, donde encontrarás algunos trabajos en los que he participado.",
];


//Bandera para saber si ejecutar o no onComplete de typed
let verPortafolioClicked = false; 

//Usar typeJs para mostar 'textoCompleto' en secuencia. en el tag con id="typed-container"
const typed = new Typed('#typed-container-1', {
    strings: textoCompleto,
    typeSpeed: 30,
    backSpeed: 1,
    startDelay: 1200, //Milisegundos
    onComplete: function() {
        if (!verPortafolioClicked) {
            // var netwok = document.getElementById("network_options");
            // netwok.classList.remove('d-none');
            // netwok.className += (" animate__animated animate__backInLeft");
            animacionesPagina();
            console.log('animacion typed COMPLETADA!!');
        }
    } 
});

// Cambia la velocidad  de escritura de typedJS 
document.getElementById('ver_portafolio').addEventListener('click', function() {
    verPortafolioClicked = true; 
    typed.typeSpeed = 0;
    typed.start();
});
//-------------------------------------------------------------------------------------------------------------------------------------------


// Evento que maneja el click en el botón
document.addEventListener("DOMContentLoaded", function() {
    // Agregar evento de click al botón ver_portafolio
    var botonScroll = document.getElementById("ver_portafolio");
    botonScroll.addEventListener("click", animacionesPagina);
});

function desplazarseAlPortafolio(){
    section = document.getElementById("contenido_portafolio");
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


    // -----------------------------------------------------------------------------------
    // NOTA: 'verPortafolioClicked' se usa para determinar si se omitio la presentacion
    // -----------------------------------------------------------------------------------

    // 1. Desaparece el boton de ver portafoilio y realiza animacion de salida
    setTimeout(function() {
        btnPortafolio = document.getElementById("ver_portafolio");
        btnPortafolio.disabled = true;
        btnPortafolio.className += (" animate__animated animate__bounceOut");

        // divPortafolio = document.getElementById("div_ver_portafolio");
        // divPortafolio.classList.add('d-none');
        
    }, 0);

    // 2. Hace visible y realiza animacion de entrada para los botones de network_options (Github, CV)
    setTimeout(function() {
        netwok = document.getElementById("network_options");
        netwok.classList.remove('d-none');
        if(!verPortafolioClicked){
            netwok.className += (" animate__animated animate__backInLeft animate__slow");
        }else{
            netwok.className += (" animate__animated animate__backInLeft");
        }
    }, tiempo);

    // 3. Hace visible y realiza animacion de entrada para el boton flecha abajo
    setTimeout(function() {
        dowmArrow = document.getElementById("down_arrow");
        dowmArrow.classList.remove('d-none');

        // Hace visible la seccion del portafolio 
        section = document.getElementById("contenido_portafolio");
        section.classList.remove('d-none');

        if(!verPortafolioClicked){
            dowmArrow.className += (" animate__animated animate__backInUp animate__slow");
        }else{
            dowmArrow.className += (" animate__animated animate__backInUp");
        }
    }, tiempo*2);

    // 4. Solo si verPortafolioClicked=true : Desplaza el scroll hacia la seccion del contenido_portafolio, y realiza animación de rapidez
    if(verPortafolioClicked){
        setTimeout(function() {

            btnPortafolio.className += (" d-none");
            section.scrollIntoView({ behavior: "auto", block: "start" });
            // section.scrollIntoView({ behavior: "instant", block: "start" });
    
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

   
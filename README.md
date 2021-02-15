# CIU-Pong

CIU-Pong es un miniproyecto para la asignatura **Creando Interfaces de Usuario** que consiste en reconstruir el juego [Pong](https://es.wikipedia.org/wiki/Pong) en [Processing 3](https://processing.org/).

*Christian García Viguera. Universidad de Las Palmas de Gran Canaria.*

<p align="center">
  <img width="460" height="300" src="https://github.com/Chgv99/Pong/blob/main/preview.gif">
</p>

# Índice
* [Descripción](https://github.com/Chgv99/CIU-Pong#descripcion)
* [Funcionamiento](https://github.com/Chgv99/CIU-Pong#Funcionamiento)
* [Diseño](https://github.com/Chgv99/CIU-Pong#Diseño)
* [Referencias](https://github.com/Chgv99/CIU-Pong#Referencias)

# Descripción

La práctica explora varios conceptos en Processing:
* Movimiento
* Detección de colisiones
* Almacenamiento de puntuación
* Reproducción de sonido
* Detección de entradas por teclado
* Aleatoriedad

Dado que Pong es un juego en el que los reflejos son la habilidad requerida del jugador, es importante escoger una distancia adecuada entre las palas. En mi caso, escogí para la ventana un tamaño de 750x500px, para las palas 16x100px dejando cada una a una distancia de 100(?)


```processing
void draw() {
  render();
  gifExport.setDelay(0);
  gifExport.addFrame();
  
  if (score_a == 2 || score_b == 2) {
    gifExport.finish();    
  }
}
```

# Referencias
* [Processing 3](https://processing.org/)
* [Processing 3 Reference](https://processing.org/reference/)
* [Gif Animation Exporting](https://github.com/extrapixel/gif-animation)
* [Guión de Prácticas](https://ncvt-aep.ulpgc.es/cv/ulpgctp21/pluginfile.php/412240/mod_resource/content/37/CIU_Pr_cticas.pdf)


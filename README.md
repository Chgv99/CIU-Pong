# CIU-Pong

CIU-Pong es un miniproyecto para la asignatura **Creando Interfaces de Usuario** que consiste en reconstruir el juego [Pong](https://es.wikipedia.org/wiki/Pong) en [Processing 3](https://processing.org/).

*Christian García Viguera. Universidad de Las Palmas de Gran Canaria.*

<p align="center">
  <img width="460" height="300" src="https://github.com/Chgv99/Pong/blob/main/preview.gif">
</p>

# Índice
* [Descripción](https://github.com/Chgv99/CIU-Pong#Descripción)
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

Primeramente, y dado que Pong es un juego en el que los reflejos son la única habilidad requerida del jugador, es importante escoger una distancia adecuada entre las palas. En mi caso, escogí para la ventana un tamaño de 750x500px y para las palas uno de 16x100px, dejando un espaciado de 100px con los bordes laterales. Esto nos deja con 518px entre las palas... Poco más que el alto de la ventana.

## Movimiento
La pelota se inicializa en el centro de la pantalla. La partida comienza con un saque aleatorio a la izquierda o a la derecha.

```processing
//50% de lanzar hacia izquierda, 50% de lanzar hacia derecha
prob = round(random(100));
if (prob > 50){
  //Derecha
  ball_speed_x = global_speed;
  ball_speed_y = 0;
} else {
  ball_speed_x = -global_speed;
  ball_speed_y = 0;
}
```

# Diseño

# Referencias
* [Processing 3](https://processing.org/)
* [Processing 3 Reference](https://processing.org/reference/)
* [Gif Animation Exporting](https://github.com/extrapixel/gif-animation)
* [Guión de Prácticas](https://ncvt-aep.ulpgc.es/cv/ulpgctp21/pluginfile.php/412240/mod_resource/content/37/CIU_Pr_cticas.pdf)


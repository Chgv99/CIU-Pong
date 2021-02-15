# CIU-Pong

CIU-Pong es un miniproyecto para la asignatura **Creando Interfaces de Usuario** que consiste en reconstruir el juego [Pong](https://es.wikipedia.org/wiki/Pong) en [Processing 3](https://processing.org/).

*Christian García Viguera. [Universidad de Las Palmas de Gran Canaria.](https://www2.ulpgc.es/)*

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
* Aleatoriedad
* Movimiento
* Detección de colisiones
* Almacenamiento de puntuación
* Reproducción de sonido
* Detección de entradas por teclado

Primeramente, y dado que Pong es un juego en el que los reflejos son la única habilidad requerida del jugador, es importante escoger una distancia adecuada entre las palas. En mi caso, escogí para la ventana un tamaño de 750x500px y para las palas uno de 16x100px, dejando un espaciado de 100px con los bordes laterales. Esto nos deja con 518px entre las palas... Poco más que el alto de la ventana.

## Aleatoriedad
La partida comienza con un saque aleatorio a la izquierda o a la derecha. Esto da a ambos jugadores la misma probabilidad de comenzar con "*ventaja*".

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
Además, en cada rebote de la pelota con una pala, se elige al azar de entre *-global_speed* y *global_speed* para la componente vertical de la velocidad de la pelota.
```processing
void bounce(){
  hit.play();
  ball_speed_y = round(random(-global_speed, global_speed));
}
```
## Movimiento
La pelota se inicializa en el centro de la pantalla. En cada loop se le suma a sus componentes una cierta cantidad (*ball_speed_x* y *ball_speed_y*), y tras ello se dibujan en pantalla para generar el movimiento. Lo mismo ocurre con las palas.
```processing
void positionElements() {
  ball_x = ball_x + ball_speed_x;
  ball_y = ball_y + ball_speed_y;
  
  circle(ball_x, ball_y, ball_d);
  rect(paddle_a_x, paddle_a_y - paddle_height/2, paddle_width, paddle_height);
  rect(paddle_b_x, paddle_b_y - paddle_height/2, paddle_width, paddle_height);
}
```
# Diseño

# Referencias
* [Processing 3](https://processing.org/)
* [Processing 3 Reference](https://processing.org/reference/)
* [Gif Animation Exporting](https://github.com/extrapixel/gif-animation)
* [Guión de Prácticas](https://ncvt-aep.ulpgc.es/cv/ulpgctp21/pluginfile.php/412240/mod_resource/content/37/CIU_Pr_cticas.pdf)


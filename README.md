# CIU-Pong

CIU-Pong es un miniproyecto para la asignatura **Creando Interfaces de Usuario** que consiste en reconstruir el juego [Pong](https://es.wikipedia.org/wiki/Pong) en [Processing 3](https://processing.org/).

*Christian García Viguera. [Universidad de Las Palmas de Gran Canaria.](https://www2.ulpgc.es/)*

<p align="center">
  <img width="460" height="300" src="https://github.com/Chgv99/Pong/blob/main/preview.gif">
</p>

# Índice
* [Funcionamiento](https://github.com/Chgv99/CIU-Pong#Funcionamiento)
  * [Aleatoriedad](https://github.com/Chgv99/CIU-Pong#Aleatoriedad)
  * [Movimiento](https://github.com/Chgv99/CIU-Pong#Movimiento)
  * [Detección de colisiones](https://github.com/Chgv99/CIU-Pong#Detección-de-colisiones)
  * [Almacenamiento de puntuación](https://github.com/Chgv99/CIU-Pong#Almacenamiento-de-puntuación)
  * [Reproducción de sonido](https://github.com/Chgv99/CIU-Pong#Reproducción-de-sonido)
  * [Detección de entradas por teclado](https://github.com/Chgv99/CIU-Pong#Detección-de-entradas-por-teclado)
* [Diseño](https://github.com/Chgv99/CIU-Pong#Diseño)
* [Referencias](https://github.com/Chgv99/CIU-Pong#Referencias)
---

# Funcionamiento

La práctica explora varios conceptos en Processing:
* [Aleatoriedad](https://github.com/Chgv99/CIU-Pong#Aleatoriedad)
* [Movimiento](https://github.com/Chgv99/CIU-Pong#Movimiento)
* [Detección de colisiones](https://github.com/Chgv99/CIU-Pong#Detección-de-colisiones)
* [Almacenamiento de puntuación](https://github.com/Chgv99/CIU-Pong#Almacenamiento-de-puntuación)
* [Reproducción de sonido](https://github.com/Chgv99/CIU-Pong#Reproducción-de-sonido)
* [Detección de entradas por teclado](https://github.com/Chgv99/CIU-Pong#Detección-de-entradas-por-teclado)

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

## Detección de colisiones

```processing
void checkCollisions() {
  checkScoreConditions();
  
  //Colisiones
  //Paredes
  if (ball_y + (ball_d/2) > height || ball_y - (ball_d/2) < 0) {
    ball_speed_y = -ball_speed_y;
  }

  //Palas
  //Pala izquierda
  if ((ball_x - ball_d/2 < paddle_a_x + paddle_width) &&
      (ball_x + ball_d/2 > paddle_a_x) &&
      (ball_y - ball_d/2 < paddle_a_y + paddle_height/2) &&
      (ball_y + ball_d/2 > paddle_a_y - paddle_height/2)) {
    ball_speed_x = abs(global_speed);
    bounce();
  }
  
  //Pala derecha
  if ((ball_x - ball_d/2 < paddle_b_x + paddle_width) &&
      (ball_x + ball_d/2 > paddle_b_x) &&
      (ball_y - ball_d/2 < paddle_b_y + paddle_height/2) &&
      (ball_y + ball_d/2 > paddle_b_y - paddle_height/2)) {
    ball_speed_x = -abs(global_speed);
    bounce();
  }
}
```

## Almacenamiento de puntuación

El almacenamiento de los puntos de cada jugador se realiza en una variable entera que se dibuja mediante *text()* al comienzo del método *draw()*, tras el fondo. Se acumula cada vez que se detecte una colisión de la pelota con el borde izquierdo o derecho de la pantalla.

Si la pelota colisiona con el borde izquierdo, se le suma un punto al jugador de la derecha, y en el siguiente saque, se le dará la pelota al jugador de la izquierda.
```processing
void printBackground() {
  background(0);
  stroke(255);
  strokeWeight(3);
  textSize(100);
  fill(255);
  text(score_b, (width/2) + 75, height/4);
  text(score_a, 
      (width/2) - 140, //200
      height/4);
  for (int i = 0; i < 10; i++){
    line(width/2, i * 50, width/2, i * 50 + 25);
  }
  noStroke();
}
```

## Reproducción de sonido

La reproducción de archivos de sonido se lleva a cabo de la forma en que se explica en el [guión de prácticas](https://github.com/Chgv99/CIU-Pong#Referencias).

Se reproducen dos sonidos distintos: uno para el rebote de la pelota con las palas, y otro para cuando se marca un punto.

Es importante recalcar que la librería no permite el uso de archivos *.mp3*.
```processing
import processing.sound.*;
SoundFile hit;
SoundFile score;

void Setup(){
  hit = new SoundFile(this, "Hit11.wav");
  score = new SoundFile(this, "Hit10.wav");
}

void bounce(){
  hit.play();
  //...
}

void score(){
  score.play();
  //...
}
```

## Detección de entradas por teclado

Las entradas por teclado son la interacción del usuario con el juego. Pulsando 'W' y 'S' se maneja al jugador 1, y pulsando 'UP' y 'DOWN' al jugador 2.
Debido a alguna particularidad de [Processing 3](https://github.com/Chgv99/CIU-Pong#Referencias), no se admiten varias entradas simultáneas. Esto provoca que un jugador impida que el contrincante participe si está pulsando una tecla, pero se puede jugar en turnos alternos si los reflejos de cada jugador son los suficientes. Para el interesado: sí, se podría solucionar este error de alguna manera.
```processing
void checkKeyPressed(){
  //Teclas
  if (keyPressed) {
    if (key == 'w'){
      paddle_a_y -= paddle_speed;
      print("up\n");
    }
    
    if (key == 's'){
      paddle_a_y += paddle_speed;
      print("down\n");
    }
    
    if (keyCode == UP){
      paddle_b_y -= paddle_speed;
      print("up\n");
    }
    
    if (keyCode == DOWN){
      paddle_b_y += paddle_speed;
      print("down\n");
    }
  }
}
```
---
# Diseño

Dado que Pong es un juego en el que los reflejos son la habilidad requerida al jugador, es importante escoger una distancia adecuada entre las palas, ya que una distancia muy pequeña podría molestar al jugador, y una muy larga provocaría partidas aburridas. En mi caso, escogí para la ventana un tamaño de 750x500px y para las palas uno de 16x100px, dejando un espaciado de 100px con los bordes laterales. Esto nos deja con 518px entre las palas... Poco más que el alto de la ventana.

Las dimensiones de la pelota (15px de diámetro) no las he estudiado demasiado. Simplemente escogí un tamaño que no fuese más grande que el ancho de las palas, para respetar las dimensiones originales del Pong.

En cierto punto se me ocurrió hacer que la velocidad de la pelota aumentase con cada rebote, para que no se jugasen rondas demasiado largas, pero desheché la idea porque creo que corta la tensión que podría surgir del enfrentamiento de dos oponentes dignos el uno del otro. Además, no deja de intentar suplir una carencia de las primeras iteraciones del programa: la velocidad de la pelota no estaba bien ajustada.

En las últimas iteraciones, añadí la detección de la colisión de las palas con los bordes de la ventana.
```processing
void checkPaddleOutOfBounds() {
  if (paddle_a_y <= paddle_height/2){
    paddle_a_y = paddle_height/2;
  }
  if (paddle_a_y > height - paddle_height/2){
    paddle_a_y = height - paddle_height/2;
  }
  if (paddle_b_y <= paddle_height/2){
    paddle_b_y = paddle_height/2;
  }
  if (paddle_b_y > height - paddle_height/2){
    paddle_b_y = height - paddle_height/2;
  }
}
```

Por último, la puntuación del jugador izquierdo está colocada a ojo, dado que el tamaño del texto no coincide con ninguna medida específica en píxeles. Por ello, coloqué primero el contador derecho a 75px del centro (horizontal) y a un cuarto de la altura total de la ventana del borde superior, y luego intenté que el otro contador quedara simétrico. 
No he implementado un contador dinámico, es decir, uno que se desplace según el número de cifras del número de puntos. Esto quiere decir que a partir de 10 puntos, los contadores se solapan o se descolocan.

---
# Referencias
* [Processing 3](https://processing.org/)
* [Processing 3 Reference](https://processing.org/reference/)
* [Gif Animation Exporting](https://github.com/extrapixel/gif-animation)
* [Guión de Prácticas](https://ncvt-aep.ulpgc.es/cv/ulpgctp21/pluginfile.php/412240/mod_resource/content/37/CIU_Pr_cticas.pdf)


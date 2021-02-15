# CIU-Pong

CIU-Pong es un miniproyecto para la asignatura **Creando Interfaces de Usuario** que consiste en reconstruir el juego [Pong](https://es.wikipedia.org/wiki/Pong) en [Processing 3](https://processing.org/).

*Christian García Viguera. Universidad de Las Palmas de Gran Canaria.*

<p align="center">
  <img width="460" height="300" src="https://github.com/Chgv99/Pong/blob/main/preview.gif">
</p>

# Índice
* [Descripción](https://github.com/Chgv99/CIU-Pong#indice)
* [Funcionamiento](https://github.com/Chgv99/CIU-Pong#Funcionamiento)
* [Diseño](https://github.com/Chgv99/CIU-Pong#Diseño)
* [Referencias](https://github.com/Chgv99/CIU-Pong#Referencias)

# Descripción

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


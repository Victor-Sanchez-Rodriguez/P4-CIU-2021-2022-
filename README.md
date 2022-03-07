# P4-CIU-2021-2022-

Autor: Víctor Sánchez Roodríguez

Se parte de la simulación de un sistema planetario simple y se implementa la navegación y posicionamiento de cámara para simular una nave espacial que circule por el sistema.

Entre las decisiones a destacar, obviamente, se encuentra el método usado para la navegación y definición de cámara.
El posicionamiento se calcula en base a una transformación vectorial usando la velocidad actual de la nave y la posición a la que está mirando, multiplicando estos valores vectorialmente y añadiéndolos al vector de posición. Esto funciona aunque no se esté usando la perspectiva desde la nave. Los controles no modifican directamente la posición, solo aumentan o disminuyen la velocidad y cambian el ángulo al que mira la cámara, lo cual se realiza calculando a cada iteración un vector nuevo en base de unos valores enteros auxiliares que determinan el ángulo en que se mira. Cuando se mira desde la nave, similar a como se calcula la posición, se coloca el foco de la cámara a una pequeña distancia de la posición de la nave más el ángulo en que se mira, calculado a través de una suma vectorial. La vertical de la cámara no se modifica en ningún momento.

Gara realizar el trabajo se han usado las herramientas y documentación del propio Processing aportadas en el guión, incluso para la captura del gif animado (la cual no se ve reflejada en el código entregado). Se han usado imágenes de Google para los activos multimedia (las imágenes del sol, planetas y lunas), y se ha consultado en google las matemáticas necesarias para realizar las transformaciones vectoriales.

![animacion](https://user-images.githubusercontent.com/73181748/157100637-643a1542-f996-42e3-9db8-21faac5d5445.gif)

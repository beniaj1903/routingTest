# README

Esta página es una interfaz para que el usuario pueda asignar rutas para su flota de conductores y vehículos que se encuentren dentro de la Región Metropolitana de Chile

* Ruby version '2.6.3'

* Dependencias importantes

    rails -> '5.2.3' (ver otras dependencias dentro del Gemfile)
    postgresql
    materialize -> '1.0.0'

* Inicialización

    Para hacer despliegue en otro ambiente o en el ambiente local, se deben correr los siguientes comandos:
        
        - bundle install (instala dependencias)
        - rake db:create (crea base de datos)
        - rake db:migrate (ejecuta las migraciones)
        - rails s (inicializa el servidor)
        
    Luego de esto la página se encontrará disponible en localhost:3000 o en su url de despliegue

* Pruebas
    
    Para cargar los datos de prueba de la página se utiliza el botón 'Datos de Prueba', ubicado arriba de la tabla de rutas asignadas, debajo de la tabla de vehículos, cada vez que se oprime borra los datos actuales y llena de nuevo la base de datos con los datos de prueba iniciales. El accesos a estos datos y su modificación se hace cambiando el código fuente, ubicado en el controlador 'routes' en la función 'fill_db'

* Datos del despliegue

    link de acceso a producción: https://prueba-routing.herokuapp.com/

    Estan configurados los despliegues automáticos a la rama master, por lo tanto al hacer el push se compila en producción

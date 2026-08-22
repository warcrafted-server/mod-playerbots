Los Playerbots están programados para responder a comandos de chat. El complemento Multibot está diseñado para gestionar la mayoría de los comandos de chat comunes para el jugador, pero es posible que aún necesites comandos de chat manuales a medida que juegas. Es importante distinguir entre "Altbots" y "Rndbots": los Altbots son bots creados manualmente por el jugador en una cuenta normal, mientras que los "Rndbots" y sus cuentas se generan automáticamente según la configuración de los archivos .conf. Los Rndbots se equiparán automáticamente, aplicarán talentos y deambularán por el mundo, mientras que los Altbots no lo harán.

## Comandos de configuración de Altbot
Los Altbots son personajes que creas primero en tu cuenta (u otras) y a los que luego se les asigna el control de bot mediante los siguientes comandos.

comando | acción
:---|:---
``.playerbots bot add [nombre1,nombre2,nombre3]`` | iniciar sesión de altbots. Ten en cuenta que también puedes iniciar sesión de altbots desde otras cuentas según tus configuraciones.
``.playerbots bot addaccount [nombredecuenta]`` | iniciar sesión de una cuenta entera de altbots. Según tus configuraciones puedes iniciar sesión en otras cuentas.
``.playerbots bot remove nombre1,nombre2,nombre3`` | cerrar sesión de altbots
``.playerbots bot add *`` |  iniciar sesión de todos los altbots que estén en tu grupo/banda
``.playerbots bot remove *`` | cerrar sesión de todos los altbots que estén en tu grupo/banda
``.playerbots bot refresh=raid *`` | desvincular todas las estancias guardadas de todos los altbots que estén en tu grupo/banda. ADVERTENCIA: Esta función aún no es perfecta. Si ya estás en una banda, después de ejecutar el comando, la IA necesita volver a conectarse o salir de la banda y volver a entrar.
``maintenance`` | permite que el altbot aprenda todos los hechizos y habilidades disponibles, reponga consumibles, encante equipamiento y repare. También se puede usar en rndbots, pero ellos lo hacen automáticamente. Susurra a un bot individual o usa /p o /r para seleccionar varios bots simultáneamente.
``autogear`` | equipa automáticamente a tu altbot, con una calidad basada en tus configuraciones .conf AutoGearQualityLimit y AutoGearScoreLimit. También se puede usar en rndbots, pero ellos realizan automáticamente su propia inicialización de equipamiento al subir de nivel.
``talents`` | comprobar la especialización actual del bot
``talents spec list`` | comprobar las especializaciones disponibles para la clase
``talents spec [nombre de especialización]`` | forzar al bot a cambiar sus talentos a la especialización elegida, consulta el .conf para ver la lista de nombres de especialización o susurra a tu bot "talents spec list"
``talents apply <enlace>`` | aplicar enlace de talentos al bot
``glyphs`` | lista los glifos actualmente equipados del bot en el idioma del cliente, utilizando enlaces de objetos para las traducciones correctas
``glyph equip [IDGlifo1 IDGlifo2 IDGlifo3 IDGlifo4 IDGlifo5 IDGlifo6]`` | el bot aplica los glifos dados
``reset botAI`` | restablecer la configuración del bot
``reset`` | restablecer las acciones actuales del bot como lanzar hechizos, moverse, etc.

## Comando de configuración AddClass
Los bots AddClass utilizan Rndbots no utilizados en tu sistema. Actualmente se recomienda usarlos solo con fines de prueba, es decir, formar rápidamente un grupo de banda para probar ciertos bots en una banda determinada, mientras que los Altbots se recomiendan encarecidamente para partidas de progresión a largo plazo.

comando | acción
:---|:---
``.playerbots bot addclass [nombreDeClase]`` | invocar un nuevo Rndbot de la clase deseada (nota: la sintaxis para caballero de la muerte es dk, por lo demás el resto son estándar)

## Comandos generales de Grupo/Banda

comando | acción
:---|:---
``summon`` | invocar al bot hacia ti (consulta el .conf para ver diferentes opciones para configurar este comando)
``release`` | liberar espíritu al morir
``revive`` | resucitar cuando estés cerca de un ángel de la resurrección
``leave`` | abandonar el grupo
``attack`` | atacar al objetivo seleccionado
``follow`` | correr hacia el jugador (/w para individual o /p o /r para grupo/banda)
``flee`` | correr hacia el jugador ignorando todo lo demás (/w para individual o /p o /r para grupo/banda)
``stay`` | permanecer en el lugar
``runaway`` | mecer/kitear mob // nota: actualmente no funcional
``grind`` | atacar a cualquiera
``disperse set x`` | forzar a los bots a mantener una distancia de x yardas entre sí
``disperse disable`` | restablece la distancia de dispersión al valor predeterminado
``give leader`` | si el bot es líder de grupo/banda se lo pasará a su maestro
``lfg`` | El bot se une al grupo/banda del solicitante, ocupando un hueco libre de tanque/sanador/dps.
``lfg x `` | Igual que el anterior pero apunta a un tamaño específico de grupo/banda [5,10, 20, 25, 40].

Además, puedes especificar por grupo o tipo para algunos comandos como "attack" y "follow", tales como:
- "@group1 follow"
- "@group2 attack"

Los siguientes son otros grupos a los que se puede apuntar: 
-  @tank, @dps, @heal, @ranged, @rangeddps, @meleedps, @[nombreDeClase]

También puedes dar órdenes a varios grupos a la vez como a continuación:
- "@Group1,4"
- "@group2-5,8"

## Comandos de hechizos de Playerbot

comando | acción
:---|:---
``spells`` | mostrar los hechizos del bot
``cast [nombre_hechizo]`` | /w a un bot para lanzar un hechizo
``cast [nombre_hechizo] on [NombreJugador]`` | /w a un bot para lanzar un hechizo sobre un jugador especificado
``ss +[id hechizo]`` | añadir hechizo a la lista de hechizos excluidos
``ss -[id hechizo]`` | eliminar hechizo de la lista de hechizos excluidos
``ss reset`` | elimina todos los hechizos de la lista de hechizos excluidos
``trainer`` | mostrar lo que el bot puede aprender del instructor seleccionado
``trainer learn`` | aprender del instructor seleccionado

## Selección de objetivos de Grupo/Banda
RTSC es un sistema que permite a los jugadores guardar ubicaciones para que bots especificados vayan a ellas utilizando el hechizo "aedm" que se concede cuando se usa el comando "rtsc". Aedm es un hechizo que usas para apuntar y hacer clic en una ubicación particular que se puede guardar y usar mediante algunos de los siguientes comandos.

RTI es un sistema que permite a los jugadores enfocar a los bots en objetivos especificados utilizando iconos estándar de WoW.

comando | acción
:---|:---
``rtsc`` | activa/desactiva rtsc y otorga a los jugadores el hechizo "aedm" que aparecerá en la categoría general de su libro de hechizos 
``rtsc cancel`` | desactiva rtsc y elimina el hechizo "aedm" del libro de hechizos
``rtsc save [#]`` | mientras rtsc está activado, este comando guardará una ubicación como el número especificado cuando el jugador use el hechizo aedm y haga clic en una ubicación
``rtsc unsave [#]`` | borra la ubicación guardada
``rtsc go [#]`` | ordena a los bots ir a la ubicación guardada, este comando se puede susurrar a bots individuales o filtrar en el chat de grupo/banda con los mismos filtros de chat enumerados en Comandos generales de Grupo/Banda (p. ej., "@Tank rtsc go 5" enviará a todos los tanques a la ubicación guardada 5)
``[nombre/grupo] rtsc toggle`` | activa/desactiva la capacidad de apuntar y hacer clic con el botón del ratón para guardar una ubicación a la que se moverán los bots especificados, se puede especificar por grupo o clase (es decir, "@druid rtsc toggle" o "@group1 rtsc toggle")
``rtsc go save`` | ordena a los bots moverse de nuevo a la posición rtsc guardada
``rti <icono>`` | establece el icono de objetivo que el bot debe priorizar (iconos: calavera, cruz, círculo, estrella, cuadrado, triángulo, diamante y luna)
``attack rti target`` | ordena a los bots atacar a su objetivo rti
``rti cc <icono>`` | establece un icono específico como objetivo de cc (el predeterminado es luna) 
`focus heal +[NombreJugador]` | añadir un miembro del grupo/banda a la lista de objetivos de sanación focalizada del bot. Mientras haya objetivos de sanación focalizada establecidos, los bots sanadores y los bots que usen `offheal` priorizarán sanar solo a los jugadores listados.
`focus heal -[NombreJugador]` | eliminar a un jugador de la lista de objetivos de sanación focalizada
`focus heal +[Jugador1],+[Jugador2],-[Jugador3]` | añadir o eliminar varios jugadores en un solo comando. Los nombres deben ser miembros del grupo o banda actual del bot.
`focus heal ?` | mostrar la lista actual de objetivos de sanación focalizada del bot
`focus heal clear` | borrar todos los objetivos de sanación focalizada
`focus heal none` | borrar todos los objetivos de sanación focalizada
`focus heal unset` | borrar todos los objetivos de sanación focalizada

Guía en vídeo:
https://www.youtube.com/watch?v=Pwt7schIC08

## Estrategias

Los bots están programados para responder a activadores enumerando posibles acciones y eligiendo una basada en una estrategia. Los bots usan dos categorías de estrategias: combate y no combate. Puedes añadir, restar o alternar estrategias usando los prefijos de combate (co) y no combate (nc) en tus comandos:

```
co +estrategia1,-estrategia2,~estrategia3
nc +estrategia1,-estrategia2,~estrategia3
```

Puedes consultar al bot para que informe qué estrategias se están utilizando actualmente:

```
co ?
nc ?
```

Puedes restablecer un tipo de estrategia específico:

```
co !
nc !
```

### Estrategias de combate

General
estrategia | descripción
:---|:---|
``tank`` | usar habilidades que generan amenaza (el guerrero, paladín y druida usarán ``bear``)
``tank assist`` | hacer que el tanque despoje de mobs a los demás
``dps`` | usar habilidades de dps (el pícaro, cazador, chamán, sacerdote y druida usarán ``cat``)
``cc`` | usar habilidades de cc (requiere un objetivo rti de cc, el predeterminado es el icono de la luna; es útil saber que los bots no atacarán al objetivo rti y no intentarán usar cc si el objetivo no se puede aturdir)
``assist`` | atacar a un mob a la vez
``aoe`` | atacar a muchos mobs a la vez
``boost`` | los bots usarán reutilizaciones grandes (útil usar -boost y +boost en macros para controlar cuándo hacer burst en jefes)
``threat`` | los dps evitarán activamente generar amenaza (útil para jefes que limpian el agro o si a los tanques les cuesta mantener el agro)
``grind`` | atacar a cualquier objetivo visible, luego cambiar a otro y así sucesivamente.
``heal`` | enfocarse en la sanación del grupo (chamán, sacerdote, druida, paladín)
``focus`` | dejar de lanzar hechizos de aoe o hechizos de debuff en múltiples atacantes (enfocarse en el objetivo único)
``avoid aoe`` | evitar automáticamente la mayoría de los hechizos de aoe dañinos
``save mana`` | los sanadores ahorran maná priorizando hechizos de alta eficiencia cuando el maná cae por debajo de un umbral
``healer dps`` | los sanadores lanzan hechizos de daño si tienen suficiente maná
``tank face`` | asegurar que el objetivo actual no mire hacia los jugadores a distancia del grupo (para contrarrestar hechizos de aliento y tipo rajar/cleave)
``behind`` | moverse a la espalda del objetivo (flanco trasero) cuando no estén posicionados detrás del objetivo
``wait for attack`` | los bots esperarán un tiempo determinado antes de comenzar a atacar/sanar en combate. El tiempo se establece mediante el comando `wait for attack time 5` donde 5 es el tiempo que esperan en segundos
``pull`` | el bot tanque provocará/atraerá al mob usando una habilidad a distancia. Comandos `pull my target` o `pull rti target`
``pull back`` | junto con la estrategia de pull, el bot atraerá al mob usando una habilidad a distancia y regresará al punto donde comenzó el pull
``mark rti`` | permite al bot marcar automáticamente a los atacantes en combate no marcados (priorizando al de menor salud) con su icono `rti` configurado.

Druida
estrategia | descripción
:---|:---
``bear``, ``cat``, ``caster`` | dicta la estrategia general para los druidas, ten en cuenta que estas ya se gestionan mediante su selección de talentos
``feral charge`` | activa Carga feral en la rotación de gato/oso (solo feral, activado por defecto; desactivar con ``co -feral charge`` para mantener al druida fuera de zonas de melé peligrosas como el enjambre de langostas de Anub'arak o la sobrecarga del Consejo de Hierro)
``tranquility`` | activa Tranquilidad en la rotación de sanación de resto (solo resto, activado por defecto; desactivar para suprimir el lanzamiento en daños a toda la banda o fases de mucho movimiento donde rinde menos — en 25 jugadores solo sana al propio grupo del druida)
``blanketing`` | el druida resto aplica hots previos a los tanques, luego a los melés y después a los jugadores a distancia con Crecimiento salvaje y Rejuvenecimiento independientemente de la salud actual para maximizar el tiempo de actividad de Revitalizar (solo resto, activado por defecto)

Cazador
estrategia | descripción
:---|:---
``trap weave`` | activa la estrategia de trampeo (trap weave) para cazadores, soltando una trampa explosiva como parte de su rotación (solo cazador)

Mago
estrategia | descripción
:---|:---
``frost``, ``fire`` | solo mago, ten en cuenta que estas ya se gestionan mediante su selección de talentos
``firestarter`` | activa la estrategia pirómano (firestarter) para magos fuego, haciendo que el mago entre a melé para utilizar el fogueo instantáneo del talento pirómano (solo mago fuego)

Chamán
estrategia | descripción
:---|:---
``[nombre del tótem]`` | el chamán añadirá el tótem a su lanzamiento de llamada de los elementos (es decir, "co +tremor" añadirá ese tótem para el chamán)

Brujo
estrategia | descripción
:---|:---
``meta melee`` | estrategia predeterminada para brujos demonología, hace que el brujo entre a melé mientras usa metamorfosis y aura de inmolación (solo brujo demonología)

### Estrategias de no combate
Nota: Los Altbots no farmearán ni harán misiones de forma autónoma como lo hacen los Rndbots. Sin embargo, actualmente puedes lograr esto en cierto modo invitando a tus Altbots al grupo/banda (o susurrando fuera del grupo si es solo 1 Altbot) y usando el siguiente comando, y luego puedes disolver el grupo/banda.
"/p nc +new rpg,+grind,-follow"

General
estrategia | descripción
:---|:---
``new rpg`` | el bot seguirá la nueva estrategia de rpg que incluye hacer misiones y funciona en conjunto con la estrategia grind
``grind`` | el bot buscará objetivos cercanos de nivel apropiado para farmear
``follow`` | el bot seguirá al maestro
``food`` | iniciar o parar de comer/beber
``pvp`` | activar o desactivar el modo jpj
``loot`` | permite que los bots despojen todo. Nota: añadir o eliminar esa estrategia para los randombots requiere nivel de MJ

Sacerdote
estrategia | descripción
:---|:---
``rshadow`` | el sacerdote lanzará Protección contra las Sombras

Paladín
estrategia | descripción
:---|:---
``bmight``, ``bwisdom``, ``bkings``, ``bsanc`` | estrategias de bendición del paladín (poder, sabiduría, reyes y santuario respectivamente)
``rfire``, ``rfrost``, ``rshadow``, ``baoe``, ``barmor``, ``bcast``, ``bspeed`` | estrategias de aura del paladín (fuego, escarcha, sombras, represalia, devoción, concentración y aura de cruzado respectivamente)

Cazador
estrategia | descripción
:---|:---
``bdps``, ``bspeed``, ``bmana``, ``rnature`` | estrategias de aspecto del cazador (halcón del dragón/halcón, manada/gépardo, víbora y naturaleza respectivamente)

Estrategias de mascotas de brujo (Ten en cuenta que las predeterminadas son las siguientes: Aflicción usa manáfago, Demonología usa guardia del Apocalipsis/guardia vil y Destrucción usa demonio imp)
estrategia | descripción
:---|:---
``imp`` | forzar al brujo a usar demonio imp
``voidwalker`` | forzar al brujo a usar abisario
``succubus`` | forzar al brujo a usar súcubo
``felhunter`` | forzar al brujo a usar manáfago
``felguard`` | forzar al brujo a usar guardia vil

Estrategias de Piedra de alma de brujo
estrategia | descripción
:---|:---
``ss master`` | forzar al brujo a usar piedra de alma en el maestro
``ss self`` | forzar al brujo a usar piedra de alma en sí mismo
``ss tank`` | forzar al brujo a usar piedra de alma en el tanque
``ss healer`` | forzar al brujo a usar piedra de alma en el sanador

### Estrategias específicas de Banda

Nota: Estas estrategias de banda ahora se aplican automáticamente al entrar en la estancia. Deberías recibir un susurro de tus bots confirmando la activación.

estrategia | descripción
:---|:---
moltencore | activar estrategias de Núcleo de Magma 
bwl | activar estrategias de Guarida de Alanegra (Nota: otorga el beneficio Capa de escamas de Onyxia a todos los bots, los bots desactivan automáticamente los dispositivos de supresión y los bots limpian automáticamente Aflicción del linaje: Bronce en Chromaggus)
aq20 | activar estrategias de Ruinas de Ahn'Qiraj (Nota: solo Ossirian, el resto se puede vencer sin estrategias)
karazhan | activar estrategias de Karazhan 
gruulslair | activar estrategias de Guarida de Gruul 
magtheridon | activar estrategias de Guarida de Magtheridon 
ssc | activar estrategias de Caverna Santuario Serpiente 
voa | activar estrategias de La Cámara de Archavon (Nota: hasta Emalon)
naxx | activar estrategias de Naxxramas 
wotlk-os | activar estrategias de El Sagrario Obsidiana (Nota: la estrategia solo es funcional hasta OS+2, es necesario matar a Vesperon primero)
wotlk-eoe | activar estrategias de El Ojo de la Eternidad
ulduar | activar estrategias de Ulduar (Nota: se pueden hacer todos los jefes excepto Algalon)
onyxia | activar estrategias de Guarida de Onyxia
icc | activar estrategias de Ciudadela de la Corona de Hielo 

## Botín

Puedes controlar qué objetos despojar (``ll`` significa lista de botín/loot list):

comando | acción
:---|:---
``nc +loot`` | activar despojo (nota: la estrategia ``grind`` también activa el despojo)
``ll all`` | despojar todo
``ll normal`` | despojar cualquier cosa excepto objetos BOP (se ligan al recogerlos)
``ll gray`` | despojar solo objetos grises
``ll quest`` | despojar solo objetos de misión
``ll skill`` | despojar solo objetos basados en sus profesiones (herboristería, minería o desuello)
``ll [objeto]`` | añadir objeto específico a la lista de botín
``ll -[objeto]`` | eliminar objeto específico de la lista de botín

## Objetos

comando | acción
:---|:---
``[objeto]`` | el bot te dirá cuántos tiene y el estado de la misión
``e [objeto]`` | equipar objeto
``ue [objeto]`` | desequipar objeto
``u [objeto]`` | usar objeto
``u [objeto] [objetivo]`` | usar objeto en el objetivo (usar gema en el objeto)
``open items`` | abrir objetos en el inventario que tengan botín, es decir, Fardel de botín
``destroy [objeto]`` | destruir objeto
``roll [objeto]`` | los bots del grupo/banda tirarán dados por el objeto enlazado si supone una mejora para ellos
``roll`` | todos los bots del grupo/banda tirarán dados
``s [objeto]`` | vender objeto
``s *`` | vender todos los objetos grises
``s vendor`` | vender todos los objetos que se puedan vender
``b [objeto]`` | comprar objeto
``2g 3s 5c`` | darte oro
``bank [objeto]`` | depositar objeto en el banco
``bank -[objeto]`` | retirar objeto del banco
``gb [objeto]`` | depositar objeto en el banco de la hermandad
``gb -[objeto]`` | retirar objeto del banco de la hermandad
``outfit ?`` | Listar tus indumentarias guardadas y mostrar la ayuda de uso de indumentarias.
``outfit <nombre> +[objeto]`` | Añadir el objeto(s) enlazado a la indumentaria <nombre> (la crea si es nueva).
``outfit <nombre> -[objeto]`` | Eliminar el objeto(s) enlazado de la indumentaria <nombre>.
``outfit <nombre> equip`` | Equipar los objetos guardados en la indumentaria <nombre>.
``outfit <nombre> replace`` | Desequipar todo lo que lleve puesto actualmente y luego equipar la indumentaria <nombre>.
``outfit <nombre> update`` | Sobrescribir la indumentaria <nombre> con los objetos actualmente equipados del bot.
``outfit <nombre> reset`` | Borrar todos los objetos de la indumentaria <nombre>.


## Misiones

comando | acción
:---|:---
``quests`` | mostrar resumen de misiones
``quests all`` | muestra una lista con enlaces de todas las misiones en el registro de misiones
``accept [misión]`` | aceptar misión en el asignador de misiones seleccionado
``accept *`` | aceptar todas las misiones en el asignador de misiones seleccionado
``drop [misión]`` | abandonar misión
``r [objeto]`` | elegir recompensa de misión
``[misión]`` | mostrar el estado de la misión y sus objetivos
``talk`` | hablar con el PNJ seleccionado (para completar una misión)
``u [objeto del juego]`` | usar objeto del juego (usa el comando "los" para obtener el enlace del objeto del juego)

## Comandos generales de Mascotas
comando | acción
:---|:---
``pet aggressive`` | cambiar la actitud de la mascota a agresiva
``pet passive`` | cambiar la actitud de la mascota a pasiva
``pet defensive`` | cambiar la actitud de la mascota a defensiva
``pet stance`` | mostrar la actitud actual de la mascota
``pet attack`` | la mascota ataca al objetivo seleccionado
``pet follow`` | la mascota sigue a su maestro
``pet stay`` | la mascota permanece en el lugar

## Comandos de domesticación del Cazador
comando | acción
:---|:---
``tame`` | ayuda de domesticación
``tame name "nombre"`` | invocar una mascota domesticable por nombre
``tame id "id"`` | invocar una mascota domesticable por ID de criatura de la base de datos
``tame family`` | ayuda de familia de domesticación
``tame family "familia"`` | invocar aleatoriamente una mascota domesticable de la familia dada
``tame rename "nuevo nombre"`` | renombrar la mascota actual y actualizar su nombre en la interfaz de usuario del cliente

## Vinculación de cuentas para control de Altbot

Como alternativa a controlar los personajes desde tu propia cuenta o cuentas de miembros de la hermandad, esto permite vincular diferentes cuentas entre sí para permitir el control de los personajes como Altbots. Esto se basa en la opción ``AiPlayerbot.AllowTrustedAccountBots = 1`` en el archivo de configuración de playerbots.

comando | acción
:---|:---
``.playerbots account setKey unValorDeClaveDeSeguridadDefinidoPorElJugador`` | Definir una clave de seguridad (securityKey) para la cuenta actual (la clave se sobrescribirá si se define varias veces)
``.playerbots account link NOMBREDECUENTA unValorDeClaveDeSeguridadDefinidoPorElJugador`` | Vincular una cuenta mediante su clave de seguridad (securityKey)
``.playerbots account linkedAccounts`` | Muestra una lista de cuentas que actualmente están vinculadas con esta cuenta
``.playerbots account unlink NOMBREDECUENTA`` | Eliminar una cuenta vinculada (esto eliminará el enlace en ambos lados, asegurando que el acceso a los personajes se pueda cancelar desde ambos lados en cualquier momento)

## Profesiones

estrategia | descripción
:---|:---
``master fishing`` | La estrategia se añade automáticamente cuando ``EnableFishingWithMaster`` está activado en la configuración. La estrategia se puede añadir manualmente. La estrategia se elimina automáticamente si se está más lejos de agua que ``EndFishingWithMaster``. La estrategia también sobrescribe la distancia de seguimiento a `FishingDistanceFromMaster`.

## Comandos varios

comando | action
:---|:---
``los`` | listar objetos del juego, objetos, criaturas y PNJs que el bot puede ver
``stats`` | mostrar resumen de estadísticas (inventario, oro, experiencia, etc.)
``home`` | establecer hogar en el tabernero seleccionado
``playerbot bot initself`` | CUIDADO CON ESTO - vuelve a generar TU personaje
``playerbot bot list`` | lista tus altbots (y tus otros personajes que puedes añadir como bots si lo tienes activado, pero tendría mucho cuidado si lo haces ya que luego puedes volver a generar tus otros personajes usando el comando init)
``playerbot bot tweak`` | establece el tweakvalue (parece estar relacionado con un valor de configuración que ya no está presente y la variable que cambia no parece hacer nada ya)
``playerbot bot self`` | convertirte a ti mismo en un bot, úsalo de nuevo para desactivarlo
``playerbot bot lookup`` | no hace nada excepto imprimir un mensaje de uso inútil (que dice que se supone que debes darle un parámetro de clase, pero hacerlo no cambia nada porque la función llamada es literalmente *solo* el mensaje de uso, no hay funcionalidad allí)
``.playerbots bot init=rare nombre1,nombre2,nombre3`` | reaparecer al bot a tu nivel con talentos y equipamiento raro (la asignación de equipamiento está actualmente con errores, se recomienda autogear en su lugar)
``who`` | mostrar raza, especialización, talentos, clase, nivel, nivel medio de objeto y zona actual del bot 
``who [nombre de profesión]`` | mostrar el nivel de habilidad de profesión del bot

## Anulaciones (Overrides)

Puedes anular todo e instruir al bot para que haga algo específico:

comando | descripción
:---|:---|
``do attack`` | atacar al objetivo
``do attack my target`` | atacar a mi objetivo
``do loot`` | despojar objetivo // nota: actualmente no funcional
``do add all loot`` | comprobar cada cadáver y objeto del juego para despojar // nota: actualmente no funcional

## Ayuda

El bot puede decirte todos los comandos disponibles que aceptará:

```
/w help
```

## Reacciones

Los bots realizarán automáticamente ciertas cosas según lo que esté haciendo el líder del grupo.

tu acción | reacción del bot
:---|:---
aceptar una misión | el bot también la aceptará
hablar con un asignador de misiones | el bot entregará sus misiones completadas
usar una roca de encuentro | teletransportarse usando la roca
empezar a usar un objeto del juego e interrumpir | usar el objeto del juego
abrir la ventana de comercio | mostrar el inventario y comenzar a comerciar
invitar a un grupo/banda | aceptar la invitación
iniciar comprobación de listos de banda | decir su estado de listo
montar/desmontar | montar/desmontar también
cruzar un portal de mazmorra | seguir dentro de la mazmorra


## Comandos solo para Consola

comando | acción
:---|:---
``playerbot pmon toggle`` | activa/desactiva el monitor de rendimiento
``playerbot pmon stack`` | muestra el rendimiento acumulado desde que se activó
``playerbot pmon tick`` | muestra los promedios de rendimiento del ciclo por actualización
``playerbot pmon reset`` | restablece el monitor de rendimiento
``playerbot rndbot reset`` | borra la tabla acore_playerbots.playerbots_random_bots (parece contener eventos) y requiere reiniciar el servidor después
``playerbot rndbot stats`` | imprime las estadísticas de rndbot (números de rndbots por nivel, por clase, etc.)
``playerbot rndbot reload`` | recarga playerbots.conf
``playerbot rndbot update`` | activa un "tick completo" (llamada a RandomPlayerbotMgr::UpdateAIInternal())
``playerbot rndbot init`` | vuelve a generar los rndbots (útil cuando has modificado configuraciones como el nivel mín/máx, las probabilidades de especialización, etc.)
``playerbot rndbot clear`` | restablece los bots de nuevo al nivel inicial (55 para Caballero de la Muerte)
``playerbot rndbot level`` | sube de nivel a todos los rndbots en 1
``playerbot rndbot refresh`` | resucita a los rndbots si están muertos, usa botAI->Reset(), vuelve a generar el equipamiento, manteniendo el mismo nivel
``playerbot rndbot teleport`` | teletransporta a todos los bots al área adecuada para su nivel
``playerbot rndbot revive`` | (CON ERRORES: duplicará el número de rndbots) resucitar rndbot, actualizar y teletransportar (combinación de "refresh" y "teleport")
``playerbot rndbot grind`` | (CON ERRORES: bloquea el servidor) teletransportar rndbot solo si es necesario (necesita más pruebas)
``playerbot rndbot change_strategy`` | volver a determinar si los bots están farmeando o haciendo RPG (basado en la configuración AiPlayerbot.RandomBotRpgChance)



Agradecimiento especial a Whipowill por crear el Manual de Operadores de Playerbots original https://github.com/whipowill/wow-addon-playerbots/blob/master/MANUAL.md, a fuzz1111 por contribuir con muchos comandos activos confirmados y a Ky por probar muchos comandos antiguos y nuevos.
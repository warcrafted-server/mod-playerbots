## Optimización de MySQL (Tuning)
La configuración por defecto de MySQL no es adecuada para su uso con Playerbots, y provocará un aumento de la actividad del disco y una disminución del rendimiento.

Deberías añadir/cambiar las siguientes opciones de configuración en tu archivo de MySQL, donde idealmente ```innodb_buffer_pool_size``` debería ser el 50% de tu RAM total:

```
#
# * Ajuste fino (Fine Tuning)
# Ejemplo con 64 GB de RAM

# INNODB
innodb_buffer_pool_size = 32G
innodb_io_capacity = 500
innodb_io_capacity_max = 2500
innodb_use_fdatasync = ON
innodb_buffer_pool_instances = 12
innodb_log_buffer_size = 32M

# Antigüedad máxima de los registros binarios (binary logs) - 5 días para evitar la acumulación de registros binarios
binlog_expire_logs_seconds = 432000

# Opcionalmente:
# Evitar interbloqueos de SQL (Deadlocks) tanto como sea posible
transaction_isolation="READ-COMMITTED"
```

Configuración recomendada para extender la vida útil de tu disco duro:
- En el archivo de configuración de mysql cambia/añade la línea `skip-log-bin`, la cual reduce ~75-90% de las escrituras porque omite el registro binario (Usa bajo tu propio riesgo)
- En el archivo de configuración de playerbots activa `AiPlayerbot.DisabledWithoutRealPlayer` para asegurarte de que ningún bot esté conectado mientras no haya jugadores reales
- Usa la menor cantidad posible de bots o limítate a usar solo altbots para minimizar la cantidad de escrituras

## Perfiles de actividad de bots y rendimiento
Antes de entrar en las opciones de configuración, necesitamos explicar un poco la lógica. En cada ciclo de actualización (tick) del servidor se calcula si un bot puede o no estar activo. Un bot activo consume y requiere muchísimos más recursos que un bot inactivo.

Se aplica la siguiente lógica para determinar si un bot está activo o no, aplicada en el orden explicado.

```
1. NO ACTIVO: Cuando el tiempo de actividad del servidor es menor que (cantidad máxima de bots * 0.12 segundos) 
2. SIEMPRE ACTIVO: Cuando el bot está en un campo de batalla, estancia o banda.
3. SIEMPRE ACTIVO: Cuando está en combate y no está en grupo (defenderse a sí mismo)
4. SIEMPRE ACTIVO: Si la zona donde se encuentra el bot tiene jugadores reales
5. SIEMPRE ACTIVO: Cuando el bot es miembro de una hermandad con jugadores reales
6. SIEMPRE ACTIVO: Tiene a un jugador real como maestro
7. SIEMPRE ACTIVO: Si está en grupo y el líder es un jugador real
8. SIEMPRE ACTIVO: Si está en la cola del campo de batalla
9. SIEMPRE ACTIVO: Si está buscando grupo
10. SIEMPRE ACTIVO: Si el bot tiene a un jugador real dentro de un radio de 300 yardas
11. SIEMPRE ACTIVO: Cuando el bot está en la lista de amigos de un jugador real en línea
12. SIEMPRE ACTIVO: Cuando el bot tiene más de 10 otros bots dentro de la distancia de visión (sightDistance), forzando a dispersarse
```
Estas reglas siempre se aplicarán independientemente de qué valor hayas configurado en **'AiPlayerbot.BotActiveAlone'**.

***

Todas las situaciones restantes, p. ej., bots en zonas o mapas sin jugadores reales, servidor vacío, etc., se configurarán basándose en el valor de **'AiPlayerbot.BotActiveAlone'**. Ese valor básicamente significa que el bot tiene aproximadamente un % de probabilidad de activarse solo durante unos pocos segundos. A menos que en esos pocos segundos se active una de las reglas anteriores, lo que podría dar lugar a que permanezca activo durante más tiempo.

Luego, **'AiPlayerbot.botActiveAloneSmartScale'** básicamente escala automáticamente los porcentajes de actividad basándose en la latencia, en relación con el valor configurado de **'AiPlayerbot.BotActiveAlone'**. Y solo cuando los bots se encuentran dentro del rango de nivel de los valores configurados de:
* **'AiPlayerbot.botActiveAloneSmartScaleWhenMinLevel'**
* **'AiPlayerbot.botActiveAloneSmartScaleWhenMinLevel'**

***

#### 1. Mejor rendimiento con alto número de bots.
Mi preferencia personal es mantener mis bots inactivos cuando no estoy en la zona o mapa, lo cual se aplica con la siguiente configuración y en este requisito específico no importa realmente si el escalado automático está activado o desactivado, pero lo dejo activado.

```
AiPlayerbot.BotActiveAlone = 10
AiPlayerbot.botActiveAloneSmartScale = 1
AiPlayerbot.botActiveAloneSmartScaleWhenMinLevel = 1
AiPlayerbot.botActiveAloneSmartScaleWhenMaxLevel = 80
```

#### 2. Por defecto; mejor esfuerzo para forzar el 100% de actividad pero ajustando automáticamente cuando sea necesario 
(probablemente el mejor perfil para un servidor con más jugadores reales repartidos en diferentes zonas y mapas).
Cuando quieres que todos los bots estén activos en todas las situaciones pero quieres que el servidor mecompense la actividad de los bots basándose en tu latencia, usa (básicamente mejor esfuerzo para el 100%): 
```
AiPlayerbot.BotActiveAlone = 100
AiPlayerbot.botActiveAloneSmartScale = 1
AiPlayerbot.botActiveAloneSmartScaleWhenMinLevel = 1
AiPlayerbot.botActiveAloneSmartScaleWhenMaxLevel = 80
```

#### 3. Todos los bots activos independientemente de tu latencia e impacto en el rendimiento.
```
AiPlayerbot.BotActiveAlone = 100
AiPlayerbot.botActiveAloneSmartScale = 0
AiPlayerbot.botActiveAloneSmartScaleWhenMinLevel = 1
AiPlayerbot.botActiveAloneSmartScaleWhenMaxLevel = 80
```

#### 4. Todos los bots activos y solo aplicar escalado automático en un rango de nivel (p. ej., niveles altos)
```
AiPlayerbot.BotActiveAlone = 100
AiPlayerbot.botActiveAloneSmartScale = 1
AiPlayerbot.botActiveAloneSmartScaleWhenMinLevel = 75
AiPlayerbot.botActiveAloneSmartScaleWhenMaxLevel = 80
```

***

#### Verificar el rendimiento de los bots
Usa el comando '.server info' para ver la latencia de tu servidor. La latencia general debería estar por debajo de 70-80 y los percentiles al máximo alrededor de 100, 120, 150. Junto a eso, verifica qué tan rápido ejecuta un bot tu comando. Debería ser prácticamente instantáneo. Si no es así, deberías elegir un perfil diferente y/o reducir la cantidad de bots.

Si no usas estas comprobaciones de rendimiento, podría dar lugar a comportamientos extraños e incorrectos de los bots y/o un enorme crecimiento de la huella de memoria en un tiempo relativamente corto (OOM - Out Of Memory)

##### Referencia
Uso el 'perfil 1' con 5000 bots con un AMD 5700x (4.6ghz, 6 núcleos), linux, 20GB de memoria con el siguiente resultado:

![image](https://github.com/user-attachments/assets/6760feaf-3dc7-4d7a-9534-d4183ff43284)


## Hardware recomendado
```
Memoria
 mínima: 16GB (cuando todas las cuadrículas de mapas están cargadas 11-12GB)
 preferible: 32GB o más
Núcleos de CPU:
 mínimo: 4 núcleos
 preferible: 6 o más núcleos
Velocidad de CPU:
 mínima: 3000mhz
 preferible: 4400mhz o más
```

## Configuración recomendada
worldserver.conf
```bash
# los bots podrían no recoger misiones en ciertas condiciones
Quests.IgnoreAutoAccept = 1

# rendimiento 
PreloadAllNonInstancedMapGrids = 0
SetAllCreaturesWithWaypointMovementActive = 0
DontCacheRandomMovementPaths = 0
MapUpdate.Threads = 4 or 6
MapUpdateInterval = 10
MinWorldUpdateTime = 1

# sin límite de jugadores para los bots
PlayerLimit = 0

# prevenir situaciones con errores
LeaveGroupOnLogout.Enabled = 1
```

playerbots.conf
```bash


#-------------------------------------------------------------------
# general
#-------------------------------------------------------------------
AiPlayerbot.Enabled = 1
AiPlayerbot.DeleteRandomBotAccounts = 0
AiPlayerbot.RandomBotAccountPrefix = "rndbot"

#-------------------------------------------------------------------
# randombots 
# - RandomBotMaps: 0=Reinos del Este, 1=Kalimdor, 530=Terrallende, 571=Rendimiento/Rendimiento (Northrend)
#-------------------------------------------------------------------
AiPlayerbot.RandomBotMinLevel = 1
AiPlayerbot.RandomBotMaxLevel = 80
AiPlayerbot.AutoTeleportForLevel = 1
AiPlayerbot.RandomBotMaps = 0,1,530,571
AiPlayerbot.ProbTeleToBankers = 0.25
AiPlayerbot.RandomBotMaxLevelChance = 0.01
AiPlayerbot.RandomBotFixedLevel = 0
AiPlayerbot.DisableRandomLevels = 0
AiPlayerbot.RandombotStartingLevel = 5
AiPlayerbot.SyncLevelWithPlayers = 0
AiPlayerbot.SyncQuestWithPlayer = 1
AiPlayerbot.AutoDoQuests = 1

#-------------------------------------------------------------------
# comando (equipamiento: 1 = normal, 2 = poco común, 3 = raro, 4 = épico, 5 = legendario)
#-------------------------------------------------------------------
AiPlayerbot.AutoGearQualityLimit = 4
AiPlayerbot.AutoGearScoreLimit = 0
AiPlayerbot.AutoGearCommand = 1
AiPlayerbot.MaintenanceCommand = 1
AiPlayerbot.AllowPlayerBots = 1
AiPlayerbot.AllowGuildBots = 1

#-------------------------------------------------------------------
# chat y difusión (predeterminado; RepeatDelay = 2000)
#-------------------------------------------------------------------
#AiPlayerbot.RepeatDelay = 2000
AiPlayerbot.EnableBroadcasts = 0
AiPlayerbot.RandomBotTalk = 0
AiPlayerbot.RandomBotEmote = 0
AiPlayerbot.RandomBotSuggestDungeons = 0
AiPlayerbot.EnableGreet = 0
AiPlayerbot.ToxicLinksRepliesChance = 0
AiPlayerbot.ThunderfuryRepliesChance = 0
AiPlayerbot.GuildRepliesRate = 0
AIPlayerbot.GuildFeedback = 0
AiPlayerbot.RandomBotSayWithoutMaster = 0


#-------------------------------------------------------------------
# intervalos
#-------------------------------------------------------------------
AiPlayerbot.RandomBotUpdateInterval = 20
AiPlayerbot.RandomBotCountChangeMinInterval = 1800
AiPlayerbot.RandomBotCountChangeMaxInterval = 7200
AiPlayerbot.MinRandomBotInWorldTime = 3600
AiPlayerbot.MaxRandomBotInWorldTime = 1209600
AiPlayerbot.MinRandomBotRandomizeTime = 7200
AiPlayerbot.MaxRandomBotRandomizeTime = 1209600
AiPlayerbot.RandomBotsPerInterval = 60
AiPlayerbot.MinRandomBotReviveTime = 60
AiPlayerbot.MaxRandomBotReviveTime = 300
AiPlayerbot.MinRandomBotTeleportInterval = 3600
AiPlayerbot.MaxRandomBotTeleportInterval = 18000
AiPlayerbot.RandomBotInWorldWithRotationDisabled = 31104000


#-------------------------------------------------------------------
# distancia
#-------------------------------------------------------------------
AiPlayerbot.FarDistance = 20.0
AiPlayerbot.SightDistance = 75.0
AiPlayerbot.SpellDistance = 28.5
AiPlayerbot.ShootDistance = 26.0
AiPlayerbot.ReactDistance = 150.0
AiPlayerbot.GrindDistance = 75.0
AiPlayerbot.HealDistance = 38.5
AiPlayerbot.LootDistance = 25.0
AiPlayerbot.FleeDistance = 8.0
AiPlayerbot.TooCloseDistance = 5.0
AiPlayerbot.MeleeDistance = 1.5
AiPlayerbot.FollowDistance = 1.5
AiPlayerbot.WhisperDistance = 6000.0
AiPlayerbot.ContactDistance = 0.5
AiPlayerbot.AoeRadius = 10
AiPlayerbot.RpgDistance = 200
AiPlayerbot.AggroDistance = 22


#-------------------------------------------------------------------
# relacionado con el rendimiento
#-------------------------------------------------------------------
AiPlayerbot.BotActiveAlone = 10 (usa 10% o 100%, cualquier cosa intermedia es bastante inútil)
AiPlayerbot.botActiveAloneSmartScale = 1
AiPlayerbot.botActiveAloneSmartScaleWhenMinLevel = 1
AiPlayerbot.botActiveAloneSmartScaleWhenMaxLevel = 80

PlayerbotsDatabase.WorkerThreads = 1
PlayerbotsDatabase.SynchThreads = 2
```

## Huella de memoria
La huella de memoria crece en la mayoría de los casos. Considera reiniciar tu servidor cada x horas dependiendo de tu configuración, hardware, base de jugadores/uso. 

p. ej., con una tarea cron (cronjob)
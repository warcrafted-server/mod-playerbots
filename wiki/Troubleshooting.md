# Solución de problemas

Esta página cubre los problemas más comunes encontrados al instalar y ejecutar `mod-playerbots`, basándose en la experiencia de soporte de la comunidad. Si tu problema no figura aquí, consulta el [servidor de Discord](https://discord.gg/NQm5QShwf9) o [abre una incidencia en GitHub](https://github.com/mod-playerbots/mod-playerbots/issues/new?template=bug_report.md).

---

## Tabla de contenidos

- [Problemas de compilación y construcción](#problemas-de-compilación-y-construcción)
- [Problemas de la base de datos](#problemas-de-la-base-de-datos)
- [Problemas de configuración](#problemas-de-configuración)
- [Caídas del servidor y rendimiento](#caídas-del-servidor-y-rendimiento)
- [Problemas específicos de la plataforma](#problemas-específicos-de-la-plataforma)
- [Problemas de Docker](#problemas-de-docker)
- [Problemas del cliente y de la jugabilidad](#problemas-del-cliente-y-de-la-jugabilidad)

---

## Problemas de compilación y construcción

### Cientos de errores de compilación (500+)

**Causa:** Estás compilando `mod-playerbots` contra el repositorio estándar de AzerothCore en lugar del fork requerido de Playerbots.

**Solución:** **Debes** utilizar el fork de Playerbots:

```bash
git clone https://github.com/mod-playerbots/azerothcore-wotlk.git --branch=Playerbot
```

El repositorio estándar `azerothcore/azerothcore-wotlk` no funcionará. Consulta la [Guía de instalación](Installation-Guide) para obtener instrucciones completas.

---

### Miles de advertencias de "unused parameter"

**Causa:** El código base de `mod-playerbots` aún no se ha limpiado por completo en cuanto a las advertencias del compilador. Estas son cosméticas y **no afectan a la funcionalidad**.

**Solución:** Suprime las advertencias añadiendo esto a tu comando cmake:

```bash
cmake .. -DCMAKE_CXX_FLAGS="-w"
```

O establece `-DWITH_WARNINGS=0`. Esto también acelera significativamente la recompilación, ya que el compilador omite la salida de advertencias.

---

### Un módulo de terceros no compila después de una actualización

**Causa:** El fork de AzerothCore de playerbots puede estar por detrás del AzerothCore principal (upstream) más reciente. Los módulos orientados a la versión más reciente de AC pueden hacer referencia a API o encabezados que aún no existen o que han cambiado en el fork.

**Solución:** Utiliza una versión o commit más antiguo del módulo de terceros que coincida con la versión de AC del fork. Revisa el historial de versiones del módulo o pregunta en Discord por una versión compatible conocida.

---

### Visual Studio se queda sin memoria durante la compilación (Windows)

**Solución:** En Visual Studio, ve a *Herramientas > Opciones > Proyectos y soluciones > Compilar y ejecutar* y establece el **número máximo de compilaciones paralelas de proyectos** en **4** (reduciéndolo desde el valor predeterminado).

---

## Problemas de la base de datos

### `Table 'XXXX' doesn't exist`

**Causa:** Los archivos SQL de playerbots no se importaron a la base de datos. El actualizador automático no siempre detecta los archivos SQL del módulo.

**Solución:** Importa manualmente los archivos SQL:

```bash
mysql -u acore -p acore_characters < modules/mod-playerbots/sql/characters/base/playerbots_characters.sql
mysql -u acore -p acore_world < modules/mod-playerbots/sql/world/base/playerbots_world.sql
```

> Asegúrate de importar a las **bases de datos correctas**: el SQL de personajes va a `acore_characters`, el SQL del mundo va a `acore_world`.

---

### `Unknown database 'acore_playerbots'`

**Causa:** La base de datos `acore_playerbots` no se creó, o el usuario de la base de datos no tiene permiso para acceder a ella. El módulo playerbots utiliza esta base de datos además de las bases de datos estándar `acore_characters` y `acore_world`.

**Solución:** Crea la base de datos y concede los permisos:

```sql
CREATE DATABASE IF NOT EXISTS acore_playerbots;
GRANT ALL PRIVILEGES ON acore_playerbots.* TO 'acore'@'localhost';
FLUSH PRIVILEGES;
```

A continuación, reinicia el servidor.

---

## Problemas de configuración

### Los cambios en `playerbots.conf` no tienen efecto

**Causa:** Es posible que hayas editado el archivo `.conf.dist` en el directorio fuente del módulo en lugar del archivo `.conf` en el directorio de configuración del servidor.

**Solución:** Edita el archivo de configuración en el **directorio de instalación de tu servidor**:

```
<directorio_de_instalación>/etc/modules/playerbots.conf       # Linux/macOS
<directorio_de_instalación>\configs\modules\playerbots.conf    # Windows
```

Los archivos `.conf.dist` son plantillas. El servidor lee los archivos `.conf` desde el directorio de instalación, no desde las carpetas de código fuente. Tanto `.conf.dist` como `.conf` son necesarios para que el módulo funcione correctamente.

---

### El comando `.playerbot` no existe en el juego

**Causa:** El módulo no se compiló dentro del servidor.

**Solución:**
1. Verifica que el módulo esté en `azerothcore-wotlk/modules/mod-playerbots/` antes de compilar.
2. Recompila el servidor (cmake + make/build).

---

## Caídas del servidor y rendimiento

### El tiempo de diferencia (diff time) del servidor aumenta de forma constante / el servidor va con lag

**Causa:** Demasiados bots para tu hardware, o insuficientes hilos de procesamiento.

**Solución:**
1. **Aumenta los hilos de actualización de mapas** en `worldserver.conf`:
   ```
   MapUpdate.Threads = 4
   ```
   Establécelo entre 4 y 6 para la mayoría de los sistemas (aproximadamente el número de núcleos de CPU menos 2).

2. **Reduce el número de bots.** Comienza con 50–200 bots y escala hacia arriba mientras supervisas el rendimiento. Comprueba con `.server info` en el juego.

---

### El servidor se cae en mazmorras/bandas con bots

**Posibles causas:**
- Módulos en conflicto (especialmente Individual Progression + Playerbots)
- Estrategias de bots no inicializadas para encuentros específicos

**Solución:**
1. Desactiva los módulos en conflicto para aislar el problema.
2. Actualiza a la versión más reciente de playerbots.
3. Informa de las caídas con registros completos y trazas de la pila (stack traces) como una [incidencia en GitHub](https://github.com/mod-playerbots/mod-playerbots/issues/new?template=bug_report.md).

Para obtener registros de caídas útiles:
- **Linux:** Ejecuta worldserver bajo GDB: `gdb -ex run ./worldserver` y escribe `bt` después de la caída.
- **Windows:** Revisa el registro de caídas en el directorio de tu servidor o habilita el Informe de errores de Windows.

---

## Problemas específicos de la plataforma

---

## Problemas de Docker

### Worldserver atascado en un bucle de reinicio / errores de `Unknown database`

**Causa:** El contenedor db-import de Docker no importa automáticamente los archivos SQL del módulo, y es posible que no se haya creado la base de datos `acore_playerbots`.

**Solución:**

1. Asegúrate de que la base de datos `acore_playerbots` exista y de que el usuario tenga permisos (conéctate al contenedor MySQL o usa una herramienta de administración):
   ```sql
   CREATE DATABASE IF NOT EXISTS acore_playerbots;
   GRANT ALL PRIVILEGES ON acore_playerbots.* TO 'acore'@'%';
   FLUSH PRIVILEGES;
   ```

2. Copia los archivos SQL del módulo a los directorios de importación personalizados antes de compilar:
   ```bash
   mkdir -p data/sql/custom/db_characters data/sql/custom/db_world
   cp modules/mod-playerbots/sql/characters/base/*.sql data/sql/custom/db_characters/
   cp modules/mod-playerbots/sql/world/base/*.sql data/sql/custom/db_world/
   ```

3. Reinicia los contenedores: `docker compose down && docker compose up -d --build`

---

## Problemas del cliente y de la jugabilidad

### Los bots no lanzan hechizos / les faltan facultades

**Causa:** Se están utilizando archivos DBC que no son enUS en el servidor. El sistema de hechizos de los bots depende de la búsqueda de nombres de hechizos en enUS.

**Solución:** Utiliza archivos DBC en **enUS** en el lado del servidor. Tu cliente de juego puede estar en cualquier idioma — solo los archivos DBC del lado del servidor deben ser enUS.

---

### Bots atascados en nivel 1 tras horas de ejecución

**Causa:** Los bots necesitan tiempo y una configuración adecuada para subir de nivel. En el primer inicio con muchos bots, el sistema se está inicializando.

**Solución:**
1. Deja que el servidor se ejecute durante un ciclo completo (revisa `playerbots.conf` para ver los intervalos de actualización de los bots).
2. Asegúrate de que esté configurado `AiPlayerbot.RandomBotAutologin = 1`.
3. Revisa los registros del servidor en busca de errores de SQL o de búsqueda de rutas (pathfinding) que puedan estar impidiendo la actividad de los bots.

---

## ¿Aún necesitas ayuda?

- Consulta el canal `#support` del [servidor de Discord](https://discord.gg/NQm5QShwf9)
- Busca en las [incidencias existentes de GitHub](https://github.com/mod-playerbots/mod-playerbots/issues)
- [Abre una nueva incidencia](https://github.com/mod-playerbots/mod-playerbots/issues/new?template=bug_report.md) con tus registros, configuración y detalles de la plataforma
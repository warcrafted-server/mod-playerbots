# Guía de Instalación

Esta guía cubre la instalación de `mod-playerbots` en una **instalación limpia** o la migración desde una instalación **existente de AzerothCore**. Las plataformas soportadas son **Ubuntu**, **Windows** y **macOS**.

> **Importante:** `mod-playerbots` requiere un fork personalizado de AzerothCore — el repositorio estándar de AzerothCore no funcionará. Este es el error de instalación más común. Consulta los [Requisitos](#requisitos) a continuación.

---

## Tabla de Contenidos

- [Guía de Instalación](#guía-de-instalación)
  - [Tabla de Contenidos](#tabla-de-contenidos)
  - [Requisitos](#requisitos)
    - [El Fork de AzerothCore para Playerbots](#el-fork-de-azerothcore-para-playerbots)
    - [Compatibilidad con Boost (Windows)](#compatibilidad-con-boost-windows)
  - [Instalación Limpia (Desde Código Fuente)](#instalación-limpia-desde-código-fuente)
    - [1. Clonar los Repositorios](#1-clonar-los-repositorios)
    - [2. Seguir la Guía de Instalación de AzerothCore](#2-seguir-la-guía-de-instalación-de-azerothcore)
      - [Notas de Compilación Específicas de Playerbots](#notas-de-compilación-específicas-de-playerbots)
    - [3. Configuración de la Base de Datos de Playerbots](#3-configuración-de-la-base-de-datos-de-playerbots)
    - [4. Configurar Playerbots](#4-configurar-playerbots)
    - [5. Iniciar el Servidor](#5-iniciar-el-servidor)
  - [Migración Desde una Instalación Existente de AzerothCore](#migración-desde-una-instalación-existente-de-azerothcore)
    - [Pasos de Migración](#pasos-de-migración)
  - [Instalación con Docker](#instalación-con-docker)
    - [Pasos](#pasos)
  - [Añadir Otros Módulos](#añadir-otros-módulos)
  - [Actualizar tu Instalación](#actualizar-tu-instalación)

---

## Requisitos

### El Fork de AzerothCore para Playerbots

**Debes utilizar el fork de Playerbots de AzerothCore.** El repositorio estándar `azerothcore-wotlk` **no** funcionará — obtendrás cientos de errores de compilación si intentas compilar `mod-playerbots` contra el núcleo estándar.

El repositorio correcto es:

```
https://github.com/mod-playerbots/azerothcore-wotlk (branch: Playerbot)
```

> **¿Por qué un fork?** `mod-playerbots` requiere modificaciones en el código base de AzerothCore que no pueden implementarse como un módulo independiente estándar. El fork incluye estos cambios en el núcleo y se actualiza regularmente desde el AzerothCore original.

### Compatibilidad con Boost (Windows)

Se sabe que Boost 1.87+ es incompatible con algunas compilaciones de AzerothCore. Utiliza Boost 1.78–1.83 para obtener los mejores resultados.

---

## Instalación Limpia (Desde Código Fuente)

### 1. Clonar los Repositorios

```bash
git clone https://github.com/mod-playerbots/azerothcore-wotlk.git --branch=Playerbot
cd azerothcore-wotlk/modules
git clone https://github.com/mod-playerbots/mod-playerbots.git --branch=master
```

Esto te proporciona el fork correcto de AzerothCore con el módulo `mod-playerbots` dentro del directorio `modules/`.

### 2. Seguir la Guía de Instalación de AzerothCore

A partir de este punto, sigue la **[Guía de Instalación de AzerothCore](https://www.azerothcore.org/wiki/installation)** estándar para tu plataforma. La guía cubre:

- [Requisitos](https://www.azerothcore.org/wiki/requirements) (por plataforma: [Windows](https://www.azerothcore.org/wiki/windows-requirements), [Linux](https://www.azerothcore.org/wiki/linux-requirements), [macOS](https://www.azerothcore.org/wiki/macos-requirements))
- [Instalación del Núcleo](https://www.azerothcore.org/wiki/core-installation) (por plataforma: [Windows](https://www.azerothcore.org/wiki/windows-core-installation), [Linux](https://www.azerothcore.org/wiki/linux-core-installation), [macOS](https://www.azerothcore.org/wiki/macos-core-installation))
- [Configuración del Servidor](https://www.azerothcore.org/wiki/server-setup)
- [Instalación de la Base de Datos](https://www.azerothcore.org/wiki/database-installation)
- [Redes](https://www.azerothcore.org/wiki/networking)
- [Pasos Finales del Servidor](https://www.azerothcore.org/wiki/final-server-steps)
- [Configuración del Cliente](https://www.azerothcore.org/wiki/client-setup)

Sigue todos los pasos utilizando el fork de Playerbots que clonaste en el Paso 1 (no el repositorio estándar de AzerothCore). El proceso de compilación es idéntico — la única diferencia es el repositorio de origen.

#### Notas de Compilación Específicas de Playerbots

> **Advertencias del compilador:** La compilación producirá muchas advertencias de "unused parameter" y de otro tipo. Estas son **cosméticas y no afectan a la funcionalidad**. Para suprimirlas y acelerar la recompilación, añade `-DCMAKE_CXX_FLAGS="-w"` o `-DWITH_WARNINGS=0` a tu comando cmake.

> **Windows — Memoria de Visual Studio:** Si Visual Studio se queda sin memoria durante la compilación, ve a *Herramientas > Opciones > Proyectos y soluciones > Compilar y ejecutar* y establece el "número máximo de compilaciones paralelas de proyectos" en **4**.

> **Idioma de DBC:** Utiliza archivos DBC en **enUS** en el lado del servidor. El sistema de hechizos de los bots depende de los nombres de hechizos en enUS. El idioma de tu cliente de juego puede ser cualquiera — solo importan los archivos DBC del lado del servidor.

### 3. Configuración de la Base de Datos de Playerbots

El módulo playerbots utiliza su propia base de datos (`acore_playerbots`) además de las bases de datos estándar de AzerothCore. Tras completar la configuración de la base de datos de AzerothCore, crea la base de datos de playerbots y concede los permisos:

```sql
CREATE DATABASE IF NOT EXISTS acore_playerbots;
GRANT ALL PRIVILEGES ON acore_playerbots.* TO 'acore'@'localhost';
FLUSH PRIVILEGES;
```

El actualizador automático del servidor poblará la mayoría de las tablas en la primera ejecución. Sin embargo, **es posible que los archivos SQL de playerbots deban importarse manualmente** si el actualizador automático no los detecta:

```bash
# Desde el directorio azerothcore-wotlk

# 1. Importar las adiciones de playerbots a acore_characters
for f in modules/mod-playerbots/data/sql/characters/base/*.sql; do
  mysql -u acore -p acore_characters < "$f"
done

# 2. Importar las adiciones de playerbots a acore_world
for f in modules/mod-playerbots/data/sql/world/base/*.sql; do
  mysql -u acore -p acore_world < "$f"
done
```

> **Comprobación:** Si ves errores como `Table 'playerbots_random_bots' doesn't exist` o `Unknown database 'acore_playerbots'` al iniciar el servidor, asegúrate de que la base de datos se haya creado y que los archivos SQL se hayan importado como se muestra arriba.

### 4. Configurar Playerbots

Después de compilar e instalar, habrá un archivo `playerbots.conf.dist` en el directorio de configuración de tu servidor (en `etc/modules/` o `configs/modules/` según la plataforma).

1. **Copia el archivo dist para crear tu configuración:**
   ```bash
   cp playerbots.conf.dist playerbots.conf
   ```

2. **Edita `playerbots.conf`** — ajustes clave para comenzar:

> **Crítico:** Edita siempre el archivo `.conf` en el **directorio de instalación/configuración de tu servidor**, no el archivo `.conf.dist` en la carpeta de código fuente del módulo. Los cambios en `.conf.dist` o en archivos del directorio de origen `modules/` no tienen efecto en el servidor en ejecución. Tanto el archivo `.conf.dist` como el `.conf` deben estar presentes para que el módulo funcione.

3. **Aumenta los hilos de actualización de mapas** en `worldserver.conf`. Este es el ajuste de rendimiento individual con mayor impacto para playerbots:

   ```
   MapUpdate.Threads = 4
   ```

   Establécelo entre 4 y 6 para la mayoría de sistemas (aproximadamente el número de núcleos de CPU menos 2). El rendimiento de AzerothCore depende en gran medida del rendimiento mononúcleo, y es poco probable que veas beneficio alguno utilizando más de 8 hilos. Establecer esto en 12, 16 o más no mejora el rendimiento — de hecho, puede aumentar la carga de procesamiento.

4. **Optimiza MySQL para playerbots.** La configuración por defecto de MySQL no es adecuada para usar con playerbots y provocará una mayor actividad en disco y un menor rendimiento. Ajustes clave para añadir a tu configuración de MySQL (`my.cnf` o `my.ini`):

   ```ini
   [mysqld]
   skip-log-bin                    # Desactiva el registro binario — reduce las escrituras en disco un 75-90%. Seguro para entornos de un solo servidor que no necesiten replicación.
   innodb_buffer_pool_size = 4G    # Establecer a ~50% de la RAM total
   innodb_io_capacity = 500
   innodb_io_capacity_max = 2500
   transaction_isolation = READ-COMMITTED
   ```

   Consulta la página wiki de [Configuración de Playerbot](https://github.com/warcrafted-server/mod-playerbots/wiki/Playerbot-Configuration) para ver recomendaciones completas de optimización de MySQL, perfiles de actividad de bots, requisitos de hardware y ajustes detallados de `worldserver.conf` / `playerbots.conf`.

### 5. Iniciar el Servidor

Inicia el servidor de autenticación (auth server) y el servidor de juego (world server) como se describe en los [Pasos Finales del Servidor de AzerothCore](https://www.azerothcore.org/wiki/final-server-steps).

En el primer inicio, el servidor creará cuentas de bots y comenzará a iniciar sesión con ellos. Esto puede tardar varios minutos. Verás mensajes de inicio de sesión de bots en la consola — esto es normal.

---

## Migración Desde una Instalación Existente de AzerothCore

Si ya tienes un servidor AzerothCore funcionando y deseas añadir `mod-playerbots`, **no** puedes simplemente soltar el módulo en tu instalación existente. El fork de playerbots incluye modificaciones en el núcleo que no están presentes en el AzerothCore estándar.

### Pasos de Migración

1. **Haz una copia de seguridad de tus bases de datos existentes:**
   ```bash
   mysqldump -u acore -p acore_auth > auth_backup.sql
   mysqldump -u acore -p acore_characters > characters_backup.sql
   ```

   > **Consejo:** Si solo necesitas hacer una copia de seguridad de personajes específicos en lugar de toda la base de datos, puedes usar los comandos `.pdump write` y `.pdump load` dentro del juego. Por ejemplo, `.pdump write dump.sql <nombre_personaje>` exporta un solo personaje, y `.pdump load dump.sql <nombre_cuenta>` lo importa. Esta es una opción rápida si no necesitas una copia de seguridad completa de la base de datos.

2. **Cambia tu repositorio de AzerothCore al fork de Playerbots.** Desde tu directorio existente `azerothcore-wotlk`, cambia la URL remota y haz pull de la rama Playerbot:
   ```bash
   cd azerothcore-wotlk
   git remote set-url origin https://github.com/mod-playerbots/azerothcore-wotlk.git
   git fetch origin
   git checkout Playerbot
   ```

3. **Clona el módulo playerbots** dentro del directorio `modules/`:
   ```bash
   cd modules
   git clone https://github.com/mod-playerbots/mod-playerbots.git --branch=master
   cd ..
   ```

4. **Recompila el servidor** siguiendo la [Guía de Instalación de AzerothCore](https://www.azerothcore.org/wiki/installation) para tu plataforma. Dado que el código fuente ha cambiado, se recomienda una recompilación completa (elimina tu directorio `build/` y vuelve a ejecutar cmake).

5. **Crea la base de datos de playerbots y concede los permisos:**
   ```sql
   CREATE DATABASE IF NOT EXISTS acore_playerbots;
   GRANT ALL PRIVILEGES ON acore_playerbots.* TO 'acore'@'localhost';
   FLUSH PRIVILEGES;
   ```

6. **Importa los archivos SQL de playerbots** si el actualizador automático no los procesa:
   ```bash
   # Desde el directorio azerothcore-wotlk

   # 1. Importar las adiciones de playerbots a acore_characters
   for f in modules/mod-playerbots/data/sql/characters/base/*.sql; do
     mysql -u acore -p acore_characters < "$f"
   done

   # 2. Importar las adiciones de playerbots a acore_world
   for f in modules/mod-playerbots/data/sql/world/base/*.sql; do
     mysql -u acore -p acore_world < "$f"
   done
   ```

7. **Actualiza tus archivos de configuración.** Los nuevos archivos `.conf.dist` pueden contener ajustes adicionales tras la recompilación. Compáralos con tus archivos `.conf` existentes y combina las nuevas entradas. A continuación, sigue el [Paso 4: Configurar Playerbots](#4-configurar-playerbots) de arriba.

> **Nota:** Tus datos extraídos existentes (maps, vmaps, mmaps, dbc) y la configuración de conexión a la base de datos en `worldserver.conf` se pueden mantener tal como están. El actualizador automático aplicará cualquier cambio de esquema necesario en el primer inicio.

---

## Instalación con Docker

Las instalaciones con Docker cuentan con soporte limitado. Se recomienda experiencia previa con Docker.

### Pasos

1. **Clonar los repositorios:**
   ```bash
   git clone https://github.com/mod-playerbots/azerothcore-wotlk.git --branch=Playerbot
   cd azerothcore-wotlk/modules
   git clone https://github.com/mod-playerbots/mod-playerbots.git --branch=master
   cd ..
   ```

2. **Crear `docker-compose.override.yml`** en la raíz de `azerothcore-wotlk`:
   ```yml
   services:
     ac-worldserver:
       volumes:
         - ./modules:/azerothcore/modules:ro
   ```

3. **Establecer variables de entorno** para la configuración (opcional pero recomendado):
   ```yml
   services:
     ac-worldserver:
       environment:
         AC_AI_PLAYERBOT_RANDOM_BOT_AUTOLOGIN: "1"
         AC_AI_PLAYERBOT_MIN_RANDOM_BOTS: "50"
         AC_AI_PLAYERBOT_MAX_RANDOM_BOTS: "200"
       volumes:
         - ./modules:/azerothcore/modules:ro
   ```

   Los ajustes de configuración se convierten en variables de entorno pasando a mayúsculas, reemplazando `.` por `_` y añadiendo el prefijo `AC_`. Por ejemplo: `AiPlayerbot.RandomBotAutologin = 1` se convierte en `AC_AI_PLAYERBOT_RANDOM_BOT_AUTOLOGIN: "1"`.

4. **Configurar el archivo `.env`** (recomendado):
   ```bash
   cp conf/dist/env.docker .env
   ```
   Edita `.env` para establecer la contraseña de la base de datos y el usuario/grupo de Docker si es necesario. Los problemas de permisos son la causa más común de fallos en la instalación con Docker.

5. **Gestionar las importaciones de SQL para el módulo.** Es posible que el contenedor db-import de Docker no importe automáticamente los archivos SQL del módulo. Si encuentras errores como `Unknown database 'acore_playerbots'` o tablas no encontradas:
   ```bash
   # Copiar archivos SQL del módulo a los directorios de importación personalización de SQL
   cp modules/mod-playerbots/sql/characters/base/*.sql data/sql/custom/db_characters/
   cp modules/mod-playerbots/sql/world/base/*.sql data/sql/custom/db_world/
   ```

6. **Compilar y ejecutar:**
   ```bash
   docker compose up -d --build
   ```

Para más información, consulta la página [Instalación de AzerothCore con Docker](https://www.azerothcore.org/wiki/install-with-docker).

---

## Añadir Otros Módulos

Al usar módulos de terceros junto con `mod-playerbots`, ten en cuenta:

- El fork de AzerothCore para playerbots puede ir por detrás del AzerothCore principal (upstream). Los módulos diseñados para la versión más reciente de AC pueden fallar al compilar. En este caso, busca un commit o versión anterior del módulo que sea compatible.

Clona los módulos adicionales dentro del directorio `modules/` y recompila:

---

## Actualizar tu Instalación

Para actualizar tanto el núcleo como el módulo:

```bash
# Actualizar el núcleo
cd azerothcore-wotlk
git pull

# Actualizar el módulo
cd modules/mod-playerbots
git pull

# Actualizar otros módulos
cd ../mod-other-module
git pull

# Recompilar
cd ../../build
cmake ..
make -j $(nproc)
make install
```

> **Nota:** Si solo estás obteniendo actualizaciones (sin nuevas opciones de cmake ni adiciones de módulos), puedes omitir el paso `cmake ..` y simplemente ejecutar `make -j $(nproc) && make install`. Volver a ejecutar cmake solo es necesario cuando cambias opciones de compilación, añades/eliminas módulos o haces una compilación limpia.

> **Importante:** Actualiza siempre **tanto** el núcleo como el módulo conjuntamente. Ejecutar un módulo más reciente contra un núcleo más antiguo (o viceversa) puede causar errores de compilación o caídas durante la ejecución.
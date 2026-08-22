<p align="center">
    <a href="https://github.com/mod-playerbots/mod-playerbots/blob/master/README.md">English</a>
    |
    <a href="https://github.com/mod-playerbots/mod-playerbots/blob/master/README_CN.md">中文</a>
    |
    <a href="https://github.com/mod-playerbots/mod-playerbots/blob/master/README_ES.md">Español</a>
</p>


<div align="center">
  <img src="banner.png" alt="Playerbots Banner" width="700px">
</div>

<div align="center">
    <img src="https://github.com/mod-playerbots/mod-playerbots/actions/workflows/macos_build.yml/badge.svg">
    <img src="https://github.com/mod-playerbots/mod-playerbots/actions/workflows/core_build.yml/badge.svg">
    <img src="https://github.com/mod-playerbots/mod-playerbots/actions/workflows/windows_build.yml/badge.svg">
</div>

# Módulo Playerbots
`mod-playerbots` es un módulo de [AzerothCore](https://www.azerothcore.org/) que añade bots similares a jugadores a un servidor. El proyecto se basa en [Playerbots de IKE3](https://github.com/ike3/mangosbot).

Las características incluyen:

- La capacidad de iniciar sesión con personajes alternativos como bots, lo que permite a los jugadores interactuar con sus otros personajes, formar grupos, subir de nivel y más
- Bots aleatorios que deambulan por el mundo, completan misiones y se comportan como jugadores, simulando la experiencia MMO
- Bots capaces de realizar la mayoría de bandas y campos de batalla
- Ajustes altamente configurables para definir cómo se comportan los bots
- Rendimiento excelente, incluso cuando se ejecutan miles de bots

¡También tenemos un **[servidor de Discord](https://discord.gg/NQm5QShwf9)** donde puedes discutir el proyecto, hacer preguntas e involucrarte en la comunidad!

## Instalación

Las plataformas soportadas son Ubuntu, Windows y macOS. Otras distribuciones de Linux pueden funcionar, pero es posible que no reciban soporte.

> **Importante:** Todas las instalaciones de `mod-playerbots` requieren un fork personalizado de AzerothCore: [mod-playerbots/azerothcore-wotlk (rama Playerbot)](https://github.com/mod-playerbots/azerothcore-wotlk/tree/Playerbot). El repositorio estándar de AzerothCore **no** funcionará.

### Inicio rápido

```bash
git clone [https://github.com/mod-playerbots/azerothcore-wotlk.git](https://github.com/mod-playerbots/azerothcore-wotlk.git) --branch=Playerbot
cd azerothcore-wotlk/modules
git clone [https://github.com/mod-playerbots/mod-playerbots.git](https://github.com/mod-playerbots/mod-playerbots.git) --branch=master
```

Luego compila el servidor siguiendo las instrucciones específicas para cada plataforma en nuestra **[Guía de instalación](https://github.com/warcrafted-server/mod-playerbots/wiki/Installation-Guide)**.

> **Rama de pruebas:** Una rama `test-staging` está disponible con las últimas funciones y correcciones antes de que se fusionen en `master`. Para usarla, clona con `--branch=test-staging` en su lugar. Ten en cuenta que esta rama puede contener cambios inestables o que rompan la compatibilidad; úsala bajo tu propio riesgo y solo si te sientes cómodo solucionando problemas.

### Guías detalladas

| Guía | Descripción |
|---|---|
| **[Guía de instalación](https://github.com/warcrafted-server/mod-playerbots/wiki/Installation-Guide)** | Instrucciones completas paso a paso para instalaciones limpias, migración desde un AzerothCore existente, configuración de Docker, adición de módulos y actualización |
| **[Solución de problemas](https://github.com/warcrafted-server/mod-playerbots/wiki/Troubleshooting)** | Soluciones a los errores de compilación más comunes, problemas de bases de datos, errores de configuración, caídas del servidor y problemas específicos de la plataforma |

Para referencias adicionales, consulta las páginas de la [Guía de instalación de AzerothCore](https://www.azerothcore.org/wiki/installation) e [Instalar un módulo](https://www.azerothcore.org/wiki/installing-a-module).

## Documentación

La [Wiki de Playerbots](https://github.com/warcrafted-server/mod-playerbots/wiki) contiene una visión general extensa de AddOns, comandos, bandas con estrategias de bots programadas y configuraciones de rendimiento recomendadas. Ten en cuenta que la documentación puede estar incompleta o desactualizada en algunas secciones, y las contribuciones son bienvenidas.

Los bots se controlan mediante comandos de chat. Para grupos de bots más grandes, esto puede resultar incómodo. Por esta razón, miembros de la comunidad han desarrollado AddOns de cliente para permitir el control de los bots a través de la interfaz del juego. Te recomendamos consultar sus proyectos listados en la página de [AddOns y Submódulos](https://github.com/warcrafted-server/mod-playerbots/wiki/Playerbot-Addons-and-Sub%E2%80%90Modules).

## Contribuir

Este proyecto aún está en desarrollo. Animamos a cualquiera a realizar contribuciones, desde solicitudes de extracción (pull requests) hasta informar de problemas. Si encuentras algún error o experimentas caídas, te animamos a [notificarlos como problemas en GitHub](https://github.com/mod-playerbots/mod-playerbots/issues/new?template=bug_report.md). Tus valiosos comentarios nos ayudarán a mejorar este proyecto de manera colaborativa.

Si realizas contribuciones de código, `mod-playerbots` cumple con los [Estándares de Código C++](https://www.azerothcore.org/wiki/cpp-code-standards) establecidos por AzerothCore. Cada Pull Request debe incluir todos los escenarios de prueba que el autor realizó, junto con sus resultados, para demostrar que los cambios se verificaron correctamente.

Recomendamos unirse al [servidor de Discord](https://discord.gg/NQm5QShwf9) para facilitar tus contribuciones al proyecto, ya que gran parte del soporte activo se lleva a cabo a través de este servidor.

¡Por favor, haz clic en el botón "⭐" para mantenerte al día y ayudarnos a ganar más visibilidad en GitHub!

## Agradecimientos

`mod-playerbots` se basa en [ZhengPeiRu21/mod-playerbots](https://github.com/ZhengPeiRu21/mod-playerbots) y [celguar/mangosbot-bots](https://github.com/celguar/mangosbot-bots). Expresamos nuestra gratitud a [@ZhengPeiRu21](https://github.com/ZhengPeiRu21) y [@celguar](https://github.com/celguar) por sus continuos esfuerzos en mantener el módulo.

También, un agradecimiento a los muchos colaboradores que han ayudado a construir este proyecto:

<a href="https://github.com/mod-playerbots/mod-playerbots/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=mod-playerbots/mod-playerbots" />
</a>

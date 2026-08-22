## Pull

Para hacer que los bots ataquen al objetivo y permitir que el tanque genere amenaza (requiere el addon Slashin o ElvUI (no todas las versiones))
/in 8 determina el retraso antes del pull para que otros bots ataquen

```
/p @dps co +passive
/p @heal co +passive
/p @tank attack
/in 8 /p @dps co -passive
/in 8 /p @heal co -passive
```

## Ansia de sangre/Heroísmo

Hacer que los bots dejen de usar ansia de sangre/heroísmo

```
/p @shaman ss +2825,32182
```

Hacer que los bots vuelvan a usar ansia de sangre/heroísmo

```
/p @shaman ss -2825,32182
```

## Moverse en combate

Para hacer que los bots huyan contigo del peligro:

```
/p reset
/p nc -stay,+follow,+passive
/p co +passive
/p do follow
```

Para hacer que los bots te sigan y te asistan en el ataque:

```
/p nc -stay,+follow,-passive
/p co -passive
/p do follow
```

Para hacer que los bots se mantengan en el sitio y te asistan en el ataque:

```
/p nc -follow,+stay,-passive
/p co +passive
/p do stay
```

## Seleccionar como objetivo una criatura predefinida

Para enfocar a los bots en un objetivo, por ejemplo Envoltura de telaraña:

```
/target Web Wrap
/stopmacro [noharm][dead]
/script SetRaidTarget("target", 8)
```
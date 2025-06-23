# Servicios:

Los servicios a implementar deben de ser definidos técnicamente para que en el futuro se puedan mantener sin problemas y cualquiera los entienda, este documento recoge una definición técnica de cada uno de los servicios. 
La definición debe de incluir:
1. **definición del servicio**: Definición de lo que hace el servicio
2. **input**: Parámetros de entrada del servicio
3. **output**: Valores de salida del servicio, explicando el significado de cada uno de esos valores
4. **restricciones y requisitos:** Una lista de propiedades que el servicio debe de cumplir si o si 


## Servicios principales: 

### organizar_archivo

- **input:** path, none|ronda_solar: path al archivo a organizar, de tipo str (aunq en lua no importa mucho). El segundo parámetro será none si se quiere coger la ronda solar actual, sino será una ronda_solar válida en formato (%Y-%Y). 
    - Para que una ronda solar sea válida el primer año debe de ser menor al segundo por uno 

- **output:** codigo: Se devolverá un código de resultado de tipo int que tendrá uno de los siguientes valores.
    -  0 -> El archivo se ha organizado correctamente
    - -1 -> Error en el nombre del archivo
    - -2 -> Otro error

- **requisitos:** 
    - El servicio debe de apuntar en el log cada vez que se ejecute, ya sea organizado de forma correcta o que haya obtenido un error. 
        - Como se apunta en el log todavía no está definido

### generar_listados 
> Usando xlswriter.lua

- **input:** none | ronda_solar: Si recibe none entonces calcula la ronda solar actual y utilza esa, si recibe una ronda_solar válida en formato (%Y-%Y) entonces utiliza esa. 
    - Para que una ronda solar sea válida el primer año debe de ser menor al segundo por uno 

- **output:** path_1 | none , path_2 | none , codigo: Utiliza la funcionalidad de lua de devolver varios valores para devovler los dos paths a los archivos generados y el código de resultado. En el caso de error devuelve none en vez de el path resultante. Este código tomará uno de los sigueintes valores:
    -  0 -> Todo guay 
    - -1 -> Error con el archivo uno 
    - -2 -> Error con el archivo dos 
    - -3 -> Otro error cualqueira

- **requisitos:**
    - El servicio debe de apuntar en el log cada vez que se ejecute, ya sea guardando la  correcta generación de los archivos o guardando el error generado. 
    
    

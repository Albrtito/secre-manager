Los servicios principales que implementa este programa son: 

1. organizar_archivo: Implementado por parte del módulo [organizador](/src/organizador.lua), dado un archivo lo mueve a la carpeta que le corresponde si está bien nombrado. Si no está bien nombrado ofrece distintas opciónes para resolverlo y organizarlo donde le toca. 

2. generar_listados: Implementado por parte del módulo [generador](src/generador.lua), se encarga de generar el archivo de excel (.xls) con la información a retransmitir al resto del grupo.


Servicios auxiliares: 
- [ ] Servicio de logging, guardando en [logs](/src/logs) información de cada una de las operaciones realizadas
- [ ] Servicio de creación de carpetas con la estructura necesaria para el inicio de un nuevo año 
- [ ] Servicio de comprobación de firma digital, se usa en generar_listados para dar la información de forma correcta

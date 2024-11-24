```mermaid
---
title: MER BiCity
---
erDiagram
    Usuario ||--o{ Evento : "organiza"
    Usuario ||--o{ Avaliacao : "realiza"
    Usuario ||--o{ Problema : "reporta"
    Evento ||--|| Localizacao : "ocorre_em"
    Avaliacao ||--|| Infraestrutura_Cicloviaria : "avalia"
    Problema ||--|| Infraestrutura_Cicloviaria : "afeta"
    Infraestrutura_Cicloviaria ||--o{ Localizacao : "localizada_em"


```
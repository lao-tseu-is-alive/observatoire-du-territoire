# Base de données

## Objectifs
* Assurer l'intégrité des données
* Minimiser au maximum la redondance des données
* Créer un modèle assez flexible afin de pouvoir greffer d'autres thématiques que celles prises en compte au début du projet

## Système de gestion 
* Postgresql

## Modèle, Idées en vrac
###Dépendance via foreign key?
```
observatoire   
│
└───grille
│   └───grille_100m
│        │   id
│        │   geometry
│        │   ...
│   └───grille_50m
│        │   id
│        │   geometry
│        │   ...
│ 
└───indicateurs
│   └───vegetation_100m
│       │   id
│       │   fk_grille_100m NOT NULL
│       │   index_2016
│       |   index_2017
│       │   ...
│   └───vegetation_50m
        │   id
│       │   fk_grille_50m NOT NULL
│       │   index_2016
│       |   index_2017
│       │   ...


```

### Dépendance via inheritance?
```
CREATE TABLE grille_100m
(
    id                                 serial not null constraint grille_100m_pkey primary key,
    geom                               geometry(MultiPolygon, 2056),
    left                               double precision,
    bottom                             double precision,
    right                              double precision,
    top                                double precision,
);


CREATE TABLE vegetation_100m (
     index_2016          double precision,
     index_2017          double precision
) INHERITS (grille_100m);
```

### Une table pour tout?
```
CREATE TABLE grille_100m
(
    id                                 serial not null constraint grille_100m_pkey primary key,
    geom                               geometry(MultiPolygon, 2056),
    left                               double precision,
    bottom                             double precision,
    right                              double precision,
    top                                double precision,
    vegetation_index_2016              double precision,
    vegetation_index_2017              double precision
);
```

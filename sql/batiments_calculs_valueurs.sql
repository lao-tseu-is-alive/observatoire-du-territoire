-- find duplicate geometries
select *
from (
         SELECT id,
                ROW_NUMBER() OVER (PARTITION BY geom ORDER BY id asc) AS Row,
                geom
         FROM ONLY batiments
     ) dups
where dups.Row > 1;
-- find duplicate geometries by grouping and edit in qgis
SELECT COUNT(*),
       min(id) as min_id, max(id) as max_id,
       min(no_eca) as min_no_eca, max(no_eca) as max_no_eca,
       min(type) as min_type, max(type) as max_type,
       geom
FROM batiments
GROUP BY geom
HAVING COUNT(*) > 1
ORDER BY min_id;
-- just to test before update
SELECT sum(nbrhabitants) as nbrhabitants_total,
       sum(nbrlogements) as nbrlogements_total,
       min(date_part('year', dateconstruction)) as annee_construction,
       string_agg(egid::text, ',') as egid_liste,
       string_agg(idaddress::text, ',') as idaddress_liste
FROM goeland_addresse_lausanne A
WHERE st_within(A.geom, (select geom FROM batiments WHERE id=7437));

-- let's go crazy !
UPDATE  batiments B
SET
    nbrhabitants_total = (SELECT sum(nbrhabitants) FROM goeland_addresse_lausanne A WHERE st_within(A.geom,B.geom)),
    nbrlogements_total = (SELECT sum(nbrlogements) FROM goeland_addresse_lausanne A WHERE st_within(A.geom,B.geom)),
    annee_construction = (SELECT min(date_part('year', dateconstruction)) FROM goeland_addresse_lausanne A WHERE st_within(A.geom,B.geom)),
    nbradresses = (SELECT count(*) FROM goeland_addresse_lausanne A WHERE st_within(A.geom,B.geom)),
    idaddress_liste = (SELECT string_agg(idaddress::text, ',') FROM goeland_addresse_lausanne A WHERE st_within(A.geom,B.geom)),
    egid_liste = (SELECT string_agg(egid::text, ',') FROM goeland_addresse_lausanne A WHERE st_within(A.geom,B.geom))
--WHERE B.id = 7447
;
-- ensuite utiliser plugin intersection qgis pour decouper la couche batiments avec grille_100m (prefixer champs grid avec grid_id)
-- et on met a jour notre grille avec les valeurs ci-dessus
UPDATE grille_100m G
SET
    habitants = (SELECT sum(clipped_nbrhabitants) FROM batiments_intersection_by_grid B WHERE B.grid_id=G.id),
    logements = (SELECT sum(clipped_nbrlogements) FROM batiments_intersection_by_grid B WHERE B.grid_id=G.id),
    batiment_surface_hors_sol = (SELECT sum(clipped_surface) FROM batiments_intersection_by_grid B WHERE B.grid_id=G.id AND B.type IN ('BAT', 'COUV')) ,
    batiment_surface_totale = (SELECT sum(clipped_surface) FROM batiments_intersection_by_grid B WHERE B.grid_id=G.id)
;

UPDATE grille_100m
SET
    batiment_pourcent_surface_hors_sol = (batiment_surface_hors_sol/surface_hexagone),
    batiment_pourcent_surface_totale = (batiment_surface_totale/surface_hexagone)

create table if not exists batiments
(
	id serial not null
		constraint batiments_pkey
			primary key,
	geom geometry(MultiPolygon,2056),
	gid integer,
	no_eca varchar(10),
	numcom bigint,
	design_id bigint,
	design varchar(40),
	type varchar(30),
	id_go bigint,
	gid_old bigint,
	nom_com varchar(40),
	id_go_missing boolean,
	surface_totale_origine double precision,
	nbrhabitants_total integer,
	nbrlogements_total smallint,
	annee_construction integer,
	nbradresses smallint,
	idaddress_liste text,
	egid_liste text
);

comment on table batiments is 'batiments de cs_bati_pol (état 20210714) clippé sur limite Lausanne ';

comment on column batiments.id_go is 'identifiant goéland thing de ce batiment';

comment on column batiments.surface_totale_origine is 'surface totale de ce batiment avant le clipping';

comment on column batiments.nbrhabitants_total is 'somme des habitants pour toutes les adresses de ce batiment complet';

comment on column batiments.nbrlogements_total is 'somme des logements pour toutes les adresses de ce batiment complet';

comment on column batiments.nbradresses is 'nombre de point adresses pour ce batiment';

comment on column batiments.idaddress_liste is 'liste des identifiants adresses goélands pour ce batiment séparés par des virgules';

comment on column batiments.egid_liste is 'liste des EGID pour ce batiment séparés par des virgules';

alter table batiments owner to observatoire;

create index if not exists sidx_batiments_geom
	on batiments using gist (geom);


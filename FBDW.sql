begin;
--schema
drop schema if exists"FBDW" cascade;
create schema"FBDW" AUTHORIZATION postgres;
set search_path to "FBDW";
--dimensions
create table D_publication(
rownames_pub int, --autoincrement( id pub) 
id_publication varchar,
message TEXT,
from_idpage varchar,
from_nompage varchar,
type_pub varchar,
link_pub varchar,
created_time_pub varchar);
create table D_commentaires(
rownames_comm int, --autoincrement( id comm) 
id_commentaire varchar,
id_reply varchar,
message TEXT,
from_id varchar,
from_name varchar,
created_time_com varchar);
create table Temps(
idtemps int,
heure int, 
jour int,
mois int,
annee int);
create table D_Replies(
rownames_r int, --autoincrement( id rep) 
id_reply varchar,
message_reply TEXT,
from_id_r varchar,
from_name_r varchar,
created_time_r varchar);
create table D_page(
rownames_page int, --autoincrement( id rep) 
id_page varchar,
namepage varchar,
Fan_count int);
--table de faits
create table Reactions_pub(
id_publication varchar,
idtemps int,
likes_count int,
shares_count int,
comments_count int, 
love_count int, 
haha_count int,
angry_count int, 
sad_count int, 
wouah_count int);
create table Reactions_comm(
id_publication varchar,
id_commentaire varchar,
idtemps int,
likes_count int,
comments_count int, 
love_count int, 
haha_count int,
angry_count int, 
sad_count int, 
wouah_count int);
create table Stat_Page(
id_page varchar,
fans_counts int,
idtemps int,
rate float);

--primarykeys
alter table Temps add primary key(idtemps);
alter table D_publication add primary key(id_publication);
alter table Reactions_pub add primary key(idtemps, id_publication);
alter table D_commentaires add primary key(id_commentaire);
alter table D_Replies add primary key(id_reply);
alter table D_page add primary key(id_page);
alter table Reactions_comm add primary key(idtemps, id_publication,id_commentaire);
alter table Stat_Page add primary key(idtemps, id_page);
--foreignkeys
alter table Reactions_pub add foreign key(idtemps) references Temps,add foreign key(id_publication) references D_publication;
alter table D_commentaires add foreign key(id_reply) references D_Replies;
alter table Reactions_comm add foreign key(idtemps) references Temps,add foreign key(id_commentaire) references D_commentaires,add foreign key(id_publication) references D_publication;
alter table Stat_Page add foreign key(idtemps) references Temps,
add foreign key(id_page) references D_page;
commit;


-- MABD TP1 SQL avec la base MONDIAL


-- -------------------- binome -------------------------
-- NOM KIM
-- Prenom Kyungtaek

-- NOM
-- Prenom
-- -----------------------------------------------------

-- pour se connecter à oracle:
-- sqlplus E1234567/E1234567@oracle
-- remplacer E12345657 par la lettre E suivie de votre numéro de login

set sqlbl on
set linesize 150

prompt schema de la table Country
desc Country

prompt schema de la table City
desc City

prompt schema de la table IsMember
desc IsMember

prompt schema de la table City
desc City

-- pour afficher un nuplet entier sur une seule ligne
column name format A15
column capital format A15
column province format A20

-- Requete 0

select * from Country where name = 'France';

-- Requete 1
prompt


-- Requete 2
prompt

-- Requete 7
select c.code, count(*)
from Borders b, Country c
where b.country1 =  c.code or
      b.country2 = c.code
group by c.code
order by c.code;

select * from Mondial.R7;

--Requete 8
select c1.code, sum(c2.population)
from Borders b, Country c1, Country c2
where (b.country1 = c1.code and
      b.country2 = c2.code) or
      (b.country2 = c1.code and
      b.country1 = c2.code)
group by c1.code
order by c1.code;

select * from Mondial.R8;

--Requete 9


-- Requete 10

select o.name, count(*), sum(c.population)
from Organization o, isMember m, Country c
where o.abbreviation = m.organization and
      m.country = c.code
group by o.abbreviation, o.name;

-- Requete 12

select c.name, max(m.height)
from encompasses e, Country c, Mountain m, Geo_Mountain gm
where e.continent = 'America' and
      e.country = c.code and
      gm.country = c.code and
      gm.mountain = m.name
group by c.code, c.name;

select distinct c.name, m.height, m.name
from encompasses e, Country c, Mountain m, Geo_Mountain gm
where e.continent = 'America' and
      e.country = c.code and
      gm.country = c.code and
      gm.mountain = m.name and
      (c.code, m.height) in
      (select c1.code, max(m1.height)
      from encompasses e1, Country c1, Mountain m1, Geo_Mountain gm1
      where e1.continent = 'America' and
          e1.country = c1.code and
  	  gm1.country = c1.code and
 	  gm1.mountain = m1.name
	  group by c1.code, c1.name)
;



select * from Mondial.R12;

-- Requete 13

select * from Mondial.R13;

select r1.name
from River r1
where r1.river = 'Nile';

-- Requete 14

select * from Mondial.R14;

select distinct r1.name
from River r1, River r2, River r3
where r1.river = 'Nile' or
      (r2.river = 'Nile' and
      r1.river = r2.name)or
      (r3.river = 'Nile' and
      r2.river = r3.name and
      r1.river = r2.name);

-- Requete 15

select * from Mondial.R15;

select sum(r2.length)
from River r2
where r2.name in (
select distinct r1.name
from River r1, River r2, River r3
where r1.river = 'Nile' or
      (r2.river = 'Nile' and
      r1.river = r2.name)or
      (r3.river = 'Nile' and
      r2.river = r3.name and
      r1.river = r2.name) or
      (r1.name = 'Nile'));

-- Requete 16 a)

select * from Mondial.R16a;

select *
from isMember;

select m2.organization, count(m2.country)
from isMember m2
group by m2.organization
having count(m2.country) = (select max(count(m.country))
       			 from isMember m
			 group by m.organization);

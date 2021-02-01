SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS country;
CREATE TABLE country (
   countryId int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
   country varchar(50) not null,
  UNIQUE KEY countryUIdx1 (country)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS city;
CREATE TABLE city (
  cityId int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  countryId int(10) unsigned not null,
  city varchar(50) not null,
  hasAirport boolean not null default true,
  UNIQUE KEY cityUIdx1 (countryId,city),
  CONSTRAINT city_country_fk1 FOREIGN KEY (countryId) REFERENCES country (countryId)
) ENGINE=InnoDB;
SET FOREIGN_KEY_CHECKS=1;

insert into country(country) values ("France");
insert into country(country) values ("China");
insert into country(country) values ("USA");
insert into country(country) values ("Italy");
insert into country(country) values ("UK");
insert into country(country) values ("Monaco");

insert into city (countryId,city,hasAirport) values (1,"Paris",true);
insert into city (countryId,city,hasAirport) values (2,"Bejing",true);
insert into city (countryId,city,hasAirport) values (3,"New York",true);
insert into city (countryId,city,hasAirport) values (4,"Napoli",true);
insert into city (countryId,city,hasAirport) values (5,"Manchester",true);
insert into city (countryId,city,hasAirport) values (5,"Birmingham",false);
insert into city (countryId,city,hasAirport) values (3,"Cincinatti",false);
insert into city (countryId,city,hasAirport) values (6,"Monaco",false);



-- Gah. Left outer join is now effectively an inner join
-- because of the where predicate
select *
from country left join city using (countryId)
where hasAirport
;

-- Hooray! I can see Monaco again thanks to
-- moving my predicate into the ON
select *
#from country co left join city ci on (co.countryId=ci.countryId);
from country co left join city ci on (co.countryId=ci.countryId and ci.hasAirport);

create table if not exists sura(
  id int not null,
  ayas int not null,
  name_arabic varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci not null,
  name_english varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci not null,
  revelation_city varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci not null,
  revelation_order int not null,
	primary key(id)
);
ALTER TABLE sura CONVERT TO CHARACTER SET utf8 COLLATE utf8_unicode_ci;

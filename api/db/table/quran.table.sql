create table if not exists quran(
  id varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci not null,
  language varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci not null,
  name varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci not null,
  name_english varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci not null,
  quran_type varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci not null,
  primary key(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

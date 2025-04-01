create table if not exists line(
  id int not null,
  surah int not null,
  aya int not null,
  manzil int not null,
  juz int not null,
  hizb int not null,
  ruku int not null,
  page int not null,
	primary key(id)
);
ALTER TABLE line CONVERT TO CHARACTER SET utf8 COLLATE utf8_unicode_ci;

create table if not exists quran_line (
  quran_id varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci not null,
  line_id int not null,
  text varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci not null,
  primary key(quran_id, line_id),
  constraint fk_quran_quran_id_quran_id foreign key (quran_id) REFERENCES quran(id),
  constraint fk_line_line_id_line_id foreign key (line_id) REFERENCES line(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

create table if not exists quran_line (
  quran_id varchar(100) character set utf8 collate utf8_general_ci not null,
  line_id int not null,
  text varchar(2000) character set utf8 collate utf8_general_ci not null,
  primary key(quran_id, line_id),
  constraint fk_quran_quran_id_quran_id foreign key (quran_id) references quran(id),
  constraint fk_line_line_id_line_id foreign key (line_id) references line(id)
) engine=innodb default charset=utf8 collate=utf8_unicode_ci;

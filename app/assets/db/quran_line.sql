create table if not exists quran_line (
    quran_id text not null
  , line_id integer not null
  , text text not null
  , primary key(quran_id, line_id)
  , constraint fk_quran_quran_id_quran_id foreign key (quran_id) REFERENCES quran(id)
  , constraint fk_line_line_id_line_id foreign key (line_id) REFERENCES line(id)
);
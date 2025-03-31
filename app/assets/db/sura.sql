create table if not exists sura(
    id integer not null
  , ayas integer not null
  , name_arabic text not null
  , name_english text not null
  , revelation_city text not null
  , revelation_order integer not null
  , primary key(id)
);
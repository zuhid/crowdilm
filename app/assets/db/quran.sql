create table if not exists quran(
    id text not null
  , language text not null
  , name text not null
  , name_english text not null
  , quran_type text not null
  , primary key(id)
);
create table if not exists line(
    id integer not null
  , surah integer not null
  , aya integer not null
  , manzil integer not null
  , juz integer not null
  , hizb integer not null
  , ruku integer not null
  , page integer not null
  , primary key(id)
)
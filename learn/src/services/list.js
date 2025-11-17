import * as api from '../tools/api.js';
import * as db from '../tools/db.js';

export async function quran() {
  return await fetchData('quran', 'quran.php');
}

export async function sura() {
  return await fetchData('sura', 'sura.php');
}

export async function line() {
  return await fetchData('line', 'line.php');
}

export async function quranline(quran_id) {
  return await fetchData(`quranline`, `quranline.php?quran_id=${quran_id}`);
}

async function fetchData(key, endpoint) {
  let data = await db.get(key);
  if (data == null) {
    data = await api.get(endpoint);
    db.set(key, data);
  }
  return data;
}



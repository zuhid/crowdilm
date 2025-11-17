const DB_NAME = "crowdilm";
const DB_VERSION = 1;
const TABLE_KEY_VALUE = "keyValue";

export async function get(key) {
  const store = (await openDb()).transaction(TABLE_KEY_VALUE, "readwrite").objectStore(TABLE_KEY_VALUE);
	store.get(key).onsuccess = event => event.target.result.value;  
}

export async function set(key, value) {
  const store = (await openDb()).transaction(TABLE_KEY_VALUE, "readwrite").objectStore(TABLE_KEY_VALUE);
  store.add({ key: key, value: value });
}

function openDb() {
  return new Promise((resolve, reject) => {
    const request = indexedDB.open(DB_NAME, DB_VERSION);
    request.onupgradeneeded = (event) => {
      const db = event.target.result;
      if (!db.objectStoreNames.contains(TABLE_KEY_VALUE)) {
        const store = db.createObjectStore(TABLE_KEY_VALUE, { keyPath: "key" });
      }
    };
    request.onsuccess = (event) => resolve(event.target.result);
    request.onerror = (event) => reject(event.target.error);
  });
}

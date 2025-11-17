export function get(key) {
  return JSON.parse(localStorage.getItem(key));
}
export function set(key, object) {
  localStorage.setItem(key, JSON.stringify(object));
}

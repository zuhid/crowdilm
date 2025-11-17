export async function get(url) {
  const response = await fetch(`http://localhost:8080/${url}`);
  return response.json();
}

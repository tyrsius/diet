export async function request(url, options = {}) {
  let response = await fetch(url, {
    ...options,
    headers: {
      'Content-Type': 'application/json',
      ...options.headers
    }
  })
  if (!response.ok) {
    let error = `Request Failure ${response.statusCode}`
    try {
      let body = await response.json()
      error = new Error(JSON.parse(body).message || error)
    } catch (e) {}
    throw new Error(error)
  }
  return response.json()
}

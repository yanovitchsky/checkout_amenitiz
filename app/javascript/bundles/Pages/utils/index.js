export function getCSRFToken() {
  const csrfToken = document.querySelector("[name='csrf-token']")

  if (csrfToken) {
    return csrfToken.content
  } else {
    return null
  }
}

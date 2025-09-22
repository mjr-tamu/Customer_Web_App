import "@hotwired/turbo-rails"
import "controllers"

// Flash popup handling
function showFlashFromPayloads() {
  const payloads = Array.from(document.querySelectorAll(".flash-payload"))
  const popup = document.getElementById("flash-popup")

  if (!popup || payloads.length === 0) return

  const text = payloads
    .map(div => div.getAttribute("data-flash-message"))
    .filter(Boolean)
    .join(" • ")

  if (!text) return

  popup.textContent = text
  popup.style.display = "block"

  setTimeout(() => {
    popup.style.display = "none"
    popup.textContent = ""
  }, 3000)
}

document.addEventListener("DOMContentLoaded", showFlashFromPayloads)
document.addEventListener("turbo:load",    showFlashFromPayloads)
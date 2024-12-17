// Mobile menu toggle
let openMenuButton = document.getElementById("open-menu");
let closeMenuButton = document.getElementById("close-menu");
let mobileMenu = document.getElementById("mobile-menu");

openMenuButton.addEventListener("click", function () {
  mobileMenu.classList.remove("hidden");
  mobileMenu.classList.add("block");
  openMenuButton.setAttribute("aria-expanded", "true");
});

closeMenuButton.addEventListener("click", function () {
  mobileMenu.classList.remove("block");
  mobileMenu.classList.add("hidden");
  openMenuButton.setAttribute("aria-expanded", "false");
});

// Close the mobile menu when clicking outside
window.addEventListener("click", function (event) {
  if (
    !mobileMenu.contains(event.target) &&
    !openMenuButton.contains(event.target)
  ) {
    mobileMenu.classList.remove("block");
    mobileMenu.classList.add("hidden");
    openMenuButton.setAttribute("aria-expanded", "false");
  }
});

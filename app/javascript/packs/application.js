import { initializeVenueChoice } from "../components/venue_selection.js";

initializeVenueChoice();

const menuButton = document.getElementById("navbar-wagon-menu");
if (menuButton) {
  const menu = menuButton.closest(".dropdown");
  const setOpen = (open) => {
    menu.classList.toggle("open", open);
    menuButton.setAttribute("aria-expanded", String(open));
  };
  menuButton.addEventListener("click", () => setOpen(!menu.classList.contains("open")));
  document.addEventListener("click", (event) => {
    if (!menu.contains(event.target)) setOpen(false);
  });
  document.addEventListener("keydown", (event) => {
    if (event.key === "Escape" && menu.classList.contains("open")) {
      setOpen(false);
      menuButton.focus();
    }
  });
}

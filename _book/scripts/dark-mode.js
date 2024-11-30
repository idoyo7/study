// scripts/dark-mode.js

require(["gitbook"], function (gitbook) {
  gitbook.events.bind("start", function () {
    var button =
      '<div class="toggle-dark-mode"><button id="dark-mode-toggle">다크 모드 전환</button></div>';
    document.getElementsByTagName("body")[0].insertAdjacentHTML("beforeend", button);

    var darkMode = false;
    var darkModeToggle = document.getElementById("dark-mode-toggle");

    darkModeToggle.addEventListener("click", function () {
      darkMode = !darkMode;
      if (darkMode) {
        document.body.classList.add("dark-mode");
      } else {
        document.body.classList.remove("dark-mode");
      }
    });
  });
});


(defvar modus-catpuccin-mocha-palette
  '(
    (cursor "#f5e0dc")
    (bg-main "#1e1e2e")
    (fg-main "#cdd6f4"))
  "Replace `modus-vivendi-tinted-palette' with catpuccin-mocha colors.")



(modus-themes-theme
      'modus-catpuccin-mocha
      'modus-catpuccin-themes
      "A `catpuccin-mocha' theme built on top of `modus-themes'"
      'dark
      'modus-vivendi-tinted-palette
      'modus-catpuccin-mocha-palette
      nil)

# 🌿 24 Sekki (二十四節気)

A minimal macOS menu bar app that displays the current **Japanese seasonal period (sekki)** and its name in kanji.  
Inspired by the [smallseasons.guide](https://smallseasons.guide/) and the traditional **24 solar terms** of the Japanese calendar.

Menu bar screenshot:

<img width="56" alt="Screenshot 2025-04-22 at 11 56 04" src="https://github.com/user-attachments/assets/f0220b2b-446c-434a-b9bb-8040b3d99998" />

---



## ✨ Features

- 📆 Shows the current **sekki** (seasonal term) and kanji symbol in the macOS menu bar
- 📜 Displays localized descriptions in the menu tooltip
- 🌐 Built-in support for **multilingual UI** (English, Japanese, Russian, German)
- ⚡️ Updates automatically every hour, with minimal resource usage
- 🔒 All season data is stored **locally**, no API required

---

### 📦 Installation

> 💡 Currently only available via cloning and building in Xcode.

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/24-sekki.git
   cd 24-sekki
2.	Open 24Sekki.xcodeproj in Xcode.
3.	Build and run the project.

To run as a menu bar app, make sure to set deployment target to macOS 13+ and build in “Release” mode for best performance.

### 🌍 Localization

All seasonal names and descriptions are defined via Localizable.xcstrings, supporting:
- 🇯🇵 Japanese (kanji in the menu bar)
- 🇬🇧 English
- 🇷🇺 Russian
- 🇩🇪 German

Want to contribute another language? PRs are welcome!

### 🔧 Development

This project is written in Swift 5 using AppKit.

---

📜 License

MIT License. See LICENSE for details.

---

### 🌸 Credits

- Inspired by [smallseasons.guide](https://smallseasons.guide/)
- Translation data based on [Wikipedia: Japanese Calendar](https://en.wikipedia.org/wiki/Japanese_calendar)

---

### 🙏 Contributions

Bug fixes, translations, and small improvements are always welcome! Feel free to open a pull request.

# Crypto  <img width="50" height="50" alt="logo-transparent" src="https://github.com/user-attachments/assets/19c96d51-7df4-4d5b-8ea4-3c4ebe91020b" />

A cryptocurrency tracking app that pulls live data from the [CoinGecko](https://www.coingecko.com/en/api) API and shows coins with details, and lets the user save the amount they hold locally.

I built it while following along with [SwiftfulThinking's tutorial](https://www.youtube.com/playlist?list=PLwvDm4Vfkdphbc3bgy_LpLRQ9DDfFGcFu) on YouTube. 
I used this project to get more comfortable with SwiftUI and learn how a real app is structured, where I got to use the modern frameworks instead of the
older ones.

![Static Badge](https://img.shields.io/badge/Platforms%20-%20iPhone%20%7C%20iPad%20-%20blue?style=plastic&logo=apple)
![Static Badge](https://img.shields.io/badge/iOS%20%7C%2017%2B%20-%20%7C%20green?style=plastic&logo=ios)



## What It Does

- Browse top cryptocurrencies with live prices from CoinGecko
- View market cap, rank, and price change for each coin
- Sort coins by rank, price, or holdings, with a reverse option
- Tap into a coin for detailed stats, price change chart, and links
- Track your own holdings by saving the amount you own, stored locally
- Dark theme UI with custom navigation, launch screen, and splash screen



## Built With

- **SwiftUI** — declarative UI
- **MVVM** — architecture pattern separating views, view models, and data
- **URLSession** — networking for live market data
- **SwiftData** — local persistence for holdings
- **FileManager** — local caching for images in the caches directory
- **async/await** — structured concurrency for networking
- **@Observable** — view model state management
- **Path** — custom price history chart, drawn from scratch



## Screenshots

<img width="30%" alt="Home Screen" src="https://github.com/user-attachments/assets/9e358781-7cc4-4172-84ee-15afee5b42c3" />
<img width="30%" alt="Profile Screen" src="https://github.com/user-attachments/assets/c0d79c02-4976-4a0e-98c8-025cbdec499c" />
<img width="30%" alt="Details screen" src="https://github.com/user-attachments/assets/f4311e09-b656-43e7-b02b-302f20c18bb8" />

<img width="30%" alt="Settings Screen" src="https://github.com/user-attachments/assets/76fafebd-1410-423b-98ca-a193657d59b4" />
<img width="30%" alt="Edit Prifle Screen" src="https://github.com/user-attachments/assets/8373e132-3bfc-4d33-92bb-f108173020e1" />
<img width="30%" alt="Details Screen - Part 1" src="https://github.com/user-attachments/assets/da585d3e-f366-44c2-96e2-17a4cbc6fad9" />



[Русский](README.md) | **English**

# Universes

Two collections to choose from: Rick and Morty characters and psychic cards. An OTUS study project.

## What it does

The first screen has two rows. Rick and Morty opens a random character and the full list. The list comes from `https://rickandmortyapi.com`. A progress value shows while the data loads. If the network fails, the screen shows an error.

The psychics are on tabs too: a list, a random card, and a randomizer. Their descriptions are stored in the app, not loaded from the network.

## Stack

SwiftUI, URLSession.

## Run

```bash
git clone https://github.com/dpogonia/Universes-OTUS.git
cd Universes-OTUS
open "OTUS SUI Project.xcodeproj"
```

Run the **OTUS SUI Project** scheme on an iPhone simulator. The deployment target is iOS 26.1.

## Author

[Dmitrii Pogonia](https://github.com/dpogonia)

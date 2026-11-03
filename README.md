**Русский** | [English](README.en.md)

# Universes

Две подборки на выбор: персонажи Rick and Morty и карточки экстрасенсов. Учебный проект OTUS.

## Что умеет приложение

На первом экране два пункта. Rick and Morty открывает вкладки случайного героя и полного списка. Список берётся с `https://rickandmortyapi.com`. Пока данные грузятся, виден прогресс. Если сеть не ответила, показывается ошибка.

Экстрасенсы тоже на вкладках: список, случайная карточка и рандомайзер. Их описания лежат в приложении, не в сети.

## Стек

SwiftUI, URLSession.

## Запуск

```bash
git clone https://github.com/dpogonia/Extrasenses.git
cd Extrasenses
open "OTUS SUI Project.xcodeproj"
```

Запустите схему **OTUS SUI Project** на симуляторе iPhone. Цель сборки — iOS 26.1.

## Автор

[Dmitrii Pogonia](https://github.com/dpogonia)

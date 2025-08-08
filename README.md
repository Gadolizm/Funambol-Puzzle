# Funambol Puzzle Game

This is a SwiftUI-based 3x3 tile puzzle game built for the Funambol technical challenge. The goal is to split an image into 9 equal square tiles, allow the user to swap them by dragging, and notify the user when the puzzle is completed.

## 🧩 Features

- 3x3 puzzle board using a local image asset (dog)
- Tiles are cropped from a single square image (`FallbackImage`)
- User can swap tiles via drag and drop
- Correct tiles are locked (visually dimmed and non-draggable)
- Completion is detected automatically when all tiles are in the correct order
- Win alert is shown reactively
- Uses **Combine** for reactive state management

## ✅ Bonus Features
- Supports puzzle state validation with Combine
- Responsive to orientation changes (SwiftUI layout handles this naturally)
- Clean, testable architecture (MVVM)
- Local fallback image ensures offline support

## 📂 Structure

- `Tile.swift` – Model representing each puzzle piece
- `PuzzleViewModel.swift` – Core logic (shuffling, swapping, locking, completion detection)
- `ImageCropper.swift` – Splits the image into 9 equal tiles
- `TileDropDelegate.swift` – Handles drag & drop behavior per tile
- `ContentView.swift` – Renders the puzzle grid and win alert

## 🔧 Technologies

- Swift
- SwiftUI
- Combine
- UIKit (for image manipulation only)

## 🏗️ How it Works

1. A local asset is resized and cropped into 9 equal tiles.
2. The tiles are shuffled and assigned a `currentIndex`.
3. The user drags one tile over another to swap them.
4. Tiles in their correct positions are automatically locked.
5. When all tiles are in place, a `Combine` pipeline updates `isCompleted` to show a win alert.

## 🎯 Challenge Requirements Covered

| Requirement | Status |
|------------|--------|
| 3x3 puzzle with square tiles | ✅ |
| Load image from fallback | ✅ |
| Tile swapping by drag | ✅ |
| Lock tile in correct position | ✅ |
| Show success alert on completion | ✅ |
| Orientation-safe layout | ✅ |
| Good structure and testability | ✅ |

## 📷 Demo

> Optionally add a video or gif demo here (e.g. from QuickTime screen recording)

## 📁 Assets

- `FallbackImage.jpg`: 1024x1024 square image cropped from a public domain image. Stored in `Assets.xcassets`.

## 📦 Getting Started

1. Clone the repo
2. Open in Xcode 15+
3. Run on iPhone simulator or real device

## 🧠 Author Notes

This project uses a clean MVVM approach with Combine to handle:
- Tile locking
- Completion detection
- View state updates

If you'd like to expand it:
- Add state persistence with `UserDefaults`
- Add timer to track solving speed
- Support for loading images from photo library

## 📄 License

MIT (optional)

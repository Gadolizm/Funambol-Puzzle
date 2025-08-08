//
//  PuzzleViewModel.swift
//  FunambolPuzzle
//
//  Created by Haitham Gado on 06/08/2025.
//


import SwiftUI
import Combine

final class PuzzleViewModel: ObservableObject {
    @Published var tiles: [Tile] = []
    @Published var isCompleted: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let gridSize = 3
    
    init() {
        loadAssetTiles()
        observeCompletion()
    }
    
    private func observeCompletion() {
        $tiles
            .map { tiles in
                tiles.allSatisfy { $0.currentIndex == $0.correctIndex }
            }
            .removeDuplicates()
            .sink { [weak self] allCorrect in
                self?.isCompleted = allCorrect
            }
            .store(in: &cancellables)
    }
    
    func loadAssetTiles() {
        guard let image = UIImage(named: "smileDog") else {
            print("⚠️ Missing dog asset")
            return
        }
        createTiles(from: image, rows: gridSize, cols: gridSize)
    }
    
    private func createTiles(from image: UIImage, rows: Int, cols: Int) {
        let croppedImages = ImageCropper.crop(image: image, into: rows, cols: cols)
        
        tiles = croppedImages.enumerated().map { index, img in
            Tile(correctIndex: index,
                 currentIndex: index, // temporary
                 isLocked: false,
                 imageName: saveTempImage(img, index: index))
        }
        
        // Shuffle the tile array
        tiles.shuffle()
        
        // Update currentIndex based on new order
        for i in 0..<tiles.count {
            tiles[i].currentIndex = i
        }
        
        // Optional: lock tiles in correct place
        updateTileLocks()
    }
    
    private func saveTempImage(_ image: UIImage, index: Int) -> String {
        let name = "tile_\(index).png"
        if let data = image.pngData() {
            let url = FileManager.default.temporaryDirectory.appendingPathComponent(name)
            try? data.write(to: url)
        }
        return name
    }
    
    private func updateTileLocks() {
        for i in 0..<tiles.count {
            tiles[i].isLocked = (tiles[i].currentIndex == tiles[i].correctIndex)
        }
    }
    
    func swapTiles(from source: Tile, to target: Tile) {
        guard let sourceIndex = tiles.firstIndex(of: source),
              let targetIndex = tiles.firstIndex(of: target) else { return }
        
        tiles.swapAt(sourceIndex, targetIndex)
        
        // Update currentIndex for each tile
        tiles[sourceIndex].currentIndex = sourceIndex
        tiles[targetIndex].currentIndex = targetIndex
        
        updateTileLocks()
    }
}

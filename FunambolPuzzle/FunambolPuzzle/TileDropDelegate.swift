//
//  TileDropDelegate.swift
//  FunambolPuzzle
//
//  Created by Haitham Gado on 06/08/2025.
//


import SwiftUI
import UniformTypeIdentifiers

struct TileDropDelegate: DropDelegate {
    let targetTile: Tile
    @ObservedObject var viewModel: PuzzleViewModel
    
    func performDrop(info: DropInfo) -> Bool {
        guard let provider = info.itemProviders(for: [.text]).first else { return false }
        
        provider.loadItem(forTypeIdentifier: UTType.text.identifier, options: nil) { data, _ in
            if let data = data as? Data,
               let string = String(data: data, encoding: .utf8),
               let sourceIndex = Int(string) {
                
                DispatchQueue.main.async {
                    let sourceTile = viewModel.tiles[sourceIndex]
                    viewModel.swapTiles(from: sourceTile, to: targetTile)
                }
            }
        }
        
        return true
    }
}
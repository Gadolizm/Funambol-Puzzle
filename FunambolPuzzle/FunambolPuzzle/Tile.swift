//
//  Tile.swift
//  FunambolPuzzle
//
//  Created by Haitham Gado on 06/08/2025.
//


import SwiftUI

/// Represents a single puzzle tile.
struct Tile: Identifiable, Codable, Equatable {
    let id: UUID = UUID()
    let correctIndex: Int
    var currentIndex: Int
    var isLocked: Bool = false
    
    /// The image shown on the tile (from asset or cropped main image)
    var imageName: String
}
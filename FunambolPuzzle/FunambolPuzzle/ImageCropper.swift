//
//  ImageCropper.swift
//  FunambolPuzzle
//
//  Created by Haitham Gado on 06/08/2025.
//


import SwiftUI

import UIKit

struct ImageCropper {
    static func crop(image: UIImage, into rows: Int, cols: Int) -> [UIImage] {
        guard let cgImage = image.cgImage else { return [] }
        
        let width = cgImage.width
        let height = cgImage.height
        
        let tileWidth = width / cols
        let tileHeight = height / rows
        
        var tiles: [UIImage] = []
        
        for row in 0..<rows {
            for col in 0..<cols {
                // Flip row index for correct top-to-bottom order
                let adjustedRow = rows - 1 - row
                let rect = CGRect(
                    x: col * tileWidth,
                    y: adjustedRow * tileHeight,
                    width: tileWidth,
                    height: tileHeight
                )
                if let croppedCG = cgImage.cropping(to: rect) {
                    let croppedImage = UIImage(cgImage: croppedCG, scale: image.scale, orientation: image.imageOrientation)
                    tiles.append(croppedImage)
                }
            }
        }
        return tiles
    }
}

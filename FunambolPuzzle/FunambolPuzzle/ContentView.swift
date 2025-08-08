//
//  ContentView.swift
//  FunambolPuzzle
//
//  Created by Haitham Gado on 06/08/2025.
//
import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @StateObject private var viewModel = PuzzleViewModel()
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 1), count: 3)
    
    var body: some View {
        NavigationView {
            LazyVGrid(columns: columns, spacing: 2) {
                ForEach(viewModel.tiles.indices, id: \.self) { index in
                    let tile = viewModel.tiles[index]
                    
                    Image(uiImage: loadImage(named: tile.imageName))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipped()
                        .border(Color.gray, width: 1)
                        .opacity(tile.isLocked ? 0.6 : 1.0) // dim locked tiles
                        .onDrag {
                            // Pass the index as the drag data
                            NSItemProvider(object: "\(index)" as NSString)
                        }
                        .onDrop(of: [.text], delegate: TileDropDelegate(targetTile: tile, viewModel: viewModel))
                }
            }
            .padding()
            .navigationTitle("Puzzle Game")
            .alert("🎉 You Win!", isPresented: $viewModel.isCompleted) {
                Button("OK", role: .cancel) { }
            }
        }
    }
    
    private func loadImage(named name: String) -> UIImage {
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(name)
        return UIImage(contentsOfFile: url.path) ?? UIImage(named: "smileDog")!
    }
}

#Preview {
    ContentView()
}

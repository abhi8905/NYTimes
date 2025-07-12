//
//  CachedAsyncImage.swift
//  NYTimes
//
//  Created by Abhinav Jha on 10/07/2025.
//


import SwiftUI
import NYTKit

struct CachedAsyncImage<Content: View, Placeholder: View>: View {
    
    // MARK: - Properties
    
    private let url: URL
    private let content: (Image) -> Content
    private let placeholder: () -> Placeholder
    private let imageCache = ImageCache.shared

    @State private var image: Image?
    
    // MARK: - Initializer
    
    init(
        url: URL,
        @ViewBuilder content: @escaping (Image) -> Content,
        @ViewBuilder placeholder: @escaping () -> Placeholder
    ) {
        self.url = url
        self.content = content
        self.placeholder = placeholder
    }

    // MARK: - Body
    
    var body: some View {
        if let image = image {
            content(image)
        } else {
            placeholder()
                .task {
                    await loadImage()
                }
        }
    }
    
    // MARK: - Private Methods
    
    private func loadImage() async {
        if let cachedImage = await imageCache.get(forKey: url.absoluteString) {
            self.image = Image(uiImage: cachedImage)
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let uiImage = UIImage(data: data) {
                await imageCache.set(uiImage, forKey: url.absoluteString)
                self.image = Image(uiImage: uiImage)
            }
        } catch {
            print("Image download failed for \(url): \(error)")
        }
    }
}

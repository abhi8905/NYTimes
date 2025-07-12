//
//  ArticleRowView.swift
//  NYTimes
//
//  Created by Abhinav Jha on 10/07/2025.
//


import SwiftUI
import NYTKit

struct ArticleRowView: View, Equatable {
    let article: Article

    var body: some View {
        HStack(spacing: StyleConstants.Spacing.edge) {
            thumbnail
                .frame(
                    width: StyleConstants.Thumbnail.size,
                    height: StyleConstants.Thumbnail.size
                )
                .background(.thinMaterial)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: StyleConstants.Spacing.stack) {
                Text(article.title)
                    .font(StyleConstants.Fonts.title)
                    .lineLimit(2)
                
                Text(article.byline)
                    .font(StyleConstants.Fonts.byline)
                    .foregroundColor(StyleConstants.Colors.secondaryText)
                    .lineLimit(1)
                
                HStack {
                    Image(systemName: AppConstants.Images.calendarIcon)
                    Text(article.publishedDate)
                }
                .font(StyleConstants.Fonts.date)
                .foregroundColor(StyleConstants.Colors.secondaryText)
            }
        }
        .padding(.vertical, StyleConstants.Spacing.verticalPadding)
    }
    
    @ViewBuilder
    private var thumbnail: some View {
        if let urlString = article.media.first?.mediaMetadata.first(where: { $0.format == "Standard Thumbnail" })?.url,
           let url = URL(string: urlString) {
            CachedAsyncImage(url: url) { image in
                image.resizable().aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
        } else {
            Image(systemName: AppConstants.Images.placeholder)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.secondary)
        }
    }
    
    static func == (lhs: ArticleRowView, rhs: ArticleRowView) -> Bool {
        lhs.article == rhs.article
    }
}

#Preview {
    let article = Article(
        id: 1,
        url: "https://a.com",
        publishedDate: "2025-01-01",
        byline: "Author A",
        title: "Title A",
        abstract: "Abstract A",
        media: [],
        section: "A"
    )
    ArticleRowView(article: article)
}

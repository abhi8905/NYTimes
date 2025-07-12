//
//  ArticleDetailView.swift
//  NYTimes
//
//  Created by Abhinav Jha on 10/07/2025.
//


import SwiftUI
import NYTKit

struct ArticleDetailView: View {
    @StateObject private var viewModel: ArticleDetailViewModel

    init(article: Article) {
        _viewModel = StateObject(wrappedValue: ArticleDetailViewModel(article: article))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                articleImage
                
                VStack(alignment: .leading, spacing: StyleConstants.Detail.textSpacing) {
                    Text(viewModel.titleText)
                        .font(StyleConstants.Fonts.detailTitle)
                    
                    Text(viewModel.abstractText)
                        .font(StyleConstants.Fonts.detailAbstract)
                    
                    Divider()
                    
                    HStack {
                        Text(viewModel.sectionText)
                            .font(StyleConstants.Fonts.detailTag)
                            .padding(.horizontal, StyleConstants.Detail.tagHorizontalPadding)
                            .padding(.vertical, StyleConstants.Detail.tagVerticalPadding)
                            .background(StyleConstants.Colors.tagBackground)
                            .clipShape(Capsule())
                        
                        Spacer()
                        Text(viewModel.publishedDateString)
                            .font(StyleConstants.Fonts.detailDate)
                            .foregroundColor(StyleConstants.Colors.secondaryText)
                    }
                    
                    Text(viewModel.bylineText)
                        .font(StyleConstants.Fonts.detailByline)
                        .foregroundColor(StyleConstants.Colors.secondaryText)
                    
                    if let url = viewModel.articleURL {
                        Link(AppConstants.Links.title, destination: url)
                            .padding(.top, StyleConstants.Detail.linkTopPadding)
                    }
                }
                .padding()
            }
        }
        .navigationTitle(AppConstants.Titles.detailTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private var articleImage: some View {
        if let url = viewModel.imageURL {
            CachedAsyncImage(url: url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Rectangle()
                    .foregroundColor(StyleConstants.Colors.placeholderBackground)
                    .aspectRatio(StyleConstants.Image.aspectRatio, contentMode: .fit)
                    .overlay(ProgressView())
            }
            .padding(.bottom, StyleConstants.Detail.imageBottomPadding)
        }
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
    ArticleDetailView(article: article)
}

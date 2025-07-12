//
//  UIConstants.swift
//  NYTimes
//
//  Created by Abhinav Jha on 11/07/2025.
//


import SwiftUI

enum StyleConstants {
    
    enum Spacing {
        static let edge: CGFloat = 16
        static let stack: CGFloat = 4
        static let content: CGFloat = 12
        static let verticalPadding: CGFloat = 8
    }
    
    enum Thumbnail {
        static let size: CGFloat = 75
    }

    enum Detail {
        static let textSpacing: CGFloat = 16
        static let tagHorizontalPadding: CGFloat = 10
        static let tagVerticalPadding: CGFloat = 5
        static let linkTopPadding: CGFloat = 16
        static let imageBottomPadding: CGFloat = 16
    }
    
    enum Fonts {
        static let title: Font = .headline
        static let byline: Font = .subheadline
        static let date: Font = .caption
        static let detailTitle: Font = .title
        static let detailAbstract: Font = .body
        static let detailTag: Font = .caption.bold()
        static let detailDate: Font = .caption
        static let detailByline: Font = .subheadline.italic()
    }
    
    enum Colors {
        static let secondaryText: Color = .secondary
        static let tagBackground: Color = Color.accentColor.opacity(0.2)
        static let placeholderBackground: Color = .gray.opacity(0.1)
    }
    
    enum Image {
        static let aspectRatio: CGFloat = 1.5
    }
}

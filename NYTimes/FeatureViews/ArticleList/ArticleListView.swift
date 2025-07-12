//
//  ArticleListView.swift
//  NYTimes
//
//  Created by Abhinav Jha on 10/07/2025.
//


import SwiftUI
import NYTKit

struct ArticleListView: View {
    
    @StateObject private var viewModel: ArticleListViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: ArticleListViewModel(
            repository: NYTArticlesRepository(),
            networkMonitor: NetworkMonitor.shared
        ))
    }

    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .idle, .loading:
                    ProgressView()
                case .offline:
                    contentUnavailable(
                        AppConstants.OfflineMessages.title,
                        systemImage: AppConstants.Images.offline,
                        description: AppConstants.OfflineMessages.description
                    )
                case .failure(let errorText):
                    contentUnavailable(
                        AppConstants.ErrorMessages.genericTitle,
                        systemImage: AppConstants.Images.error,
                        description: errorText
                    ) {
                        Button("Retry") {
                            viewModel.updateFilter()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                case .success(let articles):
                    articleList(articles)
                }
            }
            .navigationTitle(AppConstants.Titles.articleList)
            .toolbar { toolbarContent }
            .refreshable {
                viewModel.updateFilter()
            }
        }
    }
    
    private func articleList(_ articles: [Article]) -> some View {
        List(articles) { article in
            NavigationLink(value: article) {
                ArticleRowView(article: article)
            }
        }
        .navigationDestination(for: Article.self) { article in
            ArticleDetailView(article: article)
        }
    }
    
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Menu {
                let endpointBinding = Binding(
                    get: { viewModel.filter.endpoint },
                    set: { viewModel.updateFilter(endpoint: $0) }
                )
                let periodBinding = Binding(
                    get: { viewModel.filter.period },
                    set: { viewModel.updateFilter(period: $0) }
                )
                
                Picker(AppConstants.Filters.endpointMenuTitle, selection: endpointBinding) {
                    ForEach(MostPopularFilter.EndpointType.allCases) { type in
                        Text(type.rawValue.capitalized).tag(type)
                    }
                }
                
                Picker(AppConstants.Filters.periodMenuTitle, selection: periodBinding) {
                    ForEach(MostPopularFilter.Period.allCases) { period in
                        Text(period.displayName).tag(period)
                    }
                }
            } label: {
                Image(systemName: AppConstants.Images.filter)
            }
        }
    }
    
    private func contentUnavailable<Actions: View>(
        _ title: String,
        systemImage: String,
        description: String,
        @ViewBuilder actions: @escaping () -> Actions = { EmptyView() }
    ) -> some View {
        ContentUnavailableView {
            Label(title, systemImage: systemImage)
        } description: {
            Text(description)
        } actions: {
            actions()
        }
    }
}

#Preview {
    ArticleListView()
}

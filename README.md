# NYTimes (SwiftUI)

`NYTimes` is a modern SwiftUI-based client that consumes the shared `nytkit` Swift Package to display the most popular articles from The New York Times API. The app focuses on clean architecture, robust error handling, and consistent user experience. It demonstrates how to build a scalable SwiftUI application using modular code.

---

## nytkit (Swift Package)

`nytkit` encapsulates the shared data and networking logic used across both UIKit and SwiftUI-based applications.

### Core Responsibilities

- **Networking**: API requests to NYTimes “Most Popular” endpoints
- **Models**: Codable entities like `Article`, `ArticleAPIResponse`, and `MostPopularFilter`
- **Caching**:
  - `ResponseCache`: Response-level caching with TTL and stale-while-revalidate logic
  - `ImageCache`: In-memory image caching for efficient thumbnail loading
- **Environment Switching**: Dynamically handles dev and production endpoints via `APIEnvironment`
- **Reachability**: `NetworkMonitor` uses `NWPathMonitor` to track connectivity changes
- **Typed Error Handling**: `APIError` provides granular decoding and network error feedback
- **State Management**: Unified `ViewState` enum simplifies UI feedback handling across clients

---

## Features

- **Screens**
  - `ArticleListView`: Displays the list of articles with filtering, pull-to-refresh, and offline support
  - `ArticleDetailView`: Shows full article content with structured layout
- **Components**
  - `ArticleRowView`: Clean, reusable list row with thumbnail, title, byline, and publish date
  - `CachedAsyncImage`: Lightweight image cache for `AsyncImage`
  - `ContentUnavailableView`: Displays offline and error states contextually
- **Live Filters**: Picker-based filtering for most viewed, shared, or emailed articles using `MostPopularFilter`
- **Connectivity Handling**: Automatic detection and UI adjustment for offline state using `NetworkMonitor`
- **Secrets Handling**: API Key is injected securely using `.xcconfig` (`Secrets.xcconfig`)
- **Styling**
  - Centralized visual configuration using `StyleConstants` for fonts, spacing, and colors

---

## Architecture

This app uses a clean MVVM architecture with a centralized `ViewState` enum to represent different UI states (`idle`, `loading`, `success`, `failure`, `offline`), enabling declarative UI rendering.

Data flows like this:

User Action → ViewModel → nytkit Repository (SPM) → NYT API
↓
ResponseCache, ViewState
↓
SwiftUI View

---

## SPM Integration

The app depends on `nytkit`, a Swift Package Manager (SPM) module. It encapsulates:

- NYT API integration using `async/await`
- Response + Image caching
- Filter models
- Endpoint building
- Error modeling and ViewState abstraction
- Offline detection

All business logic resides in the SPM for maximum reuse and testability.

---

## Highlights

- Dynamic filters (endpoint, period)
- Async loading and structured error UI
- Offline awareness with graceful fallback
- Caches responses and images for performance

---

## Configuration

You must set your API key in `Secrets.xcconfig` or `Info.plist`:

## Testing

- **Coverage**: ~95% unit test coverage for `nytkit`
- **Areas Covered**:
  - Networking layer
  - Cache logic
  - API response decoding
  - Filter logic and key generation
  - Connectivity fallback and retry behavior

---

## Installation

### Step 1: Add `nytkit` via Swift Package Manager

1. In Xcode, open **File > Add Packages...**
2. Enter your Git URL (e.g. `https://github.com/abhi8905/nytkit.git`)
3. Choose the version or branch
4. Add to your UIKit target under **Frameworks, Libraries, and Embedded Content**

> The `nytkit` package is UI-independent and can be reused across SwiftUI or other iOS clients.

---

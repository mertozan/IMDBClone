# IMDB Clone iOS App

## 📱 Project Overview
This iOS application is a clone of IMDB, built using Swift and UIKit. It provides users with a modern interface to browse movies, TV shows, and actors while implementing TMDB (The Movie Database) API for real-time data.
![Movies](https://hizliresim.com/nxx196o)

## 🌟 Key Features
* Browse popular movies, TV shows, and actors
* Detailed view for movies (TV and actor pages will come)
* Search functionality with real-time results
* Responsive layout supporting different iOS devices

## 🛠 Technical Stack
* **Language:** Swift
* **Framework:** UIKit
* **Architecture:** MVVM (Model-View-ViewModel)
* **API Integration:** TMDB API
* **UI Implementation:** Mix of XIBs and programmatic UI
* **Dependencies:** No external dependencies (Pure Swift implementation)

## 📋 Project Structure
```
IMDBClone/
├── Models/
│   ├── Movie.swift
│   ├── TVShow.swift
│   └── Actor.swift
├── Views/
│   ├── Home/
│   │   ├── HomeViewController
│   │   └── Cells/
│   ├── Search/
│   │   └── SearchViewController
│   └── Details/
│       ├── MovieDetailsViewController
│       ├── TVShowDetailsViewController
│       └── ActorDetailsViewController
├── ViewModels/
│   ├── HomeViewModel
│   ├── SearchViewModel
│   └── DetailViewModels
├── Services/
│   ├── APIService
│   └── NetworkManager
└── Utilities/
    ├── ThemeManager
    └── Extensions
```

## 🔑 Key Components

### Home Screen
* Horizontal scrolling collections for movies, TV shows, and actors
* Custom collection view cells with smooth image loading
* Direct navigation to detail views

### Search Functionality
* Real-time search results
* Debounced search implementation

### Detail Views
* Comprehensive information display
* Custom layouts for different content types
* Smooth navigation and data presentation

## 🎨 UI/UX Features
* Custom dark theme implementation
* Responsive layouts
* Smooth animations and transitions
* Custom navigation bar and tab bar styling

## 🔧 Implementation Details

### API Integration
```swift
class APIService {
    static let shared = APIService()
    private let baseURL = "https://api.themoviedb.org/3"
    
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
    func searchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void)
    // Additional API methods...
}
```

### Theme Implementation
```swift
struct ThemeManager {
    static func applyTheme() {
        // Custom theme configuration
        // Navigation bar, tab bar, and general UI styling
    }
}
```

## 🚀 Getting Started

### Prerequisites
* Xcode 13.0+
* iOS 15.0+
* TMDB API Key

### Installation
1. Clone the repository
```bash
git clone https://github.com/yourusername/IMDBClone.git
```

2. Open `IMDBClone.xcodeproj` in Xcode

3. Add your TMDB API key in `APIService.swift`
```swift
private let apiKey = "YOUR_API_KEY"
```

4. Build and run the project

## 📝 Future Improvements
* User authentication and favorites list
* Offline data persistence
* Enhanced search filters
* Trailer playback integration
* Localization support

## 🤝 Contributing
Contributions, issues, and feature requests are welcome! Feel free to check [issues page](link-to-issues).

## 📄 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author
* **Mert ÖZAN**
* GitHub: [@mertozan](https://github.com/mertozan)

## 🙏 Acknowledgments
* TMDB for providing the API
* Apple's UIKit documentation
* iOS development community

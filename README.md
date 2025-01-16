# MyLuxury: 상식과 지식 사이

## 프로젝트 소개(개인 프로젝트)
짧은 상식 및 지식을 모아놓은 캐주얼 교육 컨텐츠 앱 서비스

## 📆 개발 기간
- 2024.10 ~ 진행중

## ⚡ 담당 개발 기능
- 앱 내 모든 화면 UI 구현
- MVVM-C 디자인 패턴 구현
- 의존성 주입 컨테이너 구현
- Firestore를 활용한 사용자 인증 기능 구현
- 앱 아키텍처 구조 설계

## 📁 디렉토리 구조
```plaintext
.
├── Data
│   ├── Package.swift
│   ├── Sources
│   │   └── Data
│   │       ├── Local
│   │       ├── Network
│   │       └── Repository
│   │           ├── Member
│   │           │   
│   │           └── Post               
│   └── Tests
│
├── Domain
│   ├── Package.swift
│   ├── Sources
│   │   └── Domain
│   │       ├── Entity
│   │       ├── Enums
│   │       ├── RepositoryInterface
│   │       └── UseCase
│   └── Tests
│ 
├── Presentation
│   ├── Package.swift
│   ├── Sources
│   │   └── Presentation
│   │       ├── Base
│   │       │   ├── AppCoordinator.swift
│   │       │   ├── Login
│   │       │   └── Tab
│   │       ├── Home
│   │       │   ├── HomeCoordinator.swift
│   │       │   ├── View
│   │       │   ├── ViewController
│   │       │   └── ViewModel
│   │       ├── Library
│   │       │   ├── LibraryCoordinator.swift
│   │       │   ├── View
│   │       │   ├── ViewController
│   │       │   └── ViewModel
│   │       ├── Post
│   │       │   ├── PostCoordinator.swift
│   │       │   ├── View
│   │       │   ├── ViewController
│   │       │   └── ViewModel
│   │       ├── Search
│   │       │   ├── SearchCoordinator.swift
│   │       │   ├── View
│   │       │   ├── ViewController
│   │       │   └── ViewModel
│   │       └── Utils
│   │           ├── Constants.swift
│   │           ├── DateFormatter.swift
│   │           └── Extensions
│   └── Tests
│ 
├── MyLuxury
│   ├── App
│   │   ├── AppComponent.swift
│   │   ├── AppDelegate.swift
│   │   ├── SceneDelegate.swift
│   │   └── SplashView.swift
│   ├── Assets.xcassets
│   ├── CodeConvention.txt
│   ├── GoogleService-Info.plist
│   ├── Info.plist
│   ├── MyLuxury.entitlements
│   ├── Utils
├── MyLuxuryTests
├── MyLuxuryUITests

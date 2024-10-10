import Foundation
import UIKit

class AppComponent {
  
  let exampleBuilder: Builder
  
  
  init() {
    let urlSession = URLSession.shared
    let exampleRepository = ExampleRepositoryImpl(urlSession: urlSession)
    let exampleUsecase = ExampleUseCase(exampleRepository: exampleRepository)
    
    self.exampleBuilder = ExampleBuilder(usecase: exampleUsecase)
  }
  
}

protocol Builder {
  func build() -> UIViewController
}

class ExampleBuilder: Builder {
  private let usecase: ExampleUseCase
  
  init(usecase: ExampleUseCase) {
    self.usecase = usecase
  }
  
  func build() -> UIViewController {
    let vm = ExampleViewModel(exampleUsecase: self.usecase)
    let vc = ExampleViewController(viewModel: vm)
    return vc
  }
  
}

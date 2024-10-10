//
//  ExampleViewController.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/3/24.
//

import UIKit
import Combine

class ExampleViewController: UIViewController {
    
    private let rootView = ExampleView()
    
  private let exampleVM: ExampleViewModel
    private let input: PassthroughSubject<ExampleViewModel.Input, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
  
  init(viewModel: ExampleViewModel) {
    self.exampleVM = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        input.send(.viewDidAppear)
    }
    
    override func loadView() {
        
        self.view = rootView
    }
    
    private func bindData() {
        
        let output = exampleVM.transform(input: input.eraseToAnyPublisher())
        
        output
            .receive(on: DispatchQueue.main)
            .sink { outputEvent in
                
                switch outputEvent {
                    
                case .fetchData(let value):
                    self.rootView.exampleUILabel.text = value
                }
            }
            .store(in: &cancellables)
    }
}

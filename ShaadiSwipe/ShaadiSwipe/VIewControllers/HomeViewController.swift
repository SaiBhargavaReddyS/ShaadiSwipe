//
//  ViewController.swift
//  ShaadiSwipe
//
//  Created by Sai Bhargava Reddy on 20/03/25.
//

import UIKit
import SwiftUICore
import SwiftUI
import Combine

class HomeViewController: UIViewController {
    
    private var peopleResult: [Person] = []
    let personSelections: PersonSelections
    private var cancellables = Set<AnyCancellable>()
    
    var viewmodel = HomeViewModel(interactor: PeopleInteractor())
    
    init(personSelections: PersonSelections) {
            self.personSelections = personSelections
            super.init(nibName: nil, bundle: nil)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        settupViewModel()
        setupUI()
        setupBinding()
    }
}

extension HomeViewController {
    
    private func setupUI() {
        setTheFlashCards()
    }
    
    private func setTheFlashCards() {
        
        let swiftUIView = PackOfCards(personSelection: personSelections, cards: peopleResult)
        

        let hostingController = UIHostingController(rootView: swiftUIView)
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)

            // Set constraints for the hosting controller's view
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                hostingController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                hostingController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                hostingController.view.widthAnchor.constraint(equalToConstant: 300),
                hostingController.view.heightAnchor.constraint(equalToConstant: 400)
            ])
    }
    
    private func setupBinding() {
        
        personSelections.$acceptedPeople.sink { [weak self] people in
            print("accepted",people)
        }.store(in: &cancellables)
    }
    
}

extension HomeViewController {
    
    private func settupViewModel() {
        
        viewmodel.delegate = self
        viewmodel.fetchPeople(of: 10)
    }
}

extension HomeViewController: viewControllertoViewModelDelegate {
    
    var people: [Person] {

        get {
            peopleResult
        }
        set {
            peopleResult = newValue
        }
    }
    
    
    func reloadData() {

        setTheFlashCards()
    }
}

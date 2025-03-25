//
//  ViewController.swift
//  ShaadiSwipe
//
//  Created by Sai Bhargava Reddy on 20/03/25.
//

import UIKit
import SwiftUICore
import SwiftUI

class HomeViewController: UIViewController {
    
    private var peopleResult: [Person] = []
    
    var viewmodel = HomeViewModel(interactor: PeopleInteractor())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        settupViewModel()
        setTheFlashCards()
    }
}

extension HomeViewController {
    
    func setupUI() {
        
    }
    
    func setTheFlashCards() {
        
        let swiftUIView = PackOfCards(cards: peopleResult)
        print(swiftUIView.acceptedCards)
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

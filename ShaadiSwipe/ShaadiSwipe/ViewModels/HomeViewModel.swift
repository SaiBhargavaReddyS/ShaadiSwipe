//
//  HomeViewModel.swift
//  ShaadiSwipe
//
//  Created by Sai Bhargava Reddy on 20/03/25.
//

import UIKit

struct Person {
    var name: String
    var Image: UIImage
    var location: String
}

protocol viewControllertoViewModelDelegate: AnyObject {
    var people: [Person] { get set}
    func reloadData()
}

class HomeViewModel {
    
    var interactor: PeopleInteractor
    var delegate: viewControllertoViewModelDelegate?
    
    var people: [Result] = []
    
    init(interactor: PeopleInteractor) {
        self.interactor = interactor
    }
    
    func fetchPeople(of number: Int) {
        
        Task { @MainActor in 
            let people = try await interactor.fetchPeople(from: number)
            delegate?.people = people
            delegate?.reloadData()
        }
    }
    
    deinit {
        print("HomeViewModel deinitialized")
    }
    
}

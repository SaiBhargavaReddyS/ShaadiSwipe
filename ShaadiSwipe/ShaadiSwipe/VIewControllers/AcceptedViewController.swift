//
//  AcceptedViewController.swift
//  ShaadiSwipe
//
//  Created by Sai Bhargava Reddy on 22/03/25.
//

import UIKit
import Combine

class AcceptedViewController: UIViewController {
    let personSelections: PersonSelections
    private var cancellables = Set<AnyCancellable>()
    
    init(personSelections: PersonSelections) {
            self.personSelections = personSelections
            super.init(nibName: nil, bundle: nil)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        personSelections.$acceptedPeople.sink { [weak self] people in
            print("this is rejected people",people)
        }.store(in: &cancellables)
        // Do any additional setup after loading the view.
    }
}

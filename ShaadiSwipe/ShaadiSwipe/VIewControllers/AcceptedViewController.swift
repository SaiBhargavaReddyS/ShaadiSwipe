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
    var person: [Person] = []
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
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
        
        setupBindings()
        setupTableView()
    }
    
    private func setupBindings() {
        
        personSelections.$acceptedPeople.sink { [weak self] people in
            print("this is rejected people",people)
            self?.person = people
            self?.tableView.reloadData()
        }.store(in: &cancellables)
    }
}

extension AcceptedViewController:  UITableViewDataSource, UITableViewDelegate {
    
    private func setupTableView() {

        view.addSubview(tableView)
        

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        person.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = person[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Selected: \(person[indexPath.row])")
    }
}

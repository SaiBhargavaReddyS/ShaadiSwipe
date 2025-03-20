//
//  PeopleInteractor.swift
//  ShaadiSwipe
//
//  Created by Sai Bhargava Reddy on 20/03/25.
//

import Foundation

enum PeopleInteractor {
    
    func fetchPeople(of count: Int) async throws -> People {
        let results = try await URLSession.shared.data(from: URL(string: "https://randomuser.me/api/?results=\(count)")!)
        return try JSONDecoder().decode(People.self, from: results.0)
    }
}

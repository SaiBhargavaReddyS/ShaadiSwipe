//
//  PeopleInteractor.swift
//  ShaadiSwipe
//
//  Created by Sai Bhargava Reddy on 20/03/25.
//

import Foundation
import UIKit

public struct PeopleInteractor {
    
    func fetchPeople(of count: Int) async throws -> People {
        
        do {
            let results = try await URLSession
                .shared
                .data(from: URL(string: "https://randomuser.me/api/?results=\(count)")!)
            let people = try JSONDecoder().decode(People.self, from: results.0)
            
            return people
        } catch {
            throw error
        }
    }
    
    func fetchImageFrom(url string: String) async throws -> UIImage {
        
        do {
            let results = try await URLSession.shared.data(from: URL(string: string)!)
            return UIImage(data: results.0) ?? UIImage()
        } catch {
            throw error
        }
    }
    
    func fetchPeople(from count: Int) async throws -> [Person] {
        
        var personArray: [Person] = [] 
        do {
            let people = try await fetchPeople(of: count).results
            
            try await withThrowingTaskGroup(of: (UIImage, String, String).self) { group in
                for imageData in people {
                        group.addTask {
                            return (try await fetchImageFrom(url: imageData.picture.large),
                                    "\(imageData.name.first) \(imageData.name.last)", imageData.location.city)
                        }
                    }
                    
                    for try await imagePerson in group {
                        personArray.append(Person(name: imagePerson.1, Image: imagePerson.0, location: imagePerson.2))
                    }
                }
        } catch {
            throw error
        }
        return personArray
    }
}

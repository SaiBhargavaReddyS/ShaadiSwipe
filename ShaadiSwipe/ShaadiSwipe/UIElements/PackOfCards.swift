//
//  PackOfCards.swift
//  ShaadiSwipe
//
//  Created by Sai Bhargava Reddy on 22/03/25.
//

import SwiftUI
import UIKit

struct PackOfCards: View {
    
    @ObservedObject var personSelection: PersonSelections
    
    @State var cards: [Person] = []
    
    var body: some View {
        ZStack {
            ForEach(cards.indices, id: \.self) { id in
                SwipableCardView(image: cards[id].Image, name: "\(cards[id].name)", onRemove: {
                    direction in removeCard(at: id, direction: direction)
                })
            }
        }
        .padding()
    }
    
    func removeCard(at index: Int, direction: String) {
        
        switch direction {
        case "right":
            personSelection.acceptedPeople.append(cards[index])
        case "left":
            personSelection.rejectedPeople.append(cards[index])
        default:
            break
        }
        cards.remove(at: index)
        
    }
}

//
//  PackOfCards.swift
//  ShaadiSwipe
//
//  Created by Vamshi Reddy on 22/03/25.
//

import SwiftUI
import UIKit

struct PackOfCards: View {
    
    @State var cards: [Person] = []
    
    @State var rejectedCards: [Person] = []
    
    @State var acceptedCards: [Person] = []
    
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
            acceptedCards.append(cards[index])
        case "left":
            rejectedCards.append(cards[index])
        default:
            break
        }
        cards.remove(at: index)
        
//        print(acceptedCards, rejectedCards, cards)
        
    }
}



#Preview {
    PackOfCards()
}

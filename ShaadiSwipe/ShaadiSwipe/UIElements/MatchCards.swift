//
//  MatchCards.swift
//  ShaadiSwipe
//
//  Created by Sai Bhargava Reddy on 20/03/25.
//

import SwiftUI
import UIKit

struct SwipableCardView: View {
    
    var image: UIImage
    var name: String
    var onRemove: (String) -> Void
    
    @State private var offset = CGSize.zero
    @State private var color: Color = .gray
    @State private var status: String = ""

    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 300, height: 400)
            .foregroundColor(color)
            .overlay(
                ZStack {
                    VStack(alignment: .center, spacing: 20) {
                    Image(uiImage: image)
                            .clipShape(Circle())
                            .font(.system(size: 160))
                    Text(name)
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                }
                    .padding()
                    
                    Text(status)
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                }
            )
            .offset(x: offset.width, y: offset.height)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                        withAnimation {
                            changeColorAndStatus(width: offset.width)
                        }
                    }
                    .onEnded { gesture in
                        if abs(gesture.translation.width) > 100 {
                            let direction = gesture.translation.width < 0 ? "left" : "right"
                            withAnimation(.easeOut) {
                                offset = CGSize(
                                    width: gesture.translation.width * 2,
                                    height: 0)
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                onRemove(direction)
                            }
                        } else {
                            withAnimation(.spring()) {
                                offset = .zero
                            }
                        }
                    }
            )
            .animation(.default, value: offset)
    }

    private func changeColorAndStatus(width: CGFloat) {
        switch width {
        case -500...(-10):
            color = .red
            status = "Rejected"
        case 10...500:
            color = .green
            status = "Approved"
        default:
            color = .white
            status = ""
        }
    }
}

func createDummyImage(size: CGSize, color: UIColor) -> UIImage? {
    let rect = CGRect(origin: .zero, size: size)
    
    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    
    
    color.setFill()
    UIRectFill(rect)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    
    return image
}

#Preview {
    
    SwipableCardView(image:
                        createDummyImage(
                            size: CGSize(width: 200, height: 200),
                            color: UIColor.red) ?? UIImage(),
                     name: "Bhargava", onRemove: { x in print(x)})
}

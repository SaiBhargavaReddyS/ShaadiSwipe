//
//  MatchCards.swift
//  ShaadiSwipe
//
//  Created by Vamshi Reddy on 20/03/25.
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
//                    .onChanged { gesture in
//                        offset = gesture.translation
//                        withAnimation {
//                            changeColorAndStatus(width: offset.width)
//                        }
//                    }
//                    .onEnded { _ in
//                        withAnimation {
//                            offset = .zero
//                            color = .gray
//                            status = ""
//                        }
//                    }
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
    
    // Get the image from the current context
    let image = UIGraphicsGetImageFromCurrentImageContext()
    
    // End the image context
    UIGraphicsEndImageContext()
    
    return image
}

//struct ContentView: View {
//    var body: some View {
//        RoundedRectangle(cornerRadius: 20)
//            .fill(Color.blue) // Background color of the rectangle
//            .frame(width: 300, height: 400) // Size of the rectangle
//            .overlay(
//                VStack(spacing: 20) { // Vertical stack for the content
//                    
//                    Image(uiImage: createDummyImage(size: .init(width: 200, height: 200),
//                                                    color: .black) ?? UIImage())
//                        .clipShape(Circle()) // Make the image circular
//                        .overlay(Circle() // Add a border to the circular image
//                                .stroke(Color.yellow, lineWidth: 4)
//                        )// System image (you can replace this with your own image)
//                        .font(.system(size: 160)) // Size of the image
//                        .foregroundColor(.yellow) // Color of the image
//
//                    Text("Title") // First text
//                        .font(.largeTitle) // Font size
//                        .foregroundColor(.white) // Text color
//
//                    Text("Subtitle") // Second text
//                        .font(.title) // Font size
//                        .foregroundColor(.white.opacity(0.8)) // Text color with opacity
//                }
//                .padding() // Add padding inside the rectangle
//            )
//            .offset()
//    }
//}

#Preview {
    
    SwipableCardView(image:
                        createDummyImage(
                            size: CGSize(width: 200, height: 200),
                            color: UIColor.red) ?? UIImage(),
                     name: "Bhargava", onRemove: { x in print(x)})
//    ContentView()
}

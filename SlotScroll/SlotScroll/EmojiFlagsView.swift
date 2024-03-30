//  Created by PATCHED on 29.03.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ContentViewModel()
    let flagHeight: CGFloat = 100
    let flagWidth: CGFloat = 100
    
    @State private var flagIndex = 0
    @State private var timer: Timer?
    @State private var startTime = Date()

    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                ForEach(0..<viewModel.emojis.count) { index in
                    Text(viewModel.emojis[index])
                        .font(.system(size: 50))
                        .frame(width: flagWidth, height: flagHeight)
                        .background(Color.white)
                        .offset(y: CGFloat(index - flagIndex % viewModel.emojis.count) * flagHeight)
                        .animation(.easeInOut(duration: 1))
                }
            }
            .frame(width: flagWidth, height: flagHeight)
            .overlay(
                RoundedRectangle(cornerRadius: 1)
                    .stroke(Color.black, lineWidth: 5)
            )
            .background(Color.black)
            .clipped()
            
            Spacer()
            
            Button(action: {
                shuffleEmojis()
                flagIndex = 0
                startTime = Date()
                timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                    flagIndex += 1
                    //set time scrolling
                    if Date().timeIntervalSince(startTime) >= 1.5 {
                        timer?.invalidate()
                    }
                }
            }, label: {
                Text("Hit me!")
                    .foregroundColor(Color.white)
            })
            .padding(.horizontal, 120)
            .padding(.vertical,20)
            .background(Color.blue)
            .cornerRadius(10)
            .padding()
            
        }
        .padding()
    }
    
    // Method for shuffling the elements of the emoji array
    private func shuffleEmojis() {
        viewModel.emojis.shuffle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

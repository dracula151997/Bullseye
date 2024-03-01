//
//  AboutView.swift
//  Bullseye
//
//  Created by Hassan Mohammed on 29/02/2024.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        Group{
            VStack{
                Text("🎯 Bullseye 🎯").modifier(AboutHeadingStyle())
                Text("This is Bullseye, the game where you can win points and earn fame by dragging a slider.").modifier(AboutBodyStyle())
                Text("Your goal is to place the slider as close as possible to the target value. The closer you are, the more points you score.").modifier(AboutBodyStyle()).lineLimit(nil)
                Text("Enjoy!")
            }
            .navigationTitle("About Bullseye")
            .navigationBarTitleDisplayMode(.large)
            .background(beige, alignment: .center)
        }.background(Image("Background"))
    }
}

#Preview {
    AboutView()
}

struct AboutHeadingStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.custom("Arial Rounded MT Bold", size: 30))
            .foregroundColor(.black)
            .padding(.top, 20)
            .padding(.bottom, 20)
    }
}

struct AboutBodyStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.custom("Arial Rounded Mt Bold", size: 16))
            .padding(.leading, 60)
            .padding(.trailing, 60)
            .padding(.bottom, 20)
    }
}

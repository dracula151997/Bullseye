        //
        //  ContentView.swift
        //  Bullseye
        //
        //  Created by Hassan Mohammed on 28/02/2024.
        //

        import SwiftUI
        struct ContentView: View {
        @State var alertIsVisible = false
        @State var sliderValue = 50.0
        @State var target = Int.random(in: 1...100)
        var sliderValueRounded: Int{
            Int(self.sliderValue.rounded())
        }

        var sliderTargeDifference: Int{
            return abs(self.target - self.sliderValueRounded)
        }

        @State var score = 0
        @State var round = 0
            var body: some View {
                NavigationStack{
                    VStack {
                        // Target row
                        HStack{
                            Text("Put the bullseye as close as you can to:")
                                .modifier(LabelStyle())
                            Text("\(self.target)").modifier(ValueStyle())
                        }.padding(.top, 20)
                        Spacer()
                        // Slider row
                        HStack{
                            Text("1").modifier(LabelStyle())
                            Slider(value: self.$sliderValue, in: 1...100).animation(.easeOut, value: sliderValue)
                            Text("100").modifier(LabelStyle())
                        }
                        Spacer()
                        
                        // Button row
                        Button(action: {
                            print("Point awarded: \(self.pointsForCurrentRounded())")
                            alertIsVisible = true
                        }, label: {
                            Text("Hit me!").modifier(ButtonLargeTextStyle())
                        }).background(Image("Button")).modifier(Shadow())
                        .alert(isPresented: self.$alertIsVisible, content: {
                            Alert(title: Text(self.alertTitle()), message: Text(self.scoringMessage()), dismissButton: .cancel(Text("Awesome!")){
                                self.startNewRound()
                            })
                        })
                        Spacer()
                        // Score row
                        HStack{
                            Button(action: {
                                print("Start over button pressed!")
                                self.startNewGame()
                            }, label: {
                                HStack{
                                    Image("StartOverIcon")
                                    Text("Start over").modifier(ButtonSmallTextStyle())

                                }
                            }).background(Image("Button"))
                            Spacer()
                    
                            Text("Score:").modifier(LabelStyle())
                            Text("\(self.score)").modifier(ValueStyle())
                
                            Spacer()
                          
                            Text("Round:").modifier(LabelStyle())
                            Text("\(self.round)").modifier(ValueStyle())
                         
                                Spacer()
                            NavigationLink(destination: AboutView()){
                                HStack{
                                    Image("InfoIcon")
                                    Text("Info").modifier(ButtonSmallTextStyle())
                                }.accentColor(.green)                            }
                        }.onAppear(perform: {
                            self.startNewGame()
                        }).navigationTitle(Text("Bullseye"))
                            .navigationBarTitleDisplayMode(.inline)

                    }.background(Image("Background"))
                        .accentColor(.green)
                }
                        
            }
        func pointsForCurrentRounded() -> Int{
        let maxiumumScore =  100
        let bonus: Int
        if sliderTargeDifference == 0{
            bonus = 200
        }else if sliderTargeDifference == 1{
            bonus = 150
        }else{
            bonus = maxiumumScore - sliderTargeDifference
        }
        return bonus
        }



        func scoringMessage() -> String{
        return "The slider's value is \(self.sliderValueRounded).\nThe target value is \(self.target).\nYou scored \(self.pointsForCurrentRounded()) points this round"
        }

        func alertTitle() -> String {
        let title: String
        if sliderTargeDifference == 0 {
            title = "Perfect"
        }else if sliderTargeDifference < 5 {
            title = "You almost had it"
        }else if sliderTargeDifference <= 10 {
            title = "Not bad!"
        }else{
            title = "Are you even trying?"
        }

        return title

        }

        func startNewGame(){
        score = 0
        round = 1
        resetSliderAndTarget()
        }

        func startNewRound(){
        self.score = self.score + self.pointsForCurrentRounded()
        self.round = self.round + 1
        resetSliderAndTarget()
        }

        func resetSliderAndTarget(){
        sliderValue = Double.random(in: 1...100)
        target = Int.random(in: 1...100)
        }

        }

        struct LabelStyle: ViewModifier{
        func body(content: Content) -> some View {
        content
            .font(.custom("Arial Rounded MT Bold", size: 18))
            .foregroundColor(.white)
            .modifier(Shadow())
        }
        }

        struct ValueStyle: ViewModifier{
        func body(content: Content) -> some View {
        content.font(.custom("Arial Rounded MT Bold", size: 24))
            .foregroundColor(.yellow)
            .modifier(Shadow())
        }
        }
        struct Shadow: ViewModifier{
        func body(content: Content) -> some View {
        content.shadow(color: .black, radius: 5, x: 2, y: 2)
        }
        }

        struct ButtonLargeTextStyle: ViewModifier{
        func body(content: Content) -> some View {
        content.font(.custom("Arial Rounded MT Bold", size: 18))
            .foregroundColor(.black)
        }
        }

        struct ButtonSmallTextStyle: ViewModifier{
        func body(content: Content) -> some View {
        content
            .font(.custom("Arial Rounded MT Bold", size: 12))
            .foregroundColor(.black)
        }
        }



        #Preview {
        ContentView()
        }


//
//  ContentView.swift
//  YouShouldWin
//
//  Created by Antarcticaman on 21/6/2564 BE.
//

import SwiftUI


struct ContentView: View {
    
    var allMoves = ["👊", "✋", "✌️"]
    @State private var selectedMove = ""
    
    @State private var appMove = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var totalScore = 0
    @State private var questionNumber = 1
    @State private var scoreTitle = "Correct!"
    @State private var showingScore = false
    @State private var showResult = false
    @State private var appColor = [Color.white, Color.gray]
  
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: appColor), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 60) {
                Text("Qestion #\(questionNumber)")
                ZStack {
                    Color(hue: 0, saturation: 0, brightness: 0.1, opacity: 0.4)
                        .frame(width: 300, height: 100)
                        .cornerRadius(20)
                    VStack {
                        Text(showResult ? scoreTitle : (shouldWin ? "You should...WIN" : "You should...LOSE"))
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
                
                
                VStack(spacing: 20) {
                    Text("Your opponent move:")
                        Text("\(allMoves[appMove])")
                            .font(Font.system(size: 60))
                            .shadow(radius: 4)
                }
            
                VStack(alignment: .center, spacing: 20) {
                    Text("Your move:")
                    ZStack {
                        Color(hue: 0, saturation: 0, brightness: 1, opacity: 0.4)
                            .frame(width: 300, height: 100)
                            .cornerRadius(20)
                        HStack(spacing: 40) {
                            ForEach(0..<allMoves.count) { playerMoveNumber in
                                Button(action: {
                                    self.buttonTapped(playerMoveNumber)
                                }) {
                                    Text("\(allMoves[playerMoveNumber])")
                                        .font(Font.system(size: 60))
                                }.shadow(radius: 4)
                            }
                        }
                    }
                    
                    Text("Total Scores: \(totalScore)")
                }
                
                Button(action: {
                    askQuestion()
                }) {
                    Text("Continue")
                        .frame(width: 300, height: 50)
                        .foregroundColor(buttonTextColor)
                        .background(buttonColor)
                        .cornerRadius(10)
                }.disabled(!showResult)
                
            }
            .alert(isPresented: $showingScore) {
                Alert(title:Text("Your total scores is \(totalScore)/10"), dismissButton: .default(Text("Play Again")){
                    self.askQuestion()
                })
            }
            
        }
        
    }
    
    var buttonColor: Color {
        return showResult ? Color.blue : Color.gray
    }
    
    var buttonTextColor: Color {
        return showResult ? Color.white : Color(hue: 0, saturation: 0, brightness: 0.75)
    }
    
    func askQuestion() {
        if questionNumber == 10 {
            totalScore = 0
            questionNumber = 0
            showingScore = false
        }
        questionNumber += 1
        appMove = Int.random(in: 0...2)
        shouldWin = Bool.random()
        showResult = false
        appColor = [Color.white, Color.gray]
        
    }
    
    func buttonTapped(_ number: Int) {
        let appMoveSign = allMoves[appMove] //i.e. "✌️"
        let playerMoveSign = allMoves[number] // i.e. "👊"
        
        switch shouldWin {
        
        case true: //If You should WIN...
            switch appMoveSign {
            case "👊":
                scoreTitle = playerMoveSign == "✋" ? "Correct!" : "Wrong!"
            case "✌️":
                scoreTitle = playerMoveSign == "👊" ? "Correct!" : "Wrong!"
            case "✋":
                scoreTitle = playerMoveSign == "✌️" ? "Correct!" : "Wrong!"
            default: return
            }
            
        case false: //If You should LOSE...
            switch appMoveSign {
            case "👊":
                scoreTitle = playerMoveSign == "✌️" ? "Correct!" : "Wrong!"
            case "✌️":
                scoreTitle = playerMoveSign == "✋" ? "Correct!" : "Wrong!"
            case "✋":
                scoreTitle = playerMoveSign == "👊" ? "Correct!" : "Wrong!"
            default: return
            }
        }
        
        if scoreTitle == "Correct!" {
            totalScore += 1
            appColor = [Color.green, Color.white]
        } else {
            if totalScore > 0 {
                totalScore -= 1
            }
            appColor = [Color.red, Color.white]
        }
        showResult = true
        
        showingScore = questionNumber == 10 ? true : false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

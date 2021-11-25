//
//  HomeView.swift
//  Habitator
//
//  Created by Nyein Nyein on 15/11/21.
//

import SwiftUI

var motivation = [
    "Come on, just a bit more, you're almost there!",
    "You can do it!",
    "Keep going",
    "The sky is the limit!",
    "Success is not final",
    "Failure is not fatal",
    "It is the courage to continue that counts",
    "Good things take time",
    "Work hard in silence,let your success be your noise",
    "It's going to be hard but hard does not mean impossible",
    "Tough times don't last, tough people do",
    "Be yourself but always your better self",
    "YOU'RE SO CLOSE, DON'T GIVE UP NOW",
    "You can do better than this!!!",
    "Do it as if your life depends on it(probably does)",
    "Keep it up!",
    "There may be a long way left, but you'll reach there eventually!",
    "ASCEND THE BOUNDARIES OF YOUR HUMANITY",
    "It may seem hard, but it is actually easy after a while, so don't give up!",
    "You can always take a short break from making your habits <3",
    "It's always okay to ask for help!",
    "You are almost there!!!",
    "You shouldn't rush, you should take it slowly",
    "If mew nweed swome suwppowt, mew can always ask a cwose one fuw suwppowt to hewp you <3",
    "There's always a way to overcome challenges",
    "You have to turn your frown upside down!",
    "Break your limits and conquer your challenges!",
    "If things seem hard, don't take the rope",
    "If you think this is hard, try coming up with motivational sentences(5Av3 mE)",
    "I wonder if you're here for these or the actual function of this app, please use it for the intended purpose >_>",
    "CLICK THAT BUTTON TILL YOUR FINGER BREAKS(only if you actually did the habit)",
    "Just reach 69420, there'll definitely be something for you :)",
    "You know you want to click it till 69 :)",
    "SPAM THAT BUTTON(only if you actually did the habit)",
    "Us, makes an app to help with habits: You are here to make habits right? You: :) Us: R-right?",
    "Make that heatmap go stonks",
    "Remember to pace yourself properly",
    "You can always reward yourself after completing your goals!",
    "You'll pick up the habit in no time!",
    "Habwitwatow at yow suwvice, pwease make yow habwit, don't give uwp meow!",
    "That button is asking to be clicked"]

struct HomeView: View {
    @Binding var current: Int?
    @Binding var habits: [Habit]
    @State var motivCount = Int.random(in: 0..<motivation.count)
    @State var text=""
    
    private let timer = Timer.publish(every: 300, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if (!(current==nil)){
            let habit=habits[current!]
            VStack{
                Text("Home")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .onAppear(){
                        text=habit.progressText
                    }
                Divider()
                    .padding(.bottom)
                Text(text)
                        .padding(.bottom)
                    .font(.system(size: 38, weight: .bold, design: .rounded))
                    .foregroundColor(.purple)
                    .multilineTextAlignment(.center)
                Button (action:{
                    text=habit.progressText
                    habits[current!]
                        .records+=[ProgressRecord()]
                }) {
                    ZStack {
                        Text("Add Progress")
                            .font(.system(size: 23, weight: .bold, design: .rounded))
                        RoundedRectangle(cornerRadius: 17)
                            .frame(width: 250, height: 95)
                            .foregroundColor(.purple)
                            .opacity(0.2)
                    }
                } //need to make it FAT
                    .foregroundColor(.purple)
                    .font(.largeTitle)
                Spacer()
                Text("\(motivation[motivCount])")
                    .onReceive(timer) { _ in
                        motivCount = Int.random(in: 0..<motivation.count)
                    }
                    .padding().multilineTextAlignment(.center)
            }
        }else{
            Text("Please select a habit in the habits screen by clicking on it!")
                    .bold()
                .padding()
        }
    }
}

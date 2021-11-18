//
//  HomeView.swift
//  Habitator
//
//  Created by Nyein Nyein on 15/11/21.
//

import SwiftUI

struct HomeView: View {
    @Binding var currentHabit: Habit?
    @Binding var habits: [Habit]
    var motivation = ["Come on, just a bit more, you're almost there!",
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
                      "If mew nweed swome suwppowt, mew can always ask a clwose one fuw suwppowt to hewp you <3",
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
                      "Us, makes an app to help with habits: You are here to make habits right? You: 🙂 Us: R-right?",
                      "Make that heatmap go stonks",
                      "Remember to pace yourself properly",
                      "You can always reward yourself after completing your goals!",
                      "You'll pick up the habit in no time!",
                      "Habwitwatow at yow suwvice, pwease make yow habwit, don't give uwp meow!",
                      "That button is asking to be clicked"]
    
    var body: some View {
        if (!(currentHabit==nil)){
            VStack{
                Text("Home")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                Divider()
                    .padding(.bottom)
                Text("\(currentHabit!.records.count) \(currentHabit!.object.plural) \(currentHabit!.action.past)")
                        .padding(.bottom)
                    .font(.system(size: 38, weight: .bold, design: .rounded))
                    .foregroundColor(.purple)
                Button (action:{
                    currentHabit?.records+=[ProgressRecord()]
                }) {
                    ZStack {
                        Text("Add Progress")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 250, height: 100)
                            .foregroundColor(.purple)
                            .opacity(0.2)
                    }
                } //need to make it FAT
                    .foregroundColor(.purple)
                    .font(.largeTitle)
                Spacer()
                Text("Motivation stuff here!!!")
                    .padding()
            }
        }else{
            Text("Please select a habit in the habits screen by clicking on it!")
                    .bold()
                .padding()
        }
    }
}

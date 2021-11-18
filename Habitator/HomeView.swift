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
            Text("Please select a habits in the habits screen by clicking on it!")
                    .bold()
                .padding()
        }
    }
}

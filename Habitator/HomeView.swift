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
    @State var counter = 0
    
    var body: some View {
        VStack{
            Text("Home")
                .font(.system(size: 30, weight: .bold, design: .rounded))
            Divider()
            Text("Number of habit done goes here")
                .padding()
                Text("\(counter)")
                .padding()
            Button (action:{
                counter = counter + 1
            }) {
                ZStack {
                    Text("Add Progress")
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 250, height: 100)
                        .foregroundColor(.purple)
                        .opacity(0.3)
                }
            } //need to make it FAT
                .foregroundColor(.purple)
                .frame(width: 300, height: 200)
                .font(.largeTitle)
                .padding()
            Spacer()
            Text("Motivation stuff here!!!")
                .padding()
        }
    }
}

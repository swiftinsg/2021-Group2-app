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
            Text("Number of habit dones goes here")
                .padding()
                Text("\(counter)")
                .padding()
                Button ("Add Progress") {
                counter = counter + 1
                }
                .background(Color.purple)
                .foregroundColor(.white)
                .padding()
            Spacer()
    }
}


}

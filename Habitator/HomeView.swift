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
        VStack{
            HStack(alignment: . bottom, spacing: -10) {
                Rectangle()
                    .foregroundColor(.black)
                    .frame(width: 15)
                Text("klik")
                    .font(.system(size:100))
                    .offset(x: 0, y: 10)
            }
            
            Button("Raise Flag") {
            
            }
            .padding()
            
           
        }
    }
}



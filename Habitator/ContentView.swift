//
//  ContentView.swift
//  Habitator
//
//  Created by Francis Ang on 12/11/21.
//

import SwiftUI

struct ActionWord{
    var singular: String
    var Plural: String
}

struct Habit{
    var verb: String
    var action: ActionWord
}

struct ContentView: View {
    var selectedHabit: Habit?
    var appPurple=UIColor(rgb: 0x766CD1)
    var body: some View {
        TabView() {
            Text("[INSERT HOME VIEW]")
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
         
            Text("[INSERT HABITS VIEW]")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Habits")
                }
                .tag(1)
         
            Text("[INSERT PROGRESS VIEW]")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Progress")
                }
                .tag(2)
         
            Text("[INSERT GOALS VIEW]")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "target")
                    Text("Goals")
                }
                .tag(3)
        }
        .accentColor(Color(appPurple))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

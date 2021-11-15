//
//  ContentView.swift
//  Habitator
//
//  Created by Francis Ang on 12/11/21.
//

import SwiftUI

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

struct ObjectWord{
    var singular: String
    var plural: String
}

struct Habit{
    var object: ObjectWord
    var action: String
    var name: String
}

struct ContentView:View{
    @State private var selectedHabit: Habit?=testHabits[0]
    @State private var tabSelection: Int=1
    var appPurple=UIColor(rgb: 0x766CD1)
    var body: some View {
        TabView(selection: $tabSelection) {
            Text("[INSERT HOME VIEW]")
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
         
            HabitsView(currentHabit: $selectedHabit)
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

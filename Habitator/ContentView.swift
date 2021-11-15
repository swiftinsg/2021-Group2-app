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

struct Goal{
    var name: String
    func isAcheived(habit: Habit)->Bool{
        //do checks when its done
        return true
    }
}

struct Habit:Identifiable{
    var id=UUID()
    var object: ObjectWord
    var action: String
    var name: String
    var goals: [Goal]
}

let testHabits=[
    Habit(
        object: ObjectWord(singular: "apple",plural:"apples"),
        action: "eat",
        name: "Eat apples",
        goals: [Goal(name: "lmao"),Goal(name: "e")]
    ),
    Habit(
        object: ObjectWord(singular: "chinese propaganda",plural:"chinese propaganda"),
        action: "spread",
        name: "Read more chinese propaganda",
        goals: [Goal(name: "lmao"),Goal(name: "e"),Goal(name: "a")]
    ),
    Habit(
        object: ObjectWord(singular: "one-hand salute",plural:"one-hand salutes"),
        action: "do",
        name: "Do more one-hand salutes",
        goals: [Goal(name: "lmao"),Goal(name: "e"),Goal(name: "GAMES")]
    )
]

struct ContentView:View{
    @State private var selectedHabit: Habit?=nil
    @State private var tabSelection: Int=1
    @State var habits: [Habit]
    var appPurple=UIColor(rgb: 0x766CD1)
    var lightAppPurple=UIColor(rgb: 0x9498FF)
    var body: some View {
        TabView(selection: $tabSelection) {
            HomeView(currentHabit: $selectedHabit,habits: $habits)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
         
            HabitsView(currentHabit: $selectedHabit,habits: $habits)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Habits")
                }
                .tag(1)
         
            ProgressView()
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
    @State var tabSelection: Int=1
    static var previews: some View {
        Group {
            ContentView(habits:testHabits)
        }
    }
}

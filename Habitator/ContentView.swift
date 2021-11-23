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

struct ProgressRecord:Codable{
    var time=Date()
}

struct ObjectWord:Codable{
    var singular: String
    var plural: String
}

struct ActionWord:Codable{
    var past: String
    var present: String
}

struct Goal:Codable{
    var name: String
    func isAcheived(habit: Habit)->Bool{
        //do checks when its done
        return true
    }
}

struct Habit:Identifiable,Codable{
    var id=UUID()
    var object: ObjectWord
    var action: ActionWord
    var name: String
    var goals: [Goal]
    var records: [ProgressRecord]
}

class HabitsData: ObservableObject {
    @Published var habits:[Habit]=[]

    let sampleHabits=[
        Habit(
            object: ObjectWord(singular: "apple",plural:"apples"),
            action: ActionWord(past:"eaten",present:"eat"),
            name: "Eat apples",
            goals: [Goal(name: "lmao"),Goal(name: "e")],
            records:[]
        ),
        Habit(
            object: ObjectWord(singular: "chinese propaganda",plural:"chinese propaganda"),
            action: ActionWord(past: "spreaded",present:"spread"),
            name: "Read more chinese propaganda",
            goals: [Goal(name: "lmao"),Goal(name: "e"),Goal(name: "a")],
            records:[]
        ),
        Habit(
            object: ObjectWord(singular: "one-hand salute",plural:"one-hand salutes"),
            action: ActionWord(past:"done",present:"do"),
            name: "Do more one-hand salutes",
            goals: [Goal(name: "lmao"),Goal(name: "ehgdf"),Goal(name: "GAMES")],
            records:[]
        )
    ]
    func getArchiveURL() -> URL {
        let plistName = "habits.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(plistName)
    }
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedHabits = try? propertyListEncoder.encode(habits)
        try? encodedHabits?.write(to: archiveURL, options: .noFileProtection)
    }
    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()

        var finalHabits: [Habit]!

        if let retrievedHabitsData = try? Data(contentsOf: archiveURL),
            let decodedHabits = try? propertyListDecoder.decode(Array<Habit>.self, from: retrievedHabitsData) {
            finalHabits = decodedHabits
        }else {
            finalHabits = sampleHabits
        }
        habits=finalHabits
    }
}

struct ContentView:View{
//    @State var todos = [Todo(title: "Feed the cat", isCompleted: true),
//                            Todo(title: "Play with cat"),
//                            Todo(title: "Get allergies"),
//                            Todo(title: "Run away from cat"),
//                            Todo(title: "Get a new cat")]
//    @State var isSheetPresented = false
    @State private var selectedHabit: Int?=nil
    @State private var tabSelection: Int=0
    @Binding var habits: [Habit]
        var appPurple=UIColor(rgb: 0x766CD1)
    var lightAppPurple=UIColor(rgb: 0x9498FF)
    var body: some View {
        TabView(selection: $tabSelection) {
            HabitsView(habits: $habits, currentHabit: $selectedHabit)
                .tabItem {
                    Image(systemName: "target")
                    Text("Habits")
                }
                .tag(0)
            
            HomeView(current: $selectedHabit,habits: $habits)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(1)


            HeatmapView(current: $selectedHabit,habits: $habits)
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Progress")
                }
                .tag(2)
        }
    }
}

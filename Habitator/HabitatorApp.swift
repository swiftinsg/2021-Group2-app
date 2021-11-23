//
//  HabitatorApp.swift
//  Habitator
//
//  Created by Francis Ang on 12/11/21.
//

import SwiftUI

@main
struct HabitatorApp: App {
    @ObservedObject var habitsData = HabitsData()
    @Environment(\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
            ContentView(habits:$habitsData.habits)
                .onAppear {
                     habitsData.load()
                 }
                .onChange(of: scenePhase) { phase in
                    if phase == .inactive {
                        habitsData.save()
                    }
                }
        }
    }
}

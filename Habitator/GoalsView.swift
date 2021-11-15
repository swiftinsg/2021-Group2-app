//
//  GoalsView.swift
//  Habitator
//
//  Created by Nyein Nyein on 15/11/21.
//

import SwiftUI

struct GoalView: View{
    @State var goal: Goal
    @Binding var habit: Habit
    var body: some View{
        HStack{
            Text(goal.name)
            if (goal.isAcheived(habit: habit)){
                Image(uiImage: UIImage(systemName:"checkmark")!)
            }
        }
    }
}

struct GoalsView: View {
    @Binding var currentHabit: Habit?
    @Binding var habits: [Habit]
    var body: some View {
        if ((currentHabit) != nil){
            List{
                ForEach(currentHabit!.goals,id: \.name){ goal in
                    //goal is in goal
                }
            }
        }
    }
}

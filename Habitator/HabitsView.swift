//
//  HabitsView.swift
//  Habitator
//
//  Created by Nyein Nyein on 15/11/21.
//

import SwiftUI

struct HabitListItemView: View{
    @State var habit: Habit
    @Binding var selected: Habit?
    var body: some View {
        HStack(){
            Text(habit.name)
            if ((selected != nil) && selected!.name==habit.name){
                Spacer()
                Image(uiImage: UIImage(systemName:"checkmark")!)
            }
        }
    }
}

struct HabitsView: View {
    @Binding var currentHabit: Habit?
    @Binding var habits: [Habit]
    var body: some View {
        List{
            HabitListItemView(
                habit: testHabits[0],
                selected: $currentHabit
            )
        }
    }
}

//struct HabitsView_Previews: PreviewProvider {
//    static var previews: some View {
//        HabitsView()
//    }
//}

//
//  GoalsView.swift
//  Habitator
//
//  Created by Nyein Nyein on 15/11/21.
//

import SwiftUI

struct GoalsListItemView: View{
    @State var habit: Habit
    @Binding var selected: Habit?
    @Binding var habits: [Habit]
    var body: some View {
        Button(action: {selected=habit}){
            HStack(){
                Text(habit.name)
                if ((selected != nil) && selected!.name==habit.name){
                    Spacer()
                    Image(uiImage: UIImage(systemName:"checkmark")!)
                }
            }
        }
    }
}

struct PlaceholderGoalsView: View{
    @Binding var habits:[Habit]
    @Binding var text: String
    var body: some View {
        TextField(
            "Type To Enter",
            text: $text
        ).opacity(0.5)
    }
}

struct GoalsView: View {
    @Binding var currentHabit: Habit?
    @Binding var habits: [Habit]
    @State var placeholderText=""
    @State var editing=false
    var body: some View {
        VStack{
            ZStack{
                Text("Habits")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                HStack{
                    Button("Edit"){
                        editing = !editing
                    }.padding(.leading)
                    Spacer()
                }
            }
            Divider()
            List{
                ForEach(habits,id: \.name){ habit in
                    HabitListItemView(
                        habit: habit,
                        selected: $currentHabit,
                        habits: $habits
                    )
                }
                Button(action: {
                    if (!(placeholderText=="")){
                        habits+=[Habit(
                            object: ObjectWord(
                                singular: "undefined",
                                plural: "undefined"
                            ),
                            action: "undefined",
                            name: placeholderText, goals: []
                        )]
                        placeholderText=""
                    }
                }){
                    PlaceholderHabitView(
                        habits: $habits,
                        text: $placeholderText
                    )
                }
            }
        }
    }
}


//struct HabitsView_Previews: PreviewProvider {
//    static var previews: some View {
//        HabitsView()
//    }
//}

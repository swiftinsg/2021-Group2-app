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

struct PlaceholderHabitView: View{
    @Binding var habits:[Habit]
    @Binding var text: String
    var body: some View {
        TextField(
            "Type To Enter",
            text: $text
        ).opacity(0.5)
    }
}

struct HabitsView: View {
    @Binding var currentHabit: Habit?
    @Binding var habits: [Habit]
    @State var placeholderText=""
    var body: some View {
        VStack{
            Text("Habits")
                .font(.system(size: 30, weight: .bold, design: .rounded))
            Divider()
            List{
                ForEach(habits,id: \.name){ habit in
                    HabitListItemView(
                        habit: habit,
                        selected: $currentHabit
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
                            name: placeholderText
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

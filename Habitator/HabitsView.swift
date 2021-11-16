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
    @Binding var habits: [Habit]
    @Binding var editing: Bool
    var body: some View {
        Button(action: {
            if (!editing){
                selected=habit
            }
        }){
            HStack(){
                if (!editing){
                    Text(habit.name)
                }else{
                    TextField(habit.name, text: $habit.name)
                        .opacity(0.7)
                }
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
    @State var text=""
    var body: some View {
        Button(action: {
            if (!(text=="")){
                habits+=[Habit(
                    object: ObjectWord(
                        singular: "undefined",
                        plural: "undefined"
                    ),
                    action: "undefined",
                    name: text, goals: []
                )]
                text=""
            }
        }){
            TextField(
                "Type To Enter",
                text: $text
            ).opacity(0.5)
        }
    }
}

struct HabitsView: View {
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
                        currentHabit=nil
                    }.padding(.leading)
                    Spacer()
                }
            }
            Divider()
            List{
                ForEach($habits,id: \.name){ $habit in
                    HabitListItemView(
                        habit: habit,
                        selected: $currentHabit,
                        habits: $habits,
                        editing: $editing
                    )
                }
                if (editing){
                    PlaceholderHabitView(
                        habits: $habits
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

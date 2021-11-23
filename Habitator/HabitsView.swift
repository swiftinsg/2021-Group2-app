//
//  HabitsView.swift
//  Habitator
//
//  Created by Nyein Nyein on 15/11/21.
//

import SwiftUI

import Foundation

struct Todo: Identifiable, Equatable {
    var id = UUID()
    
    var title: String
    var isCompleted = false
}


struct HabitListItemView: View{
    @Binding var habits: [Habit]
    @State var habit: Int
    @Binding var selected: Int?
    @Binding var editing: Bool
    var body: some View {
        Button(action: {
            if (!editing){
                selected=habit
            }
        }){
            HStack(){
                if (!editing && habits.count>habit){
                    Text(habits[habit].name)
                }else{
                    Button(action:{
                        habits.remove(at:habit)
                    }){
                        Image(uiImage: UIImage(systemName:"trash")!)
                            .padding(.trailing)
                    }
                    if (habits.count>habit){
                        TextField(habits[habit].name, text: $habits[habit].name)
                            .opacity(0.7)
                    }
                }
                if ((selected != nil) && selected!==habit){
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
                        singular: "singular",
                        plural: "plural"
                    ),
                    action: ActionWord(past:"Past tense",present:"Present tense"),
                    name: text, goals: [],
                    records:[]
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
    @Binding var habits: [Habit] 
    @Binding var currentHabit: Int?
    @State var placeholderText=""
    @State var editing=false
    var body: some View {
        VStack{
            ZStack{
                Text("Habits")
                    .font(.system(size: 30, weight: .bold))
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
                ForEach(habits.indices,id: \.self){ habit in
                    HabitListItemView(
                        habits: $habits, habit: habit,
                        selected: $currentHabit,
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

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
    @State var sampleText=""
    @State private var invalidInput=false
    var body: some View {
        Button(action: {
            do{
                if (!(sampleText=="" || text=="")){
                    habits+=[try Habit(
                        name: text,
                        sampleSentence: sampleText
                    )]
                    text=""
                    sampleText=""
                }
            }catch{
                invalidInput=true
            }
        }){
            VStack{
                TextField(
                    "Type To Enter",
                    text: $text
                ).opacity(0.5)
                TextField(
                    "Sample text",
                    text: $sampleText
                ).opacity(0.5)
            }
        }.alert(isPresented: $invalidInput) {
            return Alert(
                title: Text("Habit format invalid!"),
                message: Text("Habits should follow the format of [action word] [amount] [object] {before/after} [time].\neg. Eat 6942 apples before 3pm\n\nSample sentences follow the format of I have [action word] {1, if your habit aims to do something more than once, or any other number} [object]\neg. I have eaten 1 apple"),
                dismissButton: .default(Text("Got it!"))
            )
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
            if (habits.count>0){
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
            }else{
                Text("Add a habit!").bold()
            }
        }
    }
}


//struct HabitsView_Previews: PreviewProvider {
//    static var previews: some View {
//        HabitsView()
//    }
//}

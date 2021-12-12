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
                    "Habit name",
                    text: $text
                ).opacity(0.5)
                TextField(
                    "Action text",
                    text: $sampleText
                ).opacity(0.5)
            }
        }.alert(isPresented: $invalidInput) {
            return Alert(
                title: Text("Habit format invalid!"),
                message: Text("Habit names should follow the format of '[action word] [amount] [object] {before/after} [time]'.\neg. Eat 6942 apples before 3pm\n\nAction sentences follow the format of 'I have [action word] {1, if your habit aims to do something more than once, or any other number} [object]'\neg. I have eaten 1 apple"),
                dismissButton: .default(Text("Got it!"))
            )
        }
    }
}

struct SampleHabitView: View{
    @State var name:String
    @State var sample:String
    var body: some View{
        VStack{
            Text("Name: \(name)")
            Text("Action sentence: \(sample)")
        }
    }
}

struct HabitsView: View {
    @Binding var habits: [Habit] 
    @Binding var currentHabit: Int?
    @State var placeholderText=""
    @State var editing=false
    @State private var showingSamples=false
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
            if (!editing && habits.count==0){
                Text("Add a habit by typing in the placeholder in the edit screen!")
                    .bold()
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
            }
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
            
            if editing{
                Button("Confused? See samples"){
                    showingSamples.toggle()
                }.sheet(isPresented: $showingSamples) {
                    VStack{
                        HStack{
                            Button("Dismiss"){
                                showingSamples.toggle()
                            }.padding()
                            Spacer()
                        }
                        Divider()
                        List{
                            SampleHabitView(name: "Eat 25 muffins by 2pm",sample: "I ate 1 muffin")
                            SampleHabitView(name: "Run 2km by 2am",sample: "I ran 1km")
                            SampleHabitView(name: "Push-up 100 times after 2pm",sample: "I pushed 1 time")
                        }
                        Spacer()
                    }
                }.padding(.bottom)
            }
        }
    }
}


//struct HabitsView_Previews: PreviewProvider {
//    static var previews: some View {
//        HabitsView()
//    }
//}

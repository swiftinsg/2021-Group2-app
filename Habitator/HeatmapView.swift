//
//  HeatmapView.swift
//  Habitator
//
//  Created by Nyein Nyein on 19/11/21.
//

import SwiftUI

let gradient=[
    UIColor(red:61 ,green:212,blue:222),
    UIColor(red:66 ,green:208,blue:224),
    UIColor(red:72 ,green:204,blue:226),
    UIColor(red:77 ,green:201,blue:228),
    UIColor(red:83 ,green:197,blue:230),
    UIColor(red:88 ,green:193,blue:232),
    UIColor(red:94 ,green:190,blue:234),
    UIColor(red:99 ,green:186,blue:236),
    UIColor(red:104,green:182,blue:238),
    UIColor(red:110,green:178,blue:241),
    UIColor(red:115,green:174,blue:243),
    UIColor(red:121,green:171,blue:245),
    UIColor(red:126,green:167,blue:247),
    UIColor(red:132,green:163,blue:249),
    UIColor(red:137,green:160,blue:251),
    UIColor(red:143,green:156,blue:253),
    UIColor(red:148,green:152,blue:255)
]

func getGoalProgress(habit: Habit)->String{
    return "lmao"
}

struct HeatmapRectangle: View{
    @Binding var habit: Habit
    @State var day: Int
    var body: some View {
        if (habit.days.count>day){
            Rectangle()
                .frame(width: 30, height: 30, alignment: .center)
                .foregroundColor(Color(gradient[
                    habit.max==0 ? 0 :
                    Int((gradient.count-1)*(habit.days[day].count/habit.max!))
                ]))
        }else{
            Rectangle()
                .frame(width: 30, height: 30, alignment: .center)
                .foregroundColor(Color(UIColor(red:0xdd,green:0xdd,blue:0xdd)))
        }
    }
}

struct HeatmapHeatmapRowView: View{
    @State var week: Int
    @Binding var habit: Habit
    var body: some View{
        HStack{
            ForEach(week*7...(week+1)*7,id:\.self){ day in
                HeatmapRectangle(habit: $habit,day: day)
            }
        }
    }
}

// stride(from: (week+1)*7,through: week*7,by:-1)
struct HeatmapHeatmapView: View{
    @Binding var habit: Habit
    var body: some View{
        ForEach(0..<habit.days.count/7+(!(habit.days.count%7==0) ? 1 : 0),id: \.self){ week in
            HStack{
                Text("day \(week*7)-\((week+1)*7)")
                HeatmapHeatmapRowView(week: week,habit: $habit)
            }
        }
    }
}

struct HeatmapView: View {
    @Binding var current: Int?
    @Binding var habits: [Habit]
    var body: some View {
        if !(current==nil){
            let habit=habits[current!]
            VStack {
                Text("Heatmap")
                    .font(.system(size: 30, weight: .bold))
                Divider()
                if (habit.days.count==0){
                    Text("Progress that you enter will be shown here!").bold().padding(.leading,.trailing)
                }else{
                    HeatmapHeatmapView(habit:$habits[current!])
                    Text(habit.goalText).bold().padding(.leading,.trailing)
                }
                Spacer()
            }
        }else{
            Text("Please select a habit in the habits screen by clicking on it!")
                .bold()
                .padding()
        }
    }
}



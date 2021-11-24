//
//  HeatmapView.swift
//  Habitator
//
//  Created by Nyein Nyein on 19/11/21.
//

import SwiftUI

extension Date {
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    init(_ dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:date)
    }
}

struct Progress{
    var progress:[ProgressRecord]
    var earliest: ProgressRecord?=nil
    var average: Int?=nil
    var max: Int?=nil
    var days:[[ProgressRecord]]=[]
    var goalDone:Int?=nil
    init(progress:[ProgressRecord],created: Date,habit: Habit){
        self.progress=progress
        if progress.count==0{
            return
        }
        for progress in self.progress{
            if (earliest==nil || progress.time<self.earliest!.time){
                self.earliest=progress
            }
        }
        var proccesing=Date(
            "\(created.get(.year))-\(created.get(.month))-\(created.get(.day))"
        )
        while (proccesing<Date()){
            self.days+=[between(from:proccesing,to:Date(timeInterval: 60*60*24, since: proccesing))]
            proccesing=Date(timeInterval: 60*60*24, since: proccesing)
        }
        self.average=days.count>0 ? self.progress.count/days.count : nil
        for day in self.days{
            if max==nil || day.count>max!{
                max=day.count
            }
        }
        
        let todaystart=Date(timeInterval: -(60*60*24), since: proccesing)
        let todayend=proccesing
        
        let goalTime=Date(timeInterval: TimeInterval(habit.time),since: todaystart)
        var goalTimes:[ProgressRecord]=[]
        if habit.timeMode=="before"{
            goalTimes=between(from:todaystart,to:goalTime)
        }else{
            goalTimes=between(from:goalTime,to:todayend)
        }
        
        goalDone=goalTimes.count-habit.amount
    }
    init(){
        progress=[]
    }
    func between(from:Date,to:Date)->[ProgressRecord]{
        var result:[ProgressRecord]=[]
        for entry in progress{
            if (entry.time>from && entry.time<to){
                result+=[entry]
            }
        }
        return result
    }
}

let gradient=[
    UIColor(red:148,green:152,blue:255),
    UIColor(red:143,green:156,blue:253),
    UIColor(red:137,green:160,blue:251),
    UIColor(red:132,green:163,blue:249),
    UIColor(red:126,green:167,blue:247),
    UIColor(red:121,green:171,blue:245),
    UIColor(red:115,green:174,blue:243),
    UIColor(red:110,green:178,blue:241),
    UIColor(red:104,green:182,blue:238),
    UIColor(red:99 ,green:186,blue:236),
    UIColor(red:94 ,green:190,blue:234),
    UIColor(red:88 ,green:193,blue:232),
    UIColor(red:83 ,green:197,blue:230),
    UIColor(red:77 ,green:201,blue:228),
    UIColor(red:72 ,green:204,blue:226),
    UIColor(red:66 ,green:208,blue:224),
    UIColor(red:61 ,green:212,blue:222)
]

struct HeatmapRectangle: View{
    @Binding var progress: Progress
    @State var day: Int
    var body: some View {
        if (progress.days.count>day){
            Rectangle()
                .frame(width: 30, height: 30, alignment: .center)
                .foregroundColor(Color(gradient[
                    Int((gradient.count-1)*(progress.days[day].count/progress.max!))
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
    @Binding var progress: Progress
    var body: some View{
        HStack{
            ForEach(week*7...(week+1)*7,id:\.self){ day in
                HeatmapRectangle(progress: $progress,day: day)
            }
        }
    }
}

// stride(from: (week+1)*7,through: week*7,by:-1)
struct HeatmapHeatmapView: View{
    @Binding var progress: Progress
    var body: some View{
        ForEach(0..<progress.days.count/7+(!(progress.days.count%7==0) ? 1 : 0),id: \.self){ week in
            HStack{
                Text("day \(week*7)-\((week+1)*7)")
                HeatmapHeatmapRowView(week: week,progress: $progress)
            }
        }
    }
}

struct HeatmapView: View {
    @Binding var current: Int?
    @Binding var habits: [Habit]
    @State var progress: Progress=Progress()
    var body: some View {        if !(current==nil){
            VStack {
                Text("Heatmap")
                    .font(.system(size: 30, weight: .bold))
                    .onAppear(){
                        if !(current==nil){
                            progress=Progress(progress: habits[current!].records,created:habits[current!].created, habit: habits[current!])
                        }
                    }
                Divider()
                if (progress.days.count==0){
                    Text("Progress that you enter will be shown here!").bold()
                }else{
                    HeatmapHeatmapView(progress: $progress)
                    if progress.goalDone! >= 0 {
                        Text("You accomplished your goal today! GOOD JOB!").bold()
                    }else{
                        Text("You are \(-progress.goalDone!) \(habits[current!].object.plural) away from completing your goal!").bold()
                    }
                }
                Spacer()
            }
        }else{
            Text("Please select a habit in the habits screen by clicking on it!")
                .bold()
                .padding()
                .onAppear(){
                    if !(current==nil){
                        progress=Progress(progress: habits[current!].records,created:habits[current!].created, habit: habits[current!])
                    }
                }
        }
    }
}



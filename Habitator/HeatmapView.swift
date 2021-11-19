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
    var days:[[ProgressRecord]]=[]
    init(progress:[ProgressRecord]){
        self.progress=progress
        for progress in self.progress{
            if (earliest==nil || progress.time<self.earliest!.time){
                self.earliest=progress
            }
        }
        var proccesing=Date(
            "\(self.earliest!.time.get(.year))-\(self.earliest!.time.get(.month))-\(self.earliest!.time.get(.day))"
        )
        while (proccesing<Date()){
            self.days+=[between(from:proccesing,to:Date(timeInterval: 60*60*24, since: proccesing))]
            proccesing=Date(timeInterval: 60*60*24, since: proccesing)
        }
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
    var section: Int
    var body: some View {
        Text("E")
    }
}

struct HeatmapView: View {
    @Binding var current: Int?
    @Binding var habits: [Habit]
    var body: some View {
        ScrollView{
            VStack {
                Text("Heatmap")
                    .font(.system(size: 30, weight: .bold))
                Divider()
                ForEach(1...2,id:\.self){item in
                    Text("a")
                }
            }
        }
    }
}



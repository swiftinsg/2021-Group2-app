//
//  Temp.swift
//  Habitator
//
//  Created by Nyein Nyein on 25/11/21.
//

import Foundation

extension Habit{ //progress extensions
    var earliest: ProgressRecord?{
        var earliest:ProgressRecord?
        for progress in self.records{
            if (earliest==nil || progress.time<self.earliest!.time){
                earliest=progress
            }
        }
        return earliest
    }
    var firstDay: Date?{
        return Date(
            "\(self.created.get(.year))-\(created.get(.month))-\(created.get(.day))"
        )
    }
    var days:[[ProgressRecord]]{
        var result:[[ProgressRecord]]=[]
        let proccesing=firstDay
        if var proccesing=proccesing{
            while (proccesing<Date()){
                result+=[between(from:proccesing,to:Date(timeInterval: 60*60*24, since: proccesing))]
                proccesing=Date(timeInterval: 60*60*24, since: proccesing)
            }
            return result
        }else{
            return []
        }
    }
    var max: Int?{
        var max:Int?=nil
        let days=self.days
        for day in days{
            if max==nil || day.count>max!{
                max=day.count
            }
        }
        return max
    }
    
    var todaystart: Date{
        let now=Date()
        return Date(
            "\(now.get(.year))-\(now.get(.month))-\(now.get(.day))")
    }
    var todayend: Date{
        return Date(timeInterval: 60*60*24,since: self.todaystart)
    }
    var goalTime: Date{
        return Date(timeInterval: TimeInterval(self.time),since: todaystart)
    }
    var goalTimes: [ProgressRecord]{
        var goalTimes:[ProgressRecord]=[]
        if self.timeMode=="before"{
            goalTimes=between(from:todaystart,to:goalTime)
        }else{
            goalTimes=between(from:goalTime,to:todayend)
        }
        return goalTimes
    }
    var goalDone:Int{
        return goalTimes.count-self.amount
    }
    var goalCanDone: String?{
        if goalDone>=0{
            return nil
        }else{
            if (self.timeMode=="before"){
                return "late"
            }else if (self.timeMode=="after"){
                return "early"
            }
        }
        return nil
    }
    
    func between(from:Date,to:Date)->[ProgressRecord]{
        var result:[ProgressRecord]=[]
        for entry in records{
            if (entry.time>from && entry.time<to){
                result+=[entry]
            }
        }
        return result
    }
}

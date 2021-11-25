import NaturalLanguage
import SwiftUI

struct ProgressRecord:Codable{
    var time=Date()
}

struct ObjectWord:Codable{
    var singular: String
    var plural: String
}

struct ActionWord:Codable{
    var past: String
    var present: String
}

struct Habit:Identifiable,Codable{
    var created=Date()
    var id=UUID()
    var object: ObjectWord
    var action: ActionWord
    var timeStr: String
    var name: String
    var amount: Int
    var time: Int //seconds
    var records: [ProgressRecord]=[]
    var unit: String?=nil //unit
    var timeMode: String
    func pprint(){
        print("\(name):")
        print("    Object: \(object.singular), \(object.plural)")
        print("    Action: \(action.present), \(action.past)")
        if let unit=unit{
            print("    Unit: \(unit)")
        }
        print("    Target: \(amount) \(timeMode) \(time)s")
    }
}

extension String: Error {
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
}

struct TagWordPair{
    var type:String
    var word:String
    func pprint(){
        print("\(word): \(type)")
    }
}

//              verb Number noun Preposition Determiner OtherWord
//                v    v    v      v            v          v
// hMM smth like "eat 19 apples before        every       12am"
extension Habit{
    init(name: String,sampleSentence: String) throws{
        var words:[TagWordPair]=[]
        
        var tagger = NLTagger(tagSchemes: [.lexicalClass])
        tagger.string = name
        var options: NLTagger.Options = [.omitWhitespace]

        tagger.enumerateTags(in: name.startIndex..<name.endIndex, unit: .word, scheme: .lexicalClass, options: options) { tag, tokenRange in
            if let tag = tag {
                words+=[TagWordPair(type: tag.rawValue,word: "\(name[tokenRange])")]
            }
            return true
        }
        
        var pos=0
        if words[pos].type=="Verb"{
            action=ActionWord(past: "...", present: words[pos].word.lowercased())
        }else{throw "first word not verb"}
        
        pos+=1
        if words[pos].type=="Number"{
            amount=Int(words[pos].word)!
        }else if words[pos].type=="OtherWord"{
            amount=Int(words[pos].word.digits)!
            unit=words[pos].word
                .components(separatedBy:CharacterSet.decimalDigits)
                .joined()
        }else{throw "invalid amount"}
        
        pos+=1
        if words[pos].type=="Preposition"{
            pos+=1
        }
        
        var objectName=""
        while (pos+1)<words.count && (words[pos].type=="Noun" || ((words[pos].type=="Preposition" || words[pos].type=="Adjective") && words[pos+1].type=="Noun")){
            objectName+=words[pos].word+" "
            pos+=1
        }
        
        objectName=objectName.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if !(amount==1){
            object=ObjectWord(singular: "...", plural: objectName)
        }else{
            object=ObjectWord(singular: objectName, plural: "...")
        }
        
        if words[pos].type=="Preposition"{
            if words[pos].word=="by" || words[pos].word=="before"{
                timeMode="before"
            }else if words[pos].word=="after"{
                timeMode="after"
            }else{throw "invalid preposition as time constraint"}
        }else{throw "no time constraint"}
        pos+=1
        
        if words[pos].type=="Determiner"{
            pos+=1
        }
        
        var rawTime=""
        while pos<words.count{
            rawTime+=words[pos].word
            pos+=1
        }
        
        timeStr=rawTime.digits
        let timeunit=rawTime
            .components(separatedBy:CharacterSet.decimalDigits)
            .joined()
            .components(separatedBy:":")
            .joined()
        var offset=0
        if (timeunit=="pm"){
            offset+=60*60*12
        }else if !(timeunit=="am" || timeunit==""){throw "invalid amount \(timeunit)"}
        
        if ((timeStr.count/2+(((timeStr.count%2)==0) ? 0 : 1))==1){ //0300, 1203, 301, 12, 3
            time=Int(timeStr)!%12 ///0,1,2,3,4,5,6,7,8,9,10,11 *right*
            time=time*60*60
        }else{
            let fullTimeInt=Int(timeStr)!
            let hours=fullTimeInt/100
            let mins=fullTimeInt-(hours*100)
            time=((hours*60)+mins)*60
        }
        time+=offset
        
        self.name=name
        records=[]
        
        // sampleSentence
        // i ate a apple
        // or i ate 809 apples
        // pronoun (verb|(have|had) verb) number noun
        words=[]
        
        tagger = NLTagger(tagSchemes: [.lexicalClass])
        tagger.string = sampleSentence
        options = [.omitWhitespace]

        tagger.enumerateTags(in: sampleSentence.startIndex..<sampleSentence.endIndex, unit: .word, scheme: .lexicalClass, options: options) { tag, tokenRange in
            if let tag = tag {
                words+=[TagWordPair(type: tag.rawValue,word: "\(sampleSentence[tokenRange])")]
            }
            return true
        }
        
        pos=0
        if words[pos].type=="Pronoun"{
            pos+=1
        }
        
        var verb=""
        while words[pos].type=="Verb"{
            verb+=words[pos].word+" "
            pos+=1
        }
        
        action.past=verb.trimmingCharacters(in: .whitespacesAndNewlines)
        
        var sampleamount = -1
        if words[pos].type=="Number"{
            sampleamount=Int(words[pos].word)!
        }else if words[pos].type=="OtherWord"{
            sampleamount=Int(words[pos].word.digits)!
        }else{throw "invalid amount for sample sentence"}
        
        if (sampleamount==1) == (amount==1){
            throw "both sample and name name have same form"
        }
        
        pos+=1
        if words[pos].type=="Preposition"{
            pos+=1
        }
        
        var sampleobject=""
        while pos<words.count{
            sampleobject+=words[pos].word+" "
            pos+=1
        }
        
        if amount==1{
            object.plural=sampleobject.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        }else{
            object.singular=sampleobject.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
}

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

extension Habit{
    var progressText:String{
        var res="You \(self.action.past) "
        let amount=self.days.count>0 ? self.days[self.days.count-1].count : 0
        res+=String(amount)+" "
        if amount==1{
            res+=self.object.singular
        }else{
            res+=self.object.plural
        }
        return res
    }
    var goalText:String{
        if goalDone>=0{
            return "You accomplished your goal today! GOOD JOB!"
        }else{
            if goalCanDone=="late"{
                return "You were too late to complete the goal qwq... You were \(-goalDone) \(-goalDone==1 ? object.singular : object.plural) away!!!"
            }else{
                return "Start completing your goal at \(timeStr)!!"
            }
        }
    }
}

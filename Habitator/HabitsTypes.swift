import NaturalLanguage

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
    var name: String
    var amount: Int
    var time: Int //seconds
    var records: [ProgressRecord]
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
    init(name: String) throws{
        var words:[TagWordPair]=[]
        
        let tagger = NLTagger(tagSchemes: [.lexicalClass])
        tagger.string = name
        let options: NLTagger.Options = [.omitWhitespace]

        tagger.enumerateTags(in: name.startIndex..<name.endIndex, unit: .word, scheme: .lexicalClass, options: options) { tag, tokenRange in
            if let tag = tag {
                words+=[TagWordPair(type: tag.rawValue,word: "\(name[tokenRange])")]
            }
            return true
        }
        
        var pos=0
        if words[pos].type=="Verb"{
            action=ActionWord(past: words[pos].word, present: words[pos].word)
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
        while !(pos<words.count && words[pos].type=="Preposition"){
            objectName+=words[pos].word+" "
            pos+=1
        }
        objectName=objectName.trimmingCharacters(in: .whitespacesAndNewlines)
        object=ObjectWord(singular: objectName, plural: objectName)
        
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
        
        let timeStr=rawTime.digits
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
    }
}

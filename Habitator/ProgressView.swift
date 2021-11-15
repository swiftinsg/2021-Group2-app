//
//  ProgressView.swift
//  Habitator
//
//  Created by sap on 15/11/21.
//

import SwiftUI

struct progressView: View{
    @State var Progress: Progress
    var body: some View {
        VStack(){
            Text("Progress")
                .font(.system(size: 50, .weight: bold))
            }
        }
    }
let testProgress=[
    Habit(
        Text("Progress")
            .font(.system(size: 50, .weight: bold))
    )
]
 
struct ProgressView: View {
    @Binding var currentProgress: Progress?
    var body: some View {
        List {
            progressView()
        }
    }
}


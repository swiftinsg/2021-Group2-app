//
//  ProgressView.swift
//  Habitator
//
//  Created by sap on 15/11/21.
//

import SwiftUI

struct ProgressView: View {
    @Binding var currentProgress: Progress?
    var body: some View {
        VStack {
        Text("Progress")
            .font(.system(size: 50, weight: .bold, design: .rounded))
            //idk how line lol, anyway line goes here
            Text("You are from acheiving your goal!")
                .font(.system(size:35))
            Text("You stil have to salute 6000 times before 6pm")
                .font(.system(size:35))
            Text("Better hurryp up!")
                .font(.system(size:35))
        }
    }
}

//
//  ProgressView.swift
//  Habitator
//
//  Created by sap on 15/11/21.
//

import SwiftUI

struct ProgressView: View{
    var body: some View {
        VStack{
            Text("Progress")
                .font(.system(size: 50, weight: .bold))
        }
    }
}
 
struct ProgressView: View {
    var body: some View {
        List {
            ProgressView()
        }
    }
}


//
//  HomeView.swift
//  Habitator
//
//  Created by Nyein Nyein on 15/11/21.
//

import SwiftUI

struct HomeView: View {
    @Binding var currentHabit: Habit?
    @Binding var habits: [Habit]
    var counter = 0
    
    var body: some View {
        VStack{
             
            
                Text("You pressed\(counter)times")
                Button ("Add Progress") {
                counter + 1
                }
            
           
        
    }
}


}

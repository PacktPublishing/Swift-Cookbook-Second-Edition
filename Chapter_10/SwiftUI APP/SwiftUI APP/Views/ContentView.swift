//
//  ContentView.swift
//  SwiftUI APP
//
//  Created by Chris Barker on 30/12/2020.
//

import SwiftUI

struct ContentView: View {
    
    var tasks = [Task]()
    
    var body: some View {
        List(tasks) { task in
            ListRowView(description: task.description,
                        category: task.category)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(tasks: MockHelper.getTasks())
    }
}

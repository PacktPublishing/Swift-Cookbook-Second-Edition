//
//  Task.swift
//  SwiftUI APP
//
//  Created by Chris Barker on 30/12/2020.
//

import Foundation

struct Task: Identifiable {
    var description: String
    var category: String
    var id = UUID()
}

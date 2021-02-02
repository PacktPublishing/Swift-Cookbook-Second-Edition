//
//  Extensions.swift
//  SwiftUI APP
//
//  Created by Chris Barker on 30/12/2020.
//

import Foundation
import SwiftUI

struct CategoryText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .foregroundColor(.blue)
    }
}

extension View {
    func styleCategory() -> some View {
        self.modifier(CategoryText())
    }
}

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
            .font(.footnote)
            .foregroundColor(.blue)
            .padding(4)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.blue, lineWidth: 2)
                    
            )
            .shadow(color: .gray, radius: 1, x: -1, y: -1)
    }
}

extension View {
    func styleCategory() -> some View {
        self.modifier(CategoryText())
    }
}

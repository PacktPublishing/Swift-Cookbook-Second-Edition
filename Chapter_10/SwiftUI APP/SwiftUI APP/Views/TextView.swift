//
//  TextView.swift
//  SwiftUI APP
//
//  Created by Chris Barker on 30/12/2020.
//

import Foundation
import SwiftUI

struct TextView: UIViewRepresentable {
 
    @Binding var text: String
 
    func makeUIView(context: Context) -> UITextView {
        
        let textView = UITextView()
        return textView
    }
 
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator($text)
    }
     
    // Think of this as the delegate
    class Coordinator: NSObject, UITextViewDelegate {
        @State var text: Binding<String>
     
        init(_ text: Binding<String>) {
            self.text = text
        }
     
        func textViewDidChange(_ textView: UITextView) {
            self.text.wrappedValue = textView.text
        }
    }
    
}

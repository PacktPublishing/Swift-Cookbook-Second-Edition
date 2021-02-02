//
//  ListRowView.swift
//  SwiftUI APP
//
//  Created by Chris Barker on 30/12/2020.
//

import SwiftUI

struct ListRowView: View {
    
    var description: String = ""
    var category: String = ""
    
    // Example
    // @State var textViewString = ""
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(description)
                    .font(.title)
                    
                    .padding(EdgeInsets(top: 0,
                                        leading: 0,
                                        bottom: 2,
                                        trailing: 0))
                    .foregroundColor(.blue)
                Text(category)
                    .styleCategory()
                
                // Example
                // TextView(text: $textViewString)
                
            }
            Spacer()
            Image(systemName: "book")
                .font(.system(size: 32, weight: .regular))
                .foregroundColor(.blue)
                .padding()
                
        }
    }
    
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ListRowView(description: "Description Field",
                        category: "Category Field")
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
        .previewDisplayName("iPhone 12 Pro Max")
    }
}

//struct ListRowView_Previews_MockData2: PreviewProvider {
//    static var previews: some View {
//        List {
//            ListRowView(description: "Very Long Description Field, Very Long Description Field",
//                        category: "Very Long Category Field, Very Long Category Field")
//        }
//        .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
//        .previewDisplayName("iPhone 12 Pro Max - Data #2")
//    }
//}

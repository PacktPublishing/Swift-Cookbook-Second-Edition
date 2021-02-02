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
                Text(category.uppercased())
                    .styleCategory()
                    
            }
            Spacer()
            Image(systemName: Helper.getCategoryIcon(category: category))
                .font(.system(size: 32, weight: .regular))
                .foregroundColor(.pink)
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

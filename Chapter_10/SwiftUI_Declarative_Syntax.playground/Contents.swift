import PlaygroundSupport
import SwiftUI

struct MyView: View {
    
    @State var count: Int = 0
    
    @EnvironmentObject var bookStatus: BookStatus
    
    @AppStorage("book.title") var title: String = "Book Title"
    
    var body: some View {
        
        Group {
            VStack {
                Text(title)
                
                ResultView(count: $count)
                
                Button(action: {
                    count += 1
                    title = "Swift Cookbook"
                }, label: {
                    Text("Perform Action")
                })
                
                HStack {
                    Text("By Keith & Chris")
                    Image(systemName: "book")
                }
            }
            HStack {
                Text("I'm sitting underneath a HStack 😝")
            }
        }
    }
}

struct ResultView: View {
    
    @Binding var count: Int
    
    var body: some View {
        Text("Performed \(count) times")
    }
}

class BookStatus: ObservableObject {
    @Published var released = true
    @Published var title = ""
    @Published var authors = [""]
}


PlaygroundPage.current.setLiveView(MyView())

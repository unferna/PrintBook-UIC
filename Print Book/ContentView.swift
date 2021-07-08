//
//  ContentView.swift
//  Print Book
//
//  Created by Fernando Florez on 5/07/21.
//

import SwiftUI

struct ContentView: View {
    @State var nav = false
    @State private var selectedBooksToShow: Int = 0
    var books: [PresentationBook]!
    @State var selectedItem: PresentationBook!
    
    private let grid = [
        GridItem(.adaptive(minimum: 165, maximum: 175)),
        GridItem(.adaptive(minimum: 165, maximum: 175))
    ]
    
    private var filteredBooks: [PresentationBook] {
        if selectedBooksToShow == 0 {
            return books.filter { $0.isPopular }
        }
        
        return books
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Hey Fernando 👋")
                    .font(Utils.font(.loraBold, size: 30))
             
                Spacer()
                
                Image("imgProfile")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .cornerRadius(30)
                    .overlay(
                        RoundedRectangle.init(cornerRadius: 30, style: .circular)
                            .stroke()
                            .stroke(lineWidth: 1)
                            .foregroundColor(.red)
                    )
            }
            .padding()
            
            content
            
            Spacer()
            
            HStack(spacing: 60) {
                Image(systemName: "house.fill")
                Image(systemName: "magnifyingglass")
                Image(systemName: "list.bullet.rectangle")
                Image(systemName: "bookmark.fill")
            }.frame(height: 35)
        }
    }
    
    var content: some View {
        ScrollView {
            Picker("Book Type", selection: $selectedBooksToShow, content: {
                Text("Popular")
                    .tag(0)
                
                Text("Recent")
                    .tag(1)
            })
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .onAppear {
                UISegmentedControl.appearance().backgroundColor = .normalGrayBackground
                UISegmentedControl.appearance().selectedSegmentTintColor = .white
            }
            
            LazyVGrid(columns: grid, alignment: .center) {
                 ForEach(filteredBooks, id: \.id) { book in
                    Button(action: {
                        nav.toggle()
                        selectedItem = book
                        
                    }) {
                        BookItemCell(book: book)
                    }
                    .fullScreenCover(item: $selectedItem, onDismiss: {}, content: {
                        BookDetailView(book: $0)
                    })
                    .buttonStyle(PlainButtonStyle())
                 }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(books: getBooks())
    }
}

func getBooks() -> [PresentationBook] {
    var result: [PresentationBook] = []
    let names = [
        "Swift on Sundays",
        "SwiftUI by Example",
        "Testing Swift",
        "Dive into SpriteKit",
        "Swift Design Patterns",
        "Advanced iOS"
    ]
    
    for i in 0 ..< 6 {
        let price = Float.random(in: 50 ... 100)
        let stars = Int.random(in: 1 ... 5)
        
        result.append(
            PresentationBook(
                id: UUID(),
                name: names[i],
                author: "Paul Hudson",
                stars: stars,
                reviews: Int.random(in: 1 ... 500),
                imageUrl: "imgBook\(i + 1)",
                isSaved: Int.random(in: 0 ... 1) == 1,
                originalPrice: price,
                discountPrice: Float.random(in: 0 ... price - 5),
                isPopular: stars >= 3,
                color: getColor(),
                lastComment: "A great book"
            )
        )
    }
    
    return result
}

func getColor() -> UIColor {
    let red = CGFloat(arc4random()) / CGFloat(UInt32.max)
    let green = CGFloat(arc4random()) / CGFloat(UInt32.max)
    let blue = CGFloat(arc4random()) / CGFloat(UInt32.max)
    
    return UIColor(
        red: red,
        green: green,
        blue: blue,
        alpha: 1
    )
}

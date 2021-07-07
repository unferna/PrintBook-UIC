//
//  BookItemCell.swift
//  Print Book
//
//  Created by Fernando Florez on 5/07/21.
//

import SwiftUI

struct BookItemCell: View {
    @State var image = UIImage()
    @State var book: PresentationBook
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Image(book.imageUrl)
                    .resizable()
                    .aspectRatio(0.7, contentMode: .fit)
                    .padding()
                    .background(Color(book.color))
                    .cornerRadius(30)
            }
            
            Text(book.name)
                .font(Utils.font(.openSansBold, size: 20))
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 8)
                
            HStack(spacing: 15) {
                HStack(spacing: 8) {
                    ForEach((1 ... 5), id: \.self) { item in
                        Image(systemName: "star.fill")
                            .foregroundColor(item <= book.stars ? .yellow : .gray)
                            .frame(width: 8, height: 8, alignment: .leading)
                    }
                }.padding(.leading, -12)
                
                Text(String(book.reviews))
                    .font( Utils.font(.loraSemiBold, size: 14))
                
            }.padding(.horizontal, 16)
            
            HStack {
                if book.discountPrice != 0 {
                    let intDiscountPrice = Int(book.discountPrice)
                    Text("$\(intDiscountPrice)")
                        .font( Utils.font(.openSansBold, size: 20) )
                    
                    let intOriginal = Int(book.originalPrice)
                    Text("$\(intOriginal)")
                        .font( Utils.font(.openSansSemiBold, size: 14) )
                        .strikethrough()
                        .alignmentGuide(.leading, computeValue: { dimension in
                            dimension[.top]
                        })
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Image(systemName: book.isSaved ? "bookmark.fill" : "bookmark")
                }
            
            }.padding(.horizontal, 8)
        
        }.padding()
    }
}

struct BookItemCell_Previews: PreviewProvider {
    private static let testBook = PresentationBook(
        id: UUID(),
        name: "Test Book",
        stars: 3,
        reviews: 500,
        imageUrl: "imgBook1",
        isSaved: true,
        originalPrice: 10,
        discountPrice: 7,
        isPopular: false,
        color: .blue
    )
    
    static var previews: some View {
        BookItemCell(book: testBook)
            .previewLayout(.fixed(width: 208, height: 350))
    }
}

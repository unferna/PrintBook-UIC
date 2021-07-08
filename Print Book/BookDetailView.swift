//
//  BookDetailView.swift
//  Print Book
//
//  Created by Fernando Florez on 8/07/21.
//

import SwiftUI

struct BookDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isMonthlySelected = true
    
    var book: PresentationBook
    
    var body: some View {
        VStack {
            header
            contentView
        }
    }
    
    var header: some View {
        HStack {
            Button(action: closeView) {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .frame(width: 10, height: 15, alignment: .leading)
                    .foregroundColor(.black)
            }
            .padding()
            Spacer()
            
            Text("Upgrade to Pro 🔥")
                .fontWeight(.bold)
                .padding(.leading, -30)
            Spacer()
        }
    }
    
    var contentView: some View {
        VStack(alignment: .leading) {
            VStack {
                Image(book.imageUrl)
                    .resizable()
                    .aspectRatio(0.8, contentMode: .fit)
                    .padding()
                    .background(Color(book.color))
                    .cornerRadius(30)
                    .frame(maxWidth: .infinity)
                    .overlay(discountOverlay, alignment: .bottom)
                
            }.padding(.bottom, 8)
            
            VStack(alignment: .leading) {
                Text(book.name)
                    .font(Utils.font(.openSansBold, size: 28))
                    .multilineTextAlignment(.leading)
                
                Text("by \(book.author)")
                    .font(Utils.font(.loraSemiBold, size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 1)
                
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
                    
                }.padding(.horizontal, 8)
                
                Text(book.lastComment)
                    .font(Utils.font(.loraBold, size: 16))
                    .multilineTextAlignment(.leading)
                    .padding(.top, 2)
            }
            
            
            HStack(alignment: .center, spacing: 20) {
                Button(action: {
                    isMonthlySelected = true
                }) {
                    HStack {
                        Image(systemName: isMonthlySelected ? "circle.fill" : "circle")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .leading)
                            .foregroundColor(.black)
                        
                        VStack(alignment: .leading) {
                            Text("Mothly Plan")
                                .font(Utils.font(.openSansSemiBold, size: 12))
                                .foregroundColor(.gray)
                            
                            Text("$4/month")
                                .font(Utils.font(.loraBold, size: 16))
                                .foregroundColor(.black)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(lineWidth: 1)
                            .foregroundColor(.gray)
                    )
                }
                .frame(width: 150, height: 56)
                
                Button(action: {
                    isMonthlySelected = false
                }) {
                    HStack {
                        Image(systemName: isMonthlySelected ? "circle" : "circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .leading)
                            .foregroundColor(.black)
                        
                        VStack(alignment: .leading) {
                            Text("Yearly Plan")
                                .font(Utils.font(.openSansSemiBold, size: 12))
                                .foregroundColor(.gray)
                            
                            Text("$35/year")
                                .font(Utils.font(.loraBold, size: 16))
                                .foregroundColor(.black)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(lineWidth: 1)
                            .foregroundColor(.gray)
                    )
                }
                .frame(width: 150, height: 56)
                
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 4)
            
            VStack {
                Button("Checkout", action: {})
                    .font(Utils.font(.openSansBold, size: 16))
                    .frame(maxWidth: .infinity, maxHeight: 56)
                    .background(Color(.black))
                    .foregroundColor(.white)
                    .cornerRadius(16)
                
            }
        }.padding()
    }
    
    var discountOverlay: some View {
        ZStack {
            BlurView(style: .extraLight)
                .frame(width: 280, height: 56)
                .cornerRadius(28)
                .padding(.bottom, 16)
                
            VStack {
                HStack {
                    let discountPercent = Int( ((book.originalPrice - book.discountPrice) / book.originalPrice) * 100 )
                    Text("Save \(discountPercent)% now")
                        .font( Utils.font(.openSansBold, size: 14) )
                    Spacer()
                    
                    let intDiscountPrice = Int(book.discountPrice)
                    Text("$\( intDiscountPrice)")
                        .font( Utils.font(.openSansBold, size: 18) )
                    
                    let intOriginal = Int(book.originalPrice)
                    Text("$\( intOriginal )")
                        .font( Utils.font(.openSansSemiBold, size: 12) )
                        .strikethrough()
                        .alignmentGuide(.leading, computeValue: { dimension in
                            dimension[.top]
                        })
                        .foregroundColor(.gray)
                    Spacer()
                    
                    Image(systemName: book.isSaved ? "bookmark.fill" : "bookmark")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                
            }
            .frame(width: 280, height: 56)
            .cornerRadius(28)
            .padding(.bottom, 16)
        }
        
    }
    
    func closeView() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct BookDetailView_Previews: PreviewProvider {
    private static let testBook = PresentationBook(
        id: UUID(),
        name: "Test Book",
        author: "Unknown",
        stars: 3,
        reviews: 500,
        imageUrl: "imgBook2",
        isSaved: true,
        originalPrice: 10,
        discountPrice: 7,
        isPopular: false,
        color: .systemPink,
        lastComment: "A great book"
    )
    
    static var previews: some View {
        BookDetailView(book: testBook)
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }

}


//
//  Print_BookApp.swift
//  Print Book
//
//  Created by Fernando Florez on 5/07/21.
//

import SwiftUI

@main
struct Print_BookApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(books: getBooks())
        }
    }
}

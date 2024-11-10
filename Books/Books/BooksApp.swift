//
//  BooksApp.swift
//  Books
//
//  Created by dennis savchenko on 22/08/2024.
//

import SwiftUI

@main
struct BooksApp: App {
    
    @StateObject var booksViewModel: BooksViewModel = BooksViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(booksViewModel)
        }
    }
}

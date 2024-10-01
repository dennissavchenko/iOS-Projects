//
//  listScroll.swift
//  ToDoList
//
//  Created by dennis savchenko on 19/08/2024.
//

import SwiftUI

struct listScroll: View {
    @State private var disableScrollUp = false

        var body: some View {
            ScrollView {
                VStack {
                    GeometryReader { geometry in
                        Color.clear // Invisible view to detect the scroll position
                            .onChange(of: geometry.frame(in: .global).minY) { newY in
                                // If we're at the top of the scroll view, disable further upward scrolling
                                if newY >= 0 {
                                    disableScrollUp = true
                                } else {
                                    disableScrollUp = false
                                }
                            }
                    }
                    .frame(height: 0) // Make this view height zero so it doesn't interfere with the layout

                    // Your list items here
                    ForEach(0..<50, id: \.self) { i in
                        Text("Item \(i)")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                }
            }
            // Disable scrolling when at the top
            .disabled(disableScrollUp)
        }
}

#Preview {
    listScroll()
}

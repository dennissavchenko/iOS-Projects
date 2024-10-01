//
//  ItemView.swift
//  ToDoList
//
//  Created by dennis savchenko on 18/08/2024.
//

import SwiftUI

struct ItemView: View {
    
    @Binding var item: TaskItem
    @Binding var items: [TaskItem]
    
    @State var tWidthDesc: Double = 0
    @State var sWidth: Double = 0
    @State var tWidth: Double = 0
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.task)
                    .fontWeight(.light)
                    .foregroundStyle(sWidth > 0 ? .gray : .black)
                    .overlay(alignment: .leading) {
                        Rectangle()
                            .frame(width: max(0, sWidth), height: 1)
                            .foregroundColor(sWidth > 0 ? .gray : .black)
                            .animation(.easeInOut, value: sWidth)
                    }
                    .background(GeometryReader { geometry in
                        Color.clear.preference(key: WidthPreferenceKey.self, value: geometry.size.width)
                    })
                    .onPreferenceChange(WidthPreferenceKey.self) { width in
                        tWidth = width
                        if item.isCompleted {
                            sWidth = tWidth
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if item.isCompleted {
                                    if value.translation.width < 0 {
                                        sWidth = tWidth + value.translation.width
                                    }
                                } else {
                                    if sWidth < tWidth {
                                        sWidth = value.translation.width
                                    }
                                }
                            }
                            .onEnded { value in
                                withAnimation {
                                    if value.translation.width > tWidth / 2 {
                                        sWidth = tWidth
                                        item.isCompleted = true
                                    } else {
                                        sWidth = 0
                                        item.isCompleted = false
                                    }
                                    items.sort(by: { !$0.isCompleted && $1.isCompleted })
                                }
                            }
                    )
                if item.note != nil {
                    Text(item.note!)
                        .font(.footnote)
                        .fontWeight(.light)
                        .foregroundStyle(sWidth > 0 ? .gray : .black)
                        .overlay(alignment: .leading) {
                            Rectangle()
                                .frame(width: max(0, (sWidth / tWidth) * tWidthDesc), height: 1)
                                .foregroundColor(sWidth > 0 ? .gray : .black)
                                .animation(.easeInOut, value: sWidth)
                        }
                        .background(GeometryReader { geometry in
                            Color.clear.preference(key: WidthPreferenceKey.self, value: geometry.size.width)
                        })
                        .onPreferenceChange(WidthPreferenceKey.self) { width in
                            tWidthDesc = width
                        }
                }
            }
            Spacer()
        }
    }
    
    struct WidthPreferenceKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
    
}

#Preview {
    ItemView(item: .constant(TaskItem(task: "Hello", note: "hello")), items: .constant([TaskItem(task: "Hello")]))
}

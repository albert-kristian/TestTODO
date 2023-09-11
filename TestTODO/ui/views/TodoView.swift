//
//  TodoView.swift
//  TestTODO
//
//  Created by Albert Kristian on 30.08.2023.
//

import SwiftUI

struct TodoView: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach((0...100), id: \.self) { i in
                        TodoItemView(title: "Title: \(i)", content: getContentText(index: i))
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height:0)))
                            .padding(.horizontal, 8)
                    }
                }
            }
            AddItemFloatingButton()
        }
    }
    
    private func getContentText(index i: Int) -> String {
        if (i % 2 == 0) {
            return "Some super long text that does not fit in one line and has to use more we need it to test how does the card collapse and expand and some more text to properly test it"
        }
        return "Title: \(i)"
    }
}
//# if DEBUG

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView()
    }
}

//# endif

private struct TodoItemView: View {

    @State private var isCollapsed: Bool = true
    @State private var lineLimit: Int = 1
    
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text(title)
            }.frame(maxWidth: .infinity)
            Divider()
            Text(content).onTapGesture {
                isCollapsed = !isCollapsed
                withAnimation {
                    if (isCollapsed) {
                        lineLimit = 1
                    } else {
                        lineLimit = Int.max
                    }
                }
            }.lineLimit(lineLimit).font(.system(size: 28))
        }.frame(maxWidth: .infinity, minHeight: 0)
            .padding(16)
            .background(Color.yellow)
    }
}

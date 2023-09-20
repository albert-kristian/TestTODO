//
//  MainView.swift
//  TestTODO
//
//  Created by Albert Kristian on 11.09.2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView {
                TodoView().tabItem {
                    Label("Today", systemImage: "calendar.day.timeline.left")
                }
                Text("TODO").tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
            }
            AddItemButton(onClick: {
                //TODO: Implement navigation to AddItemScreen
            })
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

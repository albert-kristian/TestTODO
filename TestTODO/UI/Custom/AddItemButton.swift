//
//  AddItemFloatingButton.swift
//  TestTODO
//
//  Created by Albert Kristian on 02.09.2023.
//

import SwiftUI

struct AddItemButton: View {
    let onClick: () -> Void

    var body: some View {
        Button {
            onClick()
        } label: { Image(systemName: "plus")
                .font(.title.weight(.semibold))
                .padding()
                .background(Color.blue.grayscale(0.1))
                .foregroundColor(.white)
                .clipShape(Circle())
                .shadow(radius: 4, x: 0, y: 4)
        }.padding(16)
    }
}

struct AddItemButton_Previews: PreviewProvider {
    static var previews: some View {
        AddItemButton(onClick: {})
    }
}

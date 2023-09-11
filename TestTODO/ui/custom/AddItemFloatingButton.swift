//
//  AddItemFloatingButton.swift
//  TestTODO
//
//  Created by Albert Kristian on 02.09.2023.
//

import SwiftUI

struct AddItemFloatingButton: View {
    let onClick: () ->
    
    var body: some View {
        Button {
            
        } label: { Image(systemName: "plus")
                .font(.title.weight(.semibold))
                .padding()
                .background(Color.yellow.grayscale(0.2))
                .foregroundColor(.white)
                .clipShape(Circle())
                .shadow(radius: 4, x: 0, y: 4)
        }.padding(24)
    }
}

struct AddItemFloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        AddItemFloatingButton()
    }
}

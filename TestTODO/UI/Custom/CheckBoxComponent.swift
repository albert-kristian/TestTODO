//
//  CheckBoxComponent.swift
//  TestTODO
//
//  Created by Albert Kristian on 11.09.2023.
//

import SwiftUI

struct CheckBoxComponent: View {
    let isChecked: Bool

    var body: some View {
            Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isChecked ? Color(UIColor.systemBlue) : Color.secondary)
        }
}

struct CheckBoxComponent_Previews: PreviewProvider {

    static var previews: some View {
        CheckBoxComponent(isChecked: false)
        CheckBoxComponent(isChecked: true)
    }
}

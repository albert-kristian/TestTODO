//
//  CheckBoxComponent.swift
//  TestTODO
//
//  Created by Albert Kristian on 11.09.2023.
//

import SwiftUI

struct CheckBoxComponent: View {
    let isChecked: Bool
    let onCheck: (Bool) -> ()
    
    var body: some View {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .foregroundColor(isChecked ? Color(UIColor.systemBlue) : Color.secondary)
                .onTapGesture {
                    onCheck(!isChecked)
                }
        }
}

struct CheckBoxComponent_Previews: PreviewProvider {
    struct CheckBoxComponentHolder: View {
        @State var isChecked = false
        
        var body: some View {
            CheckBoxComponent(isChecked: false, onCheck: { newValue in })
        }
    }
    
    static var previews: some View {
        CheckBoxComponentHolder()
    }
}

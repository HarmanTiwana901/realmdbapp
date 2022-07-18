//
//  SmallAddButton.swift
//  ToDo
//
//  Created by Jessie sihota on 2022-07-18.
//

import SwiftUI

struct SmallAddButton: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 50)
                
            Text("+")
                .font(.title)
                
                .foregroundColor(.white)
        }
        .frame(height: 50)
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        SmallAddButton()
    }
}

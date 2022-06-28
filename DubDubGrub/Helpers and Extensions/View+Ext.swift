//
//  View+Ext.swift
//  DubDubGrub
//
//  Created by River McCaine on 6/27/22.
//

import SwiftUI

extension View {
    func profileNameStyle() -> some View {
        self.modifier(ProfileNameText())
    }
    
    func buttonStyling() -> some View {
        self.modifier(ButtonStyling())
    }
}

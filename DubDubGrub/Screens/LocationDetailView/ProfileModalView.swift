//
//  ProfileModal.swift
//  DubDubGrub
//
//  Created by River McCaine on 7/5/22.
//

import SwiftUI

struct ProfileModalView: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer().frame(height: 60)
                Text("River McCaine")
                    .bold()
                    .font(.title2)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                Text("Test Company")
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                    .foregroundColor(.secondary)
                Text("This is my sample bio. Im trying to test the testing of tests with this testy tests. How does this look so far my guy is it testing?")
                    .lineLimit(3)
                    .padding()
            }
            .frame(width: 300, height: 230)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(16)
            .overlay(Button {
                    //dissmiss
                } label: {
                    XDismissButton()
                }, alignment: .topTrailing)
            
                        
            Image(uiImage: PlaceholderImage.avatar)
                .resizable()
                .scaledToFill()
                .frame(width:110, height: 110)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 6)
                .offset(y: -120)
        }
    }
}

struct ProfileModalView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileModalView()
    }
}

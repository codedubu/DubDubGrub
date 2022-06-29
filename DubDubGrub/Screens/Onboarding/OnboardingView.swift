//
//  OnboardingView.swift
//  DubDubGrub
//
//  Created by River McCaine on 6/29/22.
//

import SwiftUI

struct OnboardingView: View {
    
    @Binding var isShowingOnboardingView: Bool
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Button {
                    isShowingOnboardingView = false
                } label: {
                    XDismissButton()
                        .padding()
                }
            }
            
            Spacer()
            
            LogoView(frameWidth: 250)
                .padding(.bottom)
            
            VStack(alignment: .leading, spacing: 32) {
                OnboardingInfoView(imageName: "building.2.crop.circle",
                                   title: "Restauraunt Locations",
                                   caption: "Find places to dine around the convention center")
                
                OnboardingInfoView(imageName: "checkmark.circle",
                                   title: "Check In",
                                   caption: "Let other iOS Devs know where you are")
                
                OnboardingInfoView(imageName: "person.2.circle",
                                   title: "Find Friends",
                                   caption: "See where other iOS Devs are and join the party")
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    
    static var previews: some View {
        OnboardingView(isShowingOnboardingView: .constant(true))
    }
}

struct OnboardingInfoView: View {
    
    var imageName: String
    var title: String
    var caption: String
    
    var body: some View {
        HStack(spacing: 26) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.brandPrimary)
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .bold()
                Text(caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
            }
        }
    }
}

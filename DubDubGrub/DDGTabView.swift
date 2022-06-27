//
//  DDGTabView.swift
//  DubDubGrub
//
//  Created by River McCaine on 6/27/22.
//

import SwiftUI

struct DDGTabView: View {
    
    var body: some View {
        
        TabView {
            LocationMapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
            LocationListView()
                .tabItem {
                    Label("Locations", systemImage: "building")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
            
            
        }
        .accentColor(.brandPrimary)
        .onAppear {
            let appearance              = UITabBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor  = UIColor.systemBackground.withAlphaComponent(0.03)
            UITabBar
                .appearance()
                .standardAppearance     = appearance
            UITabBar
                .appearance()
                .scrollEdgeAppearance   = appearance
        }
    }
}

struct DDGTabView_Previews: PreviewProvider {
    static var previews: some View {
        DDGTabView()
    }
}

//
//  LocationDetailView.swift
//  DubDubGrub
//
//  Created by River McCaine on 6/27/22.
//

import SwiftUI

struct LocationDetailView: View {
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    var body: some View {
        
        VStack(spacing: 16) {
            BannerImageView(imageName: "default-banner-asset")
            HStack {
                AddressView(address: "123 Main Street")
                
                Spacer()
            }
            .padding(.horizontal)
            
            DescriptionView(text: "It's the test restauraunt, enough said. It's the test restauraunt, enough said. It's the test restauraunt, enough said. It's the test restauraunt, enough said.")
            
            Spacer()
            
            ZStack {
                Capsule()
                    .frame(height: 80)
                    .foregroundColor(Color(.secondarySystemBackground))
                HStack(spacing: 24) {
                    Button {
                        print("lol")
                    } label: {
                        LocationActionButton(color: .brandPrimary, imageName: "location.fill")
                        
                    }
                    
                    Link(destination: URL(string: "https://www.apple.com")!, label: {
                        LocationActionButton(color: .brandPrimary, imageName: "network")
                        
                    })
                    
                    Button {
                        print("lol")
                    } label: {
                        LocationActionButton(color: .brandPrimary, imageName: "phone.fill")
                        
                    }
                    
                    Button {
                        print("lol")
                    } label: {
                        LocationActionButton(color: .brandPrimary, imageName: "person.fill.checkmark")
                        
                    }
                    
                }
                .padding(.horizontal)
            }
            
            Spacer()
            
            Text("Who's Here?")
                .font(.title2)
                .bold()
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    FirstNameAvatarView(firstName: "River")
                    FirstNameAvatarView(firstName: "Donnie")
                    FirstNameAvatarView(firstName: "Ronnie")
                    FirstNameAvatarView(firstName: "Bonnie")
                    FirstNameAvatarView(firstName: "Connie")
                    FirstNameAvatarView(firstName: "Lonnie")
                    FirstNameAvatarView(firstName: "Seannie")
                }
            }
        }
        .navigationTitle("Location Name")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LocationDetailView()
        }
    }
}

struct LocationActionButton: View {
    
    var color: Color
    var imageName: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(color)
                .frame(width: 60, height: 60)
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(width: 22, height: 22)

        }
    }
}


struct FirstNameAvatarView: View {
    
    var firstName: String
    
    var body: some View {
        
        VStack {
            AvatarView(size: 64)
            Text(firstName)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
    }
}

struct BannerImageView: View {
    
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(height: 120)
    }
}

struct AddressView: View {
    
    var address: String
    
    var body: some View {
        Label(address, systemImage: "mappin.and.ellipse")
            .font(.caption)
            .foregroundColor(.secondary)
    }
}

struct DescriptionView: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .lineLimit(3)
            .minimumScaleFactor(0.75)
            .padding(.horizontal)
            .fixedSize(horizontal: false, vertical: true)
            .frame(height: 70)
    }
}

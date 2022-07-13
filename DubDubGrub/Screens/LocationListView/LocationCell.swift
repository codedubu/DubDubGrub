//
//  LocationCell.swift
//  DubDubGrub
//
//  Created by River McCaine on 6/27/22.
//

import SwiftUI

struct LocationCell: View {
    
    var location: DDGLocation
    var profiles: [DDGProfile]
    
    var body: some View {
        
        HStack {
            
            Image(uiImage: location.squareImage)
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)
                .clipShape(Circle())
                .padding(.vertical, 8)
            
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.50)
                    .padding(.trailing)
                
                if profiles.isEmpty {
                    Text("Nobody's here yet!")
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                        .padding(.top, 2)
                } else {
                    HStack {
                        ForEach(profiles.indices, id: \.self) { index in
                            if index <= 3 {
                                AvatarView(image: profiles[index].avatarImage, size: 35)
                            } else if index == 4 {
                                AdditionalProfileView(number: profiles.count - 4)
                            }
                            
                        }
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 14)
        }
    }
}

struct LocationCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationCell(location: DDGLocation(record: MockData.location), profiles: [])
    }
}

struct AdditionalProfileView: View {
    
    var number: Int
    
    var body: some View {
        Text("+\(number)")
            .font(.system(size: 14, weight: .semibold))
            .frame(width: 35, height: 35)
            .background(Color.brandPrimary)
            .clipShape(Circle())
        
    }
}

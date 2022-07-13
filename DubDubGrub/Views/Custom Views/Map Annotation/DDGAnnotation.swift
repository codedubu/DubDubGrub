//
//  DDGAnnotation.swift
//  DubDubGrub
//
//  Created by River McCaine on 7/12/22.
//

import SwiftUI

struct DDGAnnotation: View {
    
    var location: DDGLocation
    var number: Int
    
    var body: some View {
        
        VStack {
            ZStack {
                MapBalloon()
                    .frame(width: 100, height: 90)
                    .foregroundColor(.brandPrimary)
                    .opacity(0.85)
                Image(uiImage: location.squareImage)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .offset(y: -19)
                
                if number > 0 {
                    Text("\(min(number, 99))")
                        .font(.system(size: 11, weight: .bold))
                        .frame(width:26, height: 18)
                        .background(Color.grubRed)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .offset(x: 18, y: -40)                    
                }
            }
            Text(location.name)
                .font(.caption)
                .fontWeight(.semibold)
        }
    }
}

struct DDGAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        DDGAnnotation(location:DDGLocation(record: MockData.location), number: 44)
    }
}

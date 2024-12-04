//
//  PlaceItemView.swift
//  CoolPlaces
//
//  Created by Elano Vasconcelos on 30/11/24.
//

import SwiftUI

struct PlaceItemView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    let item: PlaceItem
    
    var body: some View {
        HStack {
            ImageView(url: item.thumbnail)
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(item.type)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                Group {
                    Text(item.name)
                    Text(item.cityName)
                }
                .foregroundStyle(colorScheme != .dark ? .black : .white)
                
            }
            
            Spacer()
            
            Text(item.rating)
                .foregroundStyle(.yellow)
        }
    }
}

#Preview {
    VStack {
        PlaceItemView(item: .debug)
        PlaceItemView(item: .debugNoImage)
    }
    .padding()
    
}

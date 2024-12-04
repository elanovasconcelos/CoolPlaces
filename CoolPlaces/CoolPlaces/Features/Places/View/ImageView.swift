//
//  ImageView.swift
//  CoolPlaces
//
//  Created by Elano Vasconcelos on 30/11/24.
//

import SwiftUI
import Kingfisher

struct ImageView: View {
    
    let url: String?
    
    var body: some View {
        if let url, let imageUrl = URL(string: url) {
            KFImage(imageUrl)
                .resizable()
                .placeholder {
                    ProgressView()
                }
                .cancelOnDisappear(true)
                .clipped()
        } else {
            Image("no_image")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
        }
    }
}

#Preview {
    ImageView(url: nil)
}

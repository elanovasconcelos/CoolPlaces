//
//  TextView.swift
//  CoolPlaces
//
//  Created by Elano Vasconcelos on 30/11/24.
//

import SwiftUI

struct TextView: View {
    
    let title: String
    let detail: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundStyle(.gray)
            Text(detail)
        }
    }
}

#Preview {
    TextView(title: "Title", detail: "Line 1")
}

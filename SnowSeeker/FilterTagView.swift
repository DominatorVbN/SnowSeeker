//
//  FilterTagView.swift
//  SnowSeeker
//
//  Created by dominator on 18/04/20.
//  Copyright © 2020 dominator. All rights reserved.
//

import SwiftUI

struct FilterTagView: View {
    let filter: Filter
    let onCancel: ()->Void
    var body: some View {
        HStack{
            filter.type.text
            Button(action: onCancel) {
                Image(systemName: "xmark")
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(
            Capsule().fill(Color(UIColor.quaternarySystemFill))
            .shadow(radius: 5)
        )
    }
}

struct FilterTagView_Previews: PreviewProvider {
    static var previews: some View {
        FilterTagView(filter: Filter(type: .country(name: "India"))) {
            
        }
    }
}

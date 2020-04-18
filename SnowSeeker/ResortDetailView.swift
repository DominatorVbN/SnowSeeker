//
//  ResortDetailView.swift
//  SnowSeeker
//
//  Created by dominator on 17/04/20.
//  Copyright © 2020 dominator. All rights reserved.
//

import SwiftUI

struct ResortDetailView: View {
    let resort: Resort
    var size: String{
        switch resort.size {
        case 0...1:
            return "Small"
        case 2:
            return "Medium"
        default:
            return "Large"
        }
    }
    var price: String{
        String(repeating: "$", count: resort.price)
    }
    
    var body: some View {
        Group {
            Text("Size: \(size)").layoutPriority(1)
            Spacer().frame(height: 0)
            Text("Price: \(price)").layoutPriority(1)
        }
    }
}

struct ResortDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetailView(resort: Resort.example)
    }
}

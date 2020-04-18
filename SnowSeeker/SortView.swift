//
//  SortView.swift
//  SnowSeeker
//
//  Created by dominator on 18/04/20.
//  Copyright © 2020 dominator. All rights reserved.
//

import SwiftUI

struct SortView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var sort: SortedBy
    var body: some View {
        NavigationView{
            Form{
                ForEach(SortedBy.allCases, id: \.self){ sortType in
                    Button(action: {
                        self.sort = sortType
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack{
                            Text(sortType.rawValue)
                            Spacer()
                            if self.sort == sortType{
                                Image(systemName: "checkmark")
                                    .foregroundColor(.accentColor)
                            }
                        }
                    }
                .buttonStyle(PlainButtonStyle())
                }
            }
            .navigationBarTitle(Text("Sort by"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SortView_Previews: PreviewProvider {
    static var previews: some View {
        SortView(sort: .constant(.alphabetical))
    }
}

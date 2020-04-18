//
//  FilterView.swift
//  SnowSeeker
//
//  Created by dominator on 18/04/20.
//  Copyright © 2020 dominator. All rights reserved.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var filters: [Filter]
    @State var selectedCountry: String = ""
    @State var selectedSize: Int = 0
    let countries = [
        "France",
        "Austria",
        "United States",
        "Italy",
        "Canada"
    ]
    var body: some View {
        NavigationView {
            Form{
                Picker(selection: $selectedCountry, label: Text("Country")) {
                    ForEach(countries, id: \.self) {
                        Text($0)
                    }
                }
                Picker(selection: $selectedSize, label: Text("Size")) {
                    ForEach(1..<4){
                        Text(String(repeating: "$", count: $0))
                    }
                }
            }
        .navigationBarTitle("Filter by")
        .navigationBarItems(trailing:
            Button("apply"){
                self.apply()
            }
            )
        }
    .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func apply(){
        if !self.selectedCountry.isEmpty{
            if let con = self.filters.firstIndex(where: { (op:Filter) -> Bool in
                switch op.type{
                case .country:
                    return true
                case .size:
                    return false
                }
            }){
                self.filters.remove(at: con)
            }
            print("adding country filter")
            self.filters.append(Filter(type: .country(name: self.selectedCountry)))
        }
        if self.selectedSize != 0{
            if let con = self.filters.firstIndex(where: { (op:Filter) -> Bool in
                switch op.type{
                case .country:
                    return false
                case .size:
                    return true
                }
            }){
                self.filters.remove(at: con)
            }
            print("adding size filter")
            self.filters.append(Filter(type: .size(size: selectedSize)))
        }
        presentationMode.wrappedValue.dismiss()
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(filters: .constant([Filter(type: FilterType.country(name: "USA"))]))
    }
}

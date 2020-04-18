//
//  ResortView.swift
//  SnowSeeker
//
//  Created by dominator on 17/04/20.
//  Copyright © 2020 dominator. All rights reserved.
//

import SwiftUI

struct ResortView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    let resort: Resort
    @State private var selectedFacility: Facility?
    @EnvironmentObject private var favorites: Favorites
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 0){
                Image(decorative: resort.id)
                .resizable()
                .scaledToFit()
                HStack{
                    if sizeClass == .compact{
                        Spacer()
                        VStack { ResortDetailView(resort: resort) }
                        VStack { SkiDetailsView(resort: resort) }
                        Spacer()
                    }else{
                        ResortDetailView(resort: resort)
                        Spacer().frame(height: 0)
                        SkiDetailsView(resort: resort)
                    }

                }
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.top)
                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    Text("Facilities")
                        .font(.largeTitle)
                    HStack {
                        ForEach(resort.facitilyTypes) { facility in
                            facility.icon
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
            }
            Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                if self.favorites.contains(self.resort){
                    self.favorites.remove(self.resort)
                }else{
                    self.favorites.add(self.resort)
                }
            }
            .padding()
            .hoverEffect(.automatic)
        }
        .navigationBarTitle(resort.name)
        .alert(item: $selectedFacility) { facility in
            facility.alert
        }
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}

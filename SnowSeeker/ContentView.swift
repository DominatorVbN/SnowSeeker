//
//  ContentView.swift
//  SnowSeeker
//
//  Created by dominator on 16/04/20.
//  Copyright © 2020 dominator. All rights reserved.
//

import SwiftUI
enum SortedBy: String, CaseIterable{
    case `default`
    case alphabetical
    case country
}

struct Filter: Identifiable {
    let id = UUID()
    let type: FilterType
}

enum FilterType: Equatable{
    case country(name: String)
    case size(size: Int)
    
    var text: some View{
        Text(getText())
    }
    
    
    func getText()->String{
        switch self {
        case .country(let name):
            return "\(name)"
        case .size(let size):
            return "size: \(size)"
        }
    }
}

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    var sortedResots: [Resort]{
        switch sort {
        case .default:
            return resorts
        case .alphabetical:
            return resorts.sorted(by: { $0.name < $1.name})
        case .country:
            return resorts.sorted(by: { $0.country < $1.country})
        }
    }
    
    var filteredArray: [Resort]{
        filter(self.filter, result: self.sortedResots)
    }
    
    @ObservedObject private var favorites = Favorites()
    @State var sort: SortedBy = .default
    @State private var isSowingSortOptions = false
    @State private var isShowingFilter = false
    @State private var filter: [Filter] = []
    
    var list: some View{
        ForEach(filteredArray) { resort in
            NavigationLink(destination: ResortView(resort: resort)) {
                HStack{
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                    )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                    )
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    if self.favorites.contains(resort){
                        Spacer()
                        Image(systemName: "heart.fill")
                            .font(.headline)
                            .foregroundColor(.red)
                    }
                }
                .hoverEffect(.automatic)
                .contextMenu{
                    Button(action: {
                        if self.favorites.contains(resort){
                            self.favorites.remove(resort)
                        }else{
                            self.favorites.add(resort)
                        }
                    }, label: {
                        Text(self.favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites")
                    })
                }
            }
        }
        .navigationBarTitle("Resorts")
        .environmentObject(favorites)
    }
    var body: some View {
        NavigationView {
            List{
                if filter.count > 0{
                    ScrollView{
                        HStack{
                            ForEach(filter){ filter in
                                FilterTagView(filter: filter) {
                                    if let index = self.filter.firstIndex(where: {$0.id == filter.id}){
                                        self.filter.remove(at: index)
                                    }
                                }
                            }
                            Spacer()
                        }
                    }.padding(.vertical, 10)
                }
                list
            }
            .navigationBarItems(leading:
                Button(action: {
                    self.isShowingFilter = true
                }, label: {
                    HStack{
                        Image(systemName: "line.horizontal.3.decrease.circle")
                        Text("filter")
                    }
                })
                .hoverEffect(.automatic)
                
                , trailing:
                Button(action: {
                    self.isSowingSortOptions = true
                }, label: {
                    HStack{
                        Image(systemName: "arrow.up.arrow.down")
                        Text("sort")
                    }
                })
                .hoverEffect(.automatic)
                .contextMenu{
                    Button("Default"){self.sort = .default}
                    Button("Alphabetical"){self.sort = .alphabetical}
                    Button("Country"){self.sort = .country}
                }
                .sheet(isPresented: $isSowingSortOptions, content: {
                    SortView(sort: self.$sort)
                })
            )
            WelcomeView()
        }
        .environmentObject(favorites)
        .sheet(isPresented: $isShowingFilter, content: {
            FilterView(filters: self.$filter)
        })

//        .actionSheet(isPresented: $isSowingSortOptions) { () -> ActionSheet in
//            ActionSheet(title: Text("Sort By"), buttons: [
//                .default(Text("Default"), action: {self.sort = .default}),
//                .default(Text("Alphabetical"), action: {self.sort = .alphabetical}),
//                .default(Text("Country"), action: {self.sort = .country}),
//                .cancel()
//            ])
//        }
    }
    func filter(_ filters: [Filter], result: [Resort])->[Resort]{
        guard filter.count > 0 else {return result}
        if filters.count == 1{
            return filter(filters[0].type, on: result)
        }else{
            let filtered = filter(filters[0].type, on: result)
            var updatedFil = filters
            updatedFil.remove(at: 0)
            return filter(updatedFil, result: filtered)
        }
    }
    
    func filter(_ filter: FilterType, on resorts: [Resort]) -> [Resort] {
        switch filter {
        case .country(let name):
            return resorts.filter({$0.country == name})
        case .size(let size):
            return resorts.filter({$0.size == size})
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  Favorites.swift
//  SnowSeeker
//
//  Created by dominator on 17/04/20.
//  Copyright © 2020 dominator. All rights reserved.
//

import SwiftUI

class Favorites: ObservableObject {
    private var resorts: Set<String>
    
    private static let saveKey = "Favorites"
    private static var url: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(saveKey)
    }
    
    init() {
        if let data = try? Data(contentsOf: Favorites.url){
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data){
                self.resorts = decoded
                return
            }
        }
        
        self.resorts = []
    }
    
    func  contains(_ resort: Resort)-> Bool{
        self.resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort){
        self.resorts.insert(resort.id)
        self.objectWillChange.send()
        self.save()
    }
    
    func remove(_ resort: Resort){
        self.resorts.remove(resort.id)
        self.objectWillChange.send()
        self.save()
    }
    
    
    func save(){
        if let data = try? JSONEncoder().encode(self.resorts){
            try? data.write(to: Favorites.url)
        }
    }
    
}

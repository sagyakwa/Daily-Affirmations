//
//  ContentView.swift
//  Daily Affirmations
//
//  Created by Samuel Agyakwa on 5/21/20.
//  Copyright © 2020 Samuel Agyakwa. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
 
    var body: some View {
        TabView(selection: $selection){
            Text("First View")
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "sun.max.fill")
                        Text("Affirmations")
                    }
                }
                .tag(0)
            
            AffirmationsView()
                .tabItem {
                    VStack {
                        Image(systemName: "square.and.pencil")
                        Text("Add")
                    }
                }
                .tag(1)
            
            Text("Third View")
            .font(.title)
            .tabItem {
                VStack {
                    Image(systemName: "text.alignleft")
                    Text("Settings")
                }
            }
            .tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

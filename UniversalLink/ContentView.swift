//
//  ContentView.swift
//  UniversalLink
//
//  Created by Anders Munck on 16/06/2020.
//  Copyright © 2020 Anders Munck. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var appState:AppState
    
    var body: some View {
        Text(appState.publicid == "" ? "No publicID received" : "publicID is \(appState.publicid)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class AppState:ObservableObject {
    @Published var publicid:String = ""
}

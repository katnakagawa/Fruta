//
//  FrutaApp.swift
//  Fruta
//
//  Created by Katsuya Nakagawa on 2021/08/12.
//

import SwiftUI

@main
struct FrutaApp: App {
    @StateObject private var model = Model()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}

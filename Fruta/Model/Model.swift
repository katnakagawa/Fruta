//
//  Model.swift
//  Model
//
//  Created by Katsuya Nakagawa on 2021/08/14.
//

import Foundation

class Model: ObservableObject {
    @Published var order: Order?
    @Published var account: Account?
    
    var hasAccount: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return userCredential != nil && account != nil
        #endif
    }
    
    @Published var searchString = ""
    
    let defaults = UserDefaults(suiteName: "group.katnakagawa.fruta")
    
    private var userCredential: String? {
        get { defaults?.string(forKey: "UserCredential") }
        set { defaults?.setValue(newValue, forKey: "UserCredential") }
    }
}

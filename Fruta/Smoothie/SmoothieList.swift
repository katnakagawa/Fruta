//
//  SmoothieList.swift
//  SmoothieList
//
//  Created by Katsuya Nakagawa on 2021/08/14.
//

import SwiftUI

struct SmoothieList: View {
    var smoothies: [Smoothie]
    
    @State private var selection: Smoothie.ID?
    @EnvironmentObject private var model: Model
    
    var listedSmoothies: [Smoothie] {
        smoothies
            .filter { $0.matches(model.searchString) }
            .sorted(by: { $0.title.localizedCompare($1.title) == .orderedAscending })
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            List {
                ForEach(listedSmoothies) { smoothie in
                    NavigationLink(tag: smoothie.id, selection: $selection) {
                        
                    } label: {
                        SmoothieRow(smoothie: smoothie)
                    }
                }
            }
        }
    }
}

struct SmoothieList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach([ColorScheme.light, .dark], id: \.self) { scheme in
            NavigationView {
                SmoothieList(smoothies: Smoothie.all())
                    .navigationTitle(Text("Smoothies", comment: "Navigation title for the full list of smoothies"))
                    .environmentObject(Model())
            }
            .preferredColorScheme(scheme)
        }
    }
}

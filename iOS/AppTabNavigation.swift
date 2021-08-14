//
//  AppTabNavigation.swift
//  AppTabNavigation
//
//  Created by Katsuya Nakagawa on 2021/08/12.
//

import SwiftUI

struct AppTabNavigation: View {
    
    enum Tab {
        case menu
        case favorites
        case rewards
        case recepes
    }
    
    @State private var selection: Tab = .menu
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                SmoothieMenu()
            }
            .tabItem {
                let menuText = Text("Menu", comment: "Smoothie menu tab title")
                Label {
                    menuText
                } icon: {
                    Image(systemName: "list.bullet")
                }
            }
            
            NavigationView {
                
            }
            .tabItem {
                Label(title: {
                    Text("Favorites", comment: "Favorite smoothies tab title")
                }, icon: {
                    Image(systemName: "heart.fill")
                })
            }
            
            NavigationView {
                
            }
            .tabItem {
                Label {
                    Text("Rewards", comment: "Smoothie rewards tab title")
                } icon: {
                    Image(systemName: "seal.fill")
                }
            }
            
            NavigationView {
                
            }
            .tabItem {
                Label {
                    Text("Recepes", comment: "Smoothie recepes tab title")
                } icon: {
                    Image(systemName: "book.closed.fill")
                }
            }
        }
    }
}

struct AppTabNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppTabNavigation()
    }
}

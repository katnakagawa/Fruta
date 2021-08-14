//
//  Smoothie+SwiftUI.swift
//  Smoothie+SwiftUI
//
//  Created by Katsuya Nakagawa on 2021/08/14.
//

import SwiftUI

// MARK: - SwiftUI.Image
extension Smoothie {
    var image: Image {
        Image("smoothie/\(id)", label: Text(title))
            .renderingMode(.original)
    }
}

//
//  ItemModel.swift
//  Dronete
//
//  Created by Daniel Cazorro Frías on 29/4/24.
//

import Foundation

struct Item: Equatable {
    let imageName, title: String

    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.imageName == rhs.imageName && lhs.title == rhs.title
    }
}

//
//  LinkItem.swift
//  ExersareLinks
//
//  Created by Nicolae Lefter on 06.03.2024.
//

import Foundation

struct LinkItem: Identifiable {
    let id = UUID()
    let title: String
    let url: String
}

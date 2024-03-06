//
//  LinkStore.swift
//  ExersareLinks
//
//  Created by Nicolae Lefter on 06.03.2024.
//

import Foundation


class LinkStore: ObservableObject {
    @Published var links: [LinkItem] = []
    
    
    func addLink(title: String, url: String) {
        let newLink = LinkItem(title: title, url: url)
        links.append(newLink)
    }
    
    func removeLink(at index: Int) {
        links.remove(at: index)
    }
}

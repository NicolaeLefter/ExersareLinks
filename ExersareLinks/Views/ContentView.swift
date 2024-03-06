//
//  ContentView.swift
//  ExersareLinks
//
//  Created by Nicolae Lefter on 06.03.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var searchText = ""
    @State private var newLinkTitle = ""
    @State private var newLinkURL = ""
    @ObservedObject private var linkStore = LinkStore()
    
    var filteredLinks: [LinkItem] {
        if searchText.isEmpty {
            return linkStore.links
        } else {
            return linkStore.links.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    var body: some View {
            NavigationView {
                VStack {
                    TextField("Search", text: $searchText)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    List {
                        ForEach(filteredLinks) { link in
                            Button(action: {
                                if let url = URL(string: link.url) {
                                    UIApplication.shared.open(url)
                                }
                            }) {
                                HStack {
                                    Image(systemName: "link")
                                    Text(link.title)
                                }
                            }
                            .contextMenu {
                                Button(action: {
                                    if let index = linkStore.links.firstIndex(where: { $0.id == link.id }) {
                                        linkStore.removeLink(at: index)
                                    }
                                }) {
                                    Text("Remove")
                                    Image(systemName: "trash")
                                }
                            }
                        }
                    }

                    HStack {
                        TextField("Title", text: $newLinkTitle)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("URL", text: $newLinkURL)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(action: addLink) {
                            Text("Add")
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                        }
                    }
                    .padding()
                }
                .navigationBarTitle("Quick Links")
            }
        }

        func addLink() {
            guard !newLinkTitle.isEmpty && !newLinkURL.isEmpty else { return }
            linkStore.addLink(title: newLinkTitle, url: newLinkURL)
            newLinkTitle = ""
            newLinkURL = ""
        }
    }

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

//
//  SettingsView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI
import ModalView

struct SearchView: View {
    @EnvironmentObject var fireback: FireBackend
    @ObservedObject var searchBar = SearchBar()
    
    var terms = GlossaryDatabase.getAllWords().sorted()
    
    @State var firesList = [ForestFire]()
    @State var wordsList = [Term]()
    
    @State var showFires = true
    @State var showWords = true
    
    private func getFires() {
        if !showFires {
            firesList = [ForestFire]()
            return
        }
        
        DispatchQueue.main.async {
            self.firesList = self.fireback.fires.filter {
                searchBar.text.isEmpty ||
                $0.name.contains(searchBar.text)
            }.sorted(by: {$0.name < $1.name})
        }
    }
    
    private func getWords() {
        if !showWords {
            wordsList = [Term]()
            return
        }
        
        DispatchQueue.main.async {
            self.wordsList = self.terms.filter {
                searchBar.text.isEmpty ||
                $0.id.contains(searchBar.text)
            }.sorted()
        }
    }
    
    /// No environment variable needed (directly contact App Defaults)
    var body: some View {
        ModalPresenter {
            NavigationView {
                Form {
                    DisclosureGroup(
                        isExpanded: $showFires,
                        content: {
                            ForEach(firesList) { fire in
                                NavigationLink(destination: MapView(fireData: fire)) {
                                    Text(fire.name)
                                        .font(.headline)
                                        .fontWeight(.regular)
                                        .foregroundColor(.secondary)
                                }
                            }},
                        label: { HStack {
                            Text("Forest Fires").font(.headline)
                            Spacer()
                            if !showFires {
                                Text("\(firesList.count)")
                                    .scaleEffect(showFires ? 0 : 1)
                                    .transition(.move(edge: .bottom))
                                    .animation(.spring())
                            }
                        }}
                    )
                    DisclosureGroup(
                        isExpanded: $showWords,
                        content: {
                            ForEach(wordsList) { word in
                                NavigationLink(destination: Header(title: word.id, desc: word.definition)
                                        .navigationBarTitle("Term", displayMode: .inline)
                                ) {
                                    Text(word.id)
                                        .font(.headline)
                                        .fontWeight(.regular)
                                        .foregroundColor(.secondary)
                                }
                            }
                        },
                        label: { HStack {
                            Text("Terms and Definitions").font(.headline)
                            Spacer()
                            if !showWords {
                                Text("\(wordsList.count)")
                                    .scaleEffect(showWords ? 0 : 1)
                                    .transition(.move(edge: .bottom))
                                    .animation(.spring())
                            }
                        }}
                    )
                    
                    NavigationLink(destination: CreditsView()) {
                        Text("Credits").font(.headline)
                    }
                }
                    .navigationBarTitle("Search")
                    .add(self.searchBar)
            }
                .onChange(of: searchBar.text, perform: { value in
                    getFires()
                    getWords()
                })
                .onAppear {
                    getFires()
                    getWords()
                }
        }
    }
}

class SearchBar: NSObject, ObservableObject {
    
    @Published var text: String = ""
    let searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    override init() {
        super.init()
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchResultsUpdater = self
    }
}

extension SearchBar: UISearchResultsUpdating {
   
    func updateSearchResults(for searchController: UISearchController) {
        
        // Publish search bar text changes.
        if let searchBarText = searchController.searchBar.text {
            self.text = searchBarText
        }
    }
}

struct SearchBarModifier: ViewModifier {
    
    let searchBar: SearchBar
    
    func body(content: Content) -> some View {
        content
            .overlay(
                ViewControllerResolver { viewController in
                    viewController.navigationItem.searchController = self.searchBar.searchController
                }
                    .frame(width: 0, height: 0)
            )
    }
}

extension View {
    
    func add(_ searchBar: SearchBar) -> some View {
        return self.modifier(SearchBarModifier(searchBar: searchBar))
    }
}

final class ViewControllerResolver: UIViewControllerRepresentable {
    
    let onResolve: (UIViewController) -> Void
        
    init(onResolve: @escaping (UIViewController) -> Void) {
        self.onResolve = onResolve
    }
    
    func makeUIViewController(context: Context) -> ParentResolverViewController {
        ParentResolverViewController(onResolve: onResolve)
    }
    
    func updateUIViewController(_ uiViewController: ParentResolverViewController, context: Context) { }
}

class ParentResolverViewController: UIViewController {
    
    let onResolve: (UIViewController) -> Void
    
    init(onResolve: @escaping (UIViewController) -> Void) {
        self.onResolve = onResolve
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use init(onResolve:) to instantiate ParentResolverViewController.")
    }
        
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        
        if let parent = parent {
            onResolve(parent)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(FireBackend())
    }
}

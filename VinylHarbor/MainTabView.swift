import SwiftUI

struct MainTabView: View {
    @State private var selectedIndex = 0
    @State private var isAddingNewItem = false
    @StateObject var filterOptions = FilterOptions()
    
    
    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor.black // Change UIColor to your desired color
        UITabBar.appearance().standardAppearance = tabBarAppearance
    }

    var body: some View {
        TabView(selection: $selectedIndex) {
            SearchView(filterOptions: filterOptions)
                .onTapGesture {
                    self.selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .tag(0)

            NewItemView(isAddingNewItem: $isAddingNewItem) {
                self.selectedIndex = 0 // Change to the desired index after adding an item
            }
            .tabItem {
                Image(systemName: "plus.diamond.fill")
            }
            .tag(1)
            .onAppear {
                if isAddingNewItem {
                    selectedIndex = 1 // Show the NewItemView tab if isAddingNewItem is true
                }
            }
            ProfileView()
                .onTapGesture {
                    self.selectedIndex = 2
                }
                .tabItem {
                    Image(systemName: "person.crop.circle")
                }
                .tag(2)
        }
        .accentColor(.purple)
    }
}

// Usage in the Preview
struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

//
//  ContentView.swift
//  Portfolio
//
//  Created by Rob Copping on 04/01/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            ProjectsView(showClosedProjects: false)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Open Projects")
                }
            ProjectsView(showClosedProjects: true)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Closed Projects")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var dataController = DataController.preview
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}

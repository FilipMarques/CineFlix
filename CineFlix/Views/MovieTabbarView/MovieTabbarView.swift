//
//  MovieTabbarView.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 15/08/23.
//

import SwiftUI

struct MovieTabbarView: View {
    var body: some View {
        TabView {
            MovieListView()
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Aba 1")
                }

            Text("Segunda Aba")
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Aba 2")
                }

            Text("Terceira Aba")
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("Aba 3")
                }
            Text("Quarta Aba")
                .tabItem {
                    Image(systemName: "4.circle")
                    Text("Aba 4")
                }
        }
    }
}

struct MovieTabbarView_Previews: PreviewProvider {
    static var previews: some View {
        MovieTabbarView()
    }
}

//
//  DetailView.swift
//  MyAPIApp
//
//  Created by Will on 5/6/25.
//

import SwiftUI

// Detail View for individual item information
struct DetailView: View {
    var result: BreedDetailView
    
    var body: some View {
        VStack {
            Text(result.breed)
            
        }
        .navigationTitle(result.breed)
    }
}




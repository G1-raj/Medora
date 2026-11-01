//
//  SearchField.swift
//  Medora
//
//  Created by Govine Rajput on 01/11/26.
//

import SwiftUI

struct SearchField: View {
    
    @State private var searchText: String = ""
    
    var body: some View {
        HStack(spacing: 6) {
            
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.gray)
            
            TextField("Search medications...", text: $searchText)
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 45)
        .padding(.horizontal, 12)
        .background(.sub)
        .clipShape(
            RoundedRectangle(cornerRadius: 29)
        )
    }
}

#Preview {
    SearchField()
        .padding(.horizontal, 20)
}

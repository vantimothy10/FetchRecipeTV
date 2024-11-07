//
//  FilterChipView.swift
//  FetchRecipeTV
//
//  Created by Timothy Van on 10/25/24.
//

import SwiftUI

struct FilterChipContainerView: View {
    @Binding var selectedItem: String?
    var items: [String]
    
    var body: some View {
        
        ScrollView(.horizontal) {
            HStack {
                ForEach(Array(items.enumerated()), id: \.offset) { (index, element) in
                    FilterChipView(selected: selectedItem == element, text: element)
                        .onTapGesture {
                            withAnimation {
                                guard selectedItem != element else {
                                    selectedItem = nil
                                    return
                                }
                                selectedItem = element
                            }
                        }
                }
            }
            .padding(.horizontal)
        }
        .scrollBounceBehavior(.basedOnSize)
        .scrollIndicators(.hidden)
    }
}

struct FilterChipView: View {
    var selected: Bool = false
    var text: String
    
    var body: some View {
        Text(text)
            .foregroundStyle(selected ? .white : Color(.systemBlue))
            .padding()
            .background(
                Capsule()
                    .fill(selected ? Color(.systemBlue) : Color(.systemGray6))
                    .stroke(Color(.systemBlue), lineWidth: 1)
                    .frame(height: 30)
            )
    }
}

#Preview {
    FilterChipContainerPreviewHelper()
}

struct FilterChipContainerPreviewHelper: View {
    @State var selectedFilter: String?
    var items = ["Apple", "Banana", "Orange", "Kiwis"]
    
    var body: some View {
        VStack {
            Text("Selected:  \(String(describing: selectedFilter))")
            FilterChipContainerView(selectedItem: $selectedFilter, items: items)
        }
        
    }
}

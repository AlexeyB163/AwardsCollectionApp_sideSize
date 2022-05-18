//
//  CustomGridView.swift
//  AwardsCollectionApp
//
//  Created by brubru on 07.03.2022.
//

import SwiftUI

struct CustomGridView<Content, T>: View where Content: View  {
    
    let items: [T]
    let columns: Int
    //замыкание захватывает Int и возвращает View, т.е Content
    let content: (CGFloat, T) -> Content
    var rows: Int {
        items.count / columns
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            let sideSize =  geometry.size.width / CGFloat(columns)
            
            ScrollView {
                VStack {
                    // определим id идентификатор
                    ForEach(0...rows, id: \.self) { rowIndex in
                        HStack {
                            ForEach(0..<columns) {columnIndex in
                                if let index = indexFor(row: rowIndex, column: columnIndex) {
                                    // отображаем content
                                    content(sideSize, items[index])
                                } else {
                                    Spacer()
                                }
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func indexFor(row: Int, column: Int) -> Int? {
        let index = row * columns + column
        return index < items.count ? index : nil
    }
    
}

struct CustomGridView_Previews: PreviewProvider {
    static var previews: some View {
        CustomGridView(items: [1,4,33,65,342,54,2], columns: 3) { sideSize, item in
            Text("\(item  )")
                .frame(width: sideSize, height: sideSize)
        }
        
    }
}

//
//  NumberBox.swift
//  Dashboard
//
//  Created by User on 04.06.2024.
//

import SwiftUI

struct NumberBox: View {
    @ObservedObject private var themeManager = SaveManager.shared.theme()
    var number: Double
    var head: String
    var metric: String
    var body: some View {
        VStack{
            Text(String(head))
                .font(.system(size: 25))
            Spacer()
            HStack{
                Text(String(number))
                    .font(.system(size: 30))
                
                Text(" " + String(metric))
                    .font(.system(size: 30))
            }
            Spacer()
        }
        .autocapitalization(.none)
        .padding()
        .frame(
            width: 175,
            height: 175
        )
        .background(
            RoundedRectangle(
                cornerRadius: 20,
                style: .continuous
            )
            .fill(themeManager.currentScheme.primary)
        )
        .foregroundColor(themeManager.currentScheme.text)
        .overlay(RoundedRectangle(cornerRadius: 20)
            .stroke(themeManager.currentScheme.secondary, lineWidth: 2))
        .padding(10)
        
    }
}

#Preview {
    NumberBox(
        number: 20.2,
        head: "Temp",
        metric: "C"
    )
}

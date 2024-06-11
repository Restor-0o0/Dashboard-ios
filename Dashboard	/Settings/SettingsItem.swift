//
//  SettingsItem.swift
//  Dashboard
//
//  Created by User on 10.06.2024.
//

import SwiftUI

struct iOSCheckboxToggleStyle: ToggleStyle{
    func makeBody(configuration: Configuration) -> some View{
        Button(action: {
            configuration.isOn.toggle()
        }, label:{
            HStack{
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                configuration.label
            }
        }
        )
    }
}

func +<Key, Value> (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
    var result = lhs
    rhs.forEach{ result[$0] = $1 }
    return result
}

struct settingsItem: View {
    @ObservedObject private var themeManager = SaveManager.shared.theme()
    
    @Binding var SettItem: SettingsItem
    let drawingList: [String:String]
    let countList: [String:String]
    @State private var selectedDrawing: String = ""
    @State private var selectedCount: String = ""
    @State private var countValsStr: String = ""
    @State private var priorityStr: String = ""
    @State private var active: Bool = true
    
    @State private var isExpanded: Bool = false

    @ObservedObject private var DataManager = RESTSettingsManager()
    var body: some View {
      
        DisclosureGroup(SettItem.name, isExpanded: $isExpanded) {
            VStack {
                HStack{
                    Text("Группировка")
                        .padding()
                        .foregroundColor(themeManager.currentScheme.text)
                        .font(.system(size: 20))
                    
                    Picker("", selection: $selectedCount) {
                        ForEach(1..<(countList.count/2)+1) { option in
                            Text("\(countList[String(option)] ?? "")")
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 50,
                                        style: .continuous
                                    )
                                    .fill(themeManager.currentScheme.primary)
                                )
                                .foregroundColor(themeManager.currentScheme.text)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke(themeManager.currentScheme.secondary, lineWidth: 2)
                                )
                            
                                .tag(countList[String(option)] ?? "")
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 50,
                                        style: .continuous
                                    )
                                    .fill(themeManager.currentScheme.primary)
                                )
                                .foregroundColor(themeManager.currentScheme.text)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke(themeManager.currentScheme.secondary, lineWidth: 2)
                                )
                            
                        }
                    }
                    .accentColor(themeManager.currentScheme.text)
                    //.pickerStyle(PalettePickerStyle()) // Можно изменить стиль Picker
                    .padding()
                    .onChange(of: selectedCount) {oldValue, newValue in
                        SettItem.typeCount = Int(countList[newValue] ?? "1") ?? 1
                        print("Выбрано число: \(String(describing: Int(countList[newValue] ?? "")))")
                    }
                    .onAppear(){
                        selectedCount = (countList[String(SettItem.typeCount)] ?? "")
                        print(drawingList)
                        print(countList)
                    }
                    
                    
                }
                .frame(
                    width:350
                )
                .background(
                    RoundedRectangle(
                        cornerRadius: 50,
                        style: .continuous
                    )
                    .fill(themeManager.currentScheme.primary)
                )
                .foregroundColor(themeManager.currentScheme.text)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(themeManager.currentScheme.secondary, lineWidth: 2)
                )
                
                
                //___________________________________________________
                HStack{
                    Text("Количество")
                        .padding()
                        .foregroundColor(themeManager.currentScheme.text)
                        .font(.system(size: 20))
                    TextField("",
                              text: $countValsStr
                    )
                    .onAppear(){
                        countValsStr = String(SettItem.countVals)
                        
                    }
                    .onChange(of: countValsStr) {oldValue, newValue in
                        countValsStr = newValue
                        SettItem.countVals = Int(newValue) ?? 1
                    }
                    //.keyboardType(.numberPad)
                    //.autocapitalization(.none)
                    .padding()
                    //.frame(width: 350)
                    .background(
                        RoundedRectangle(
                            cornerRadius: 10,
                            style: .continuous
                        )
                        .fill(themeManager.currentScheme.background)
                    )
                    .foregroundColor(themeManager.currentScheme.text)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(themeManager.currentScheme.primary, lineWidth: 2))
                }
                .background(
                    RoundedRectangle(
                        cornerRadius: 50,
                        style: .continuous
                    )
                    .fill(themeManager.currentScheme.primary)
                )
                .foregroundColor(themeManager.currentScheme.text)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(themeManager.currentScheme.secondary, lineWidth: 2)
                )
                .frame(
                    width:350
                )
                //___________________________________________________
                HStack{
                    Text("Приоритет")
                        .padding()
                        .foregroundColor(themeManager.currentScheme.text)
                        .font(.system(size: 20))
                    TextField("",
                              text: $priorityStr
                    )
                    .onAppear(){
                        priorityStr = String(SettItem.priority)
                    }
                    .onChange(of: priorityStr) {oldValue, newValue in
                        priorityStr = newValue
                        SettItem.priority = Int(newValue) ?? 1
                    }
                    //.keyboardType(.numberPad)
                    //.autocapitalization(.none)
                    .padding()
                    //.frame(width: 350)
                    .background(
                        RoundedRectangle(
                            cornerRadius: 10,
                            style: .continuous
                        )
                        .fill(themeManager.currentScheme.background)
                    )
                    .foregroundColor(themeManager.currentScheme.text)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(themeManager.currentScheme.primary, lineWidth: 2))
                }
                .background(
                    RoundedRectangle(
                        cornerRadius: 50,
                        style: .continuous
                    )
                    .fill(themeManager.currentScheme.primary)
                )
                .foregroundColor(themeManager.currentScheme.text)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(themeManager.currentScheme.secondary, lineWidth: 2)
                )
                .frame(
                    width:350
                )
                //___________________________________________________
                
                
                HStack{
                    Text("Тип отображения")
                        .padding()
                        .foregroundColor(themeManager.currentScheme.text)
                        .font(.system(size: 20))
                    
                    Picker("", selection: $selectedDrawing) {
                        ForEach(1..<(drawingList.count/2)+1) { option in
                            Text("\(drawingList[String(option)] ?? "")")
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 50,
                                        style: .continuous
                                    )
                                    .fill(themeManager.currentScheme.primary)
                                )
                                .foregroundColor(themeManager.currentScheme.text)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke(themeManager.currentScheme.secondary, lineWidth: 2)
                                )
                            
                                .tag(drawingList[String(option)] ?? "")
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 50,
                                        style: .continuous
                                    )
                                    .fill(themeManager.currentScheme.primary)
                                )
                                .foregroundColor(themeManager.currentScheme.text)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke(themeManager.currentScheme.secondary, lineWidth: 2)
                                )
                            
                        }
                    }
                    .accentColor(themeManager.currentScheme.text)
                    //.pickerStyle(PalettePickerStyle()) // Можно изменить стиль Picker
                    .padding()
                    .onChange(of: selectedDrawing) {oldValue, newValue in
                        SettItem.drawingType = Int(drawingList[newValue] ?? "1") ?? 1
                        print("Выбрано число: \(String(describing: Int(drawingList[newValue] ?? "")))")
                    }
                    .onAppear(){
                        selectedDrawing = (drawingList[String(SettItem.drawingType)] ?? "")
                        print(drawingList)
                        print(countList)
                    }
                    
                    
                }
                .frame(
                    width:350
                )
                .background(
                    RoundedRectangle(
                        cornerRadius: 50,
                        style: .continuous
                    )
                    .fill(themeManager.currentScheme.primary)
                )
                .foregroundColor(themeManager.currentScheme.text)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(themeManager.currentScheme.secondary, lineWidth: 2)
                )
                
                /*__________________________________________*/
                HStack{
                    Text("Активно")
                        .padding()
                        .foregroundColor(themeManager.currentScheme.text)
                        .font(.system(size: 20))
                    Toggle(isOn: $active){
                        	
                    }
                    .onChange(of: active) {oldValue, newValue in
                        active = newValue
                        SettItem.active = newValue
                    }
                    .toggleStyle(iOSCheckboxToggleStyle())
                    .background(
                        RoundedRectangle(
                            cornerRadius: 50,
                            style: .continuous
                        )
                        .fill(themeManager.currentScheme.primary)
                    )
                    .foregroundColor(themeManager.currentScheme.text)
                }
                .onTapGesture(){
                    active.toggle()
                    SettItem.active = active
                }
                .onAppear(){
                    active = SettItem.active
                }
                .padding()
                .frame(
                    width:350
                )
                .background(
                    RoundedRectangle(
                        cornerRadius: 50,
                        style: .continuous
                    )
                    .fill(themeManager.currentScheme.primary)
                )
                .foregroundColor(themeManager.currentScheme.text)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(themeManager.currentScheme.secondary, lineWidth: 2)
                )
                /*__________________________________________*/
            }
        }
            
            .padding()
            .background(
                RoundedRectangle(
                    cornerRadius: 50,
                    style: .continuous
                )
                .fill(themeManager.currentScheme.primary)
            )
            .foregroundColor(themeManager.currentScheme.text)
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(themeManager.currentScheme.secondary, lineWidth: 2)
            )
            
            .font(.system(size: 20))
        
                    
    }
}
/*
#Preview {
    settingsItem()
}
*/

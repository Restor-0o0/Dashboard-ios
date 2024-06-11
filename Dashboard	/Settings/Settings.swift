//
//  Settings.swift
//  Dashboard
//
//  Created by User on 10.06.2024.
//

import SwiftUI

struct Settings: View {
    
    @ObservedObject private var themeManager = SaveManager.shared.theme()
    @ObservedObject private var DataManager = RESTSettingsManager()
    @State private var drawingList: [String:String] = [:]
    @State private var countList: [String:String] = [:]
    @State private var goToMain: Bool = false
    @State private var exit: Bool = false
    @State private var isExpanded: Bool = false
    @State var butt: String = (SaveManager.shared.get(key: "theme") == "light") ? "☀" : "☾"
    var body: some View {
        NavigationView {
        VStack{
            HStack{
                Button(action:{
                    goToMain.toggle()
                }){
                    //Image("menu")
                    Label(
                        title: {  },
                        icon: { Image(systemName: "xmark") }
                    )
                    .font(.system(size: 35))
                }
                .padding()
                .frame(width: 50)
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
                
                Spacer()
                
                Button(butt) {
                    themeManager.toggleTheme()
                    if themeManager.currentScheme == .light {
                        butt = "☀"
                        SaveManager.shared.save(key: "theme", value: "light")
                    } else {
                        butt = "☾"
                        SaveManager.shared.save(key: "theme", value: "dark")
                    }
                }
                .font(.system(size: 20))
                .padding()
                .frame(width: 50)
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
                
                
                
                Spacer()
                
                Button(action:{
                    DataManager.sendSettings(settingsItems:DataManager.SettingsData)
                    { success in
                        if success{
                            goToMain.toggle()
                        }
                        
                    }
                    
                }){
                    //Image("menu")
                    Label(
                        title: {  },
                        icon: { Image(systemName: "checkmark") }
                    )
                    .font(.system(size: 35))
                }
                .padding()
                .frame(width: 50)
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
            HStack{
                Spacer()
                //Spacer()
            }
            .frame(height:5)
            .background(themeManager.currentScheme.secondary)
            .padding(.leading,0)
            ScrollView(.vertical) {
                DisclosureGroup("Отображение", isExpanded: $isExpanded) {
                    VStack{
                        
                        ForEach(0..<DataManager.SettingsData.count, id: \.self){ index in
                            settingsItem(
                                SettItem: $DataManager.SettingsData[index],
                                drawingList: DataManager.drawingList,
                                countList: DataManager.countList
                            )
                            
                        }
                        Spacer()
                    }
                    .onAppear(){
                        
                        DataManager.getSettingsData(){ success in
                            if success {
                                
                            }}
                        DataManager.getCountData(){ success in
                            if success {
                                /*
                                 print((DataManager.CountData.reduce(into: [String: String]()) { dictionary, Item in
                                 dictionary[String(Item.id)] = Item.name}) +
                                 self.DataManager.CountData.reduce(into: [String: String]()) { dictionary, Item in
                                 dictionary[Item.name] = String(Item.id)})*/
                            }}
                        DataManager.getDrawingData(){ success in
                            if success {
                                /*print((DataManager.DrawingData.reduce(into: [String: String]()) { dictionary, Item in
                                 dictionary[String(Item.id)] = Item.name}) +
                                 self.DataManager.DrawingData.reduce(into: [String: String]()) { dictionary, Item in
                                 dictionary[Item.name] = String(Item.id)})
                                 */
                            }}
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
                
                Button(action:{
                    SaveManager.shared.delete(key: "token")
                    exit.toggle()
                }){
                    //Image("menu") //
                    Text("Выход")
                        .padding()
                        .foregroundColor(themeManager.currentScheme.text)
                        .font(.system(size: 20))
                }
                .padding()
                .frame(width: 200)
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
                
            
                
                
                
                
                
                //print(drawingList)
                //print(countList)
                
                
                
            }
            .refreshable {
                DataManager.getSettingsData(){ success in
                    if success {
                        
                    }}
                DataManager.getCountData(){ success in
                    if success {
                        
                    }}
                DataManager.getDrawingData(){ success in
                    if success {
                        
                    }}
            }
            
            
            
        }
        
        .background(themeManager.currentScheme.background)
        }
        .fullScreenCover(isPresented: $goToMain) {
            Dashboard.MainScrin()
                }
        .fullScreenCover(isPresented: $exit) {
            Dashboard.LoginView()
                    }
        .background(themeManager.currentScheme.background)
    }
}
/*
#Preview {
    Settings()
}*/

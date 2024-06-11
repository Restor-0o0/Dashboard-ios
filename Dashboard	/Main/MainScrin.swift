//
//  main.swift
//  Dashboard
//
//  Created by User on 04.06.2024.
//

import SwiftUI

struct MainScrin: View {
    @ObservedObject private var themeManager = SaveManager.shared.theme()
    @ObservedObject private var DataManager = RESTDataManager()
    @State private var isChange: Bool = false
    @State var isLoading: Bool = true
    
    @State var butt: String = (SaveManager.shared.get(key: "theme") == "light") ? "☀" : "☾"
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    Button(action:{
                        isChange.toggle()
                    }){
                        //Image("menu")
                        Label(
                            title: {  },
                            icon: { Image(systemName: "line.3.horizontal") }
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
                    Text(DataManager.Data.login)
                        .padding()
                        .foregroundColor(themeManager.currentScheme.text)
                        .font(.system(size: 30))
                    /*Button(butt) {
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
                    )*/
                }
                HStack{
                    Spacer()
                    //Spacer()
                }
                .frame(height:5)
                .background(themeManager.currentScheme.secondary)
                .padding(.leading,0)
                
                
                    ScrollView(.vertical) {
                        
                        if(DataManager.Error != ""){
                            Spacer()
                            Text(DataManager.Error)
                                .font(.system(size: 25))
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 20,
                                        style: .continuous
                                    )
                                    .fill(themeManager.currentScheme.background)
                                )
                                .foregroundColor(themeManager.currentScheme.text)
                            Spacer()
                        }
                        else{
                            VStack{
                                ForEach(0..<DataManager.Data.numNumbs, id: \.self){ index in
                                    if index % 2 != 0 {}
                                    else{
                                        HStack{
                                            if index+1 < DataManager.Data.numNumbs{
                                                NumberBox(
                                                    number: DataManager.Data.numbs[index],
                                                    head: DataManager.Data.headNumb[index],
                                                    metric: DataManager.Data.metrics[index]
                                                )
                                                NumberBox(
                                                    number: DataManager.Data.numbs[index + 1],
                                                    head: DataManager.Data.headNumb[index + 1],
                                                    metric: DataManager.Data.metrics[index + 1]
                                                )
                                            }
                                            else{
                                                NumberBox(
                                                    number: DataManager.Data.numbs[index],
                                                    head: DataManager.Data.headNumb[index],
                                                    metric: DataManager.Data.metrics[index]
                                                )
                                            }
                                            
                                            
                                        }
                                        
                                        
                                    }
                                    
                                    
                                }
                                ForEach(0..<DataManager.Data.numGraphs, id: \.self){ index in
                                    LineBox(
                                        head: DataManager.Data.head[index],
                                        data: DataManager.Data.graph[index],
                                        label: DataManager.Data.labels[index]
                                    )
                                }
                                /*
                                 NumberBox(
                                 number: 20.2,
                                 head: "Temp",
                                 metric: "C"
                                 )
                                 NumberBox(
                                 number: 20.2,
                                 head: "Temp",
                                 metric: "C"
                                 )*/
                            }
                        }
                        /*LineBox()
                         LineBox()
                         LineBox()*/
                        Spacer()
                    }
                    .refreshable {
                        isLoading = true
                        DataManager.getData(){ success in
                            if(success){
                                isLoading = false
                            }
                            
                            
                        }
                    }
                
                
            }
            .background(themeManager.currentScheme.background)
            .onAppear(){
                DataManager.getData()
                { success in
                    if(success){
                        isLoading = false
                    }
                }
            }
            //.frame(maxHeight: .infinity)
            
            //.edgesIgnoringSafeArea(.all)
            //        .ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $isChange) {
            Dashboard.Settings()
                }
    }
}

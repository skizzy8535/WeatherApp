//
//  ContentView.swift
//  WeatherApp
//
//  Created by 林祐辰 on 2022/5/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    @StateObject var forecastVM :ForecastListViewModel = ForecastListViewModel()
    
    var body: some View {
          
        NavigationView{
            
            VStack{
                
                Picker(selection: $forecastVM.system,label: Text("Picker")){
                    Text("°C").tag(0)
                    Text("°F").tag(1)
                }.pickerStyle(SegmentedPickerStyle())
                
                
                HStack{
                    
                    TextField("Type City ...", text: $forecastVM.location)
                        .textFieldStyle((RoundedBorderTextFieldStyle()))
                    Button {
                        forecastVM.getWeatherInfo()
                    } label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                }
                
                List(forecastVM.forecasts,id: \.day){ (forecast) in
                    VStack(alignment: .leading){
                        Text(forecast.day)
                            .fontWeight(.bold)
                        HStack(alignment: .center){
                            WebImage(url: forecast.weatherURL)
                                .resizable()
                                .placeholder(Image(systemName: "hourglass"))
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                            
                            VStack(alignment:.leading){
                                Text(forecast.overview)
                                HStack{
                                    Text(forecast.high)
                                    Text(forecast.low)
                                }
                                HStack{
                                    Text(forecast.clouds)
                                    Text(forecast.humidity)
                                }
                                
                                Text(forecast.pop)
                            }
                        }
                    }
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                }.listStyle(PlainListStyle())
                //
            
            }
            
            .padding(.horizontal)
            .navigationTitle("Weekly Forecast")
            
        }
        
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

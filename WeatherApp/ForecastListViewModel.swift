//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by 林祐辰 on 2022/5/24.
//

import Foundation
import SwiftUI
import CoreLocation



class ForecastListViewModel:ObservableObject {
    
    @Published var forecasts:[ForecastViewModel] = []
    @Published var location:String = ""
    
    @AppStorage("system") var system:Int = 0{
        didSet{
            for i in 0 ..< forecasts.count{
                forecasts[i].system = system
            }
        }
    }
    
    func getWeatherInfo(){
    
        let apiService = APIService.shared
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(location) { placemark, error in
            
            if let lat = placemark?.first?.location?.coordinate.latitude ,
               let long = placemark?.first?.location?.coordinate.longitude {

                apiService.getJSON(linkString: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&exclude=current,minutely,hourly,alerts&appid=c337b046a4b44652d3630aec6b3908d9&lang=zh_tw") { (result:Result<ForecastModel,APIService.APIError>)  in
                    
                    switch result{
                        
                    case .success(let forecast):
                        DispatchQueue.main.async {
                            self.forecasts = forecast.daily.map{ForecastViewModel(forecast: $0, system: self.system)}
                            print(self.forecasts)
                        }
                    case .failure(let apiError):
                        switch apiError{
                        case .error(let errorString):
                            print(errorString)
                        }
                    }
                    
                }
                
            }
        }
    }
}


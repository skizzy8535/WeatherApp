//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by 林祐辰 on 2022/5/24.
//

import Foundation



struct ForecastViewModel {
    
    let forecast:ForecastModel.Daily
    var system :Int
    
    static var dateFormatter :DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM, d"
        return dateFormatter
    }
    
    
    static var numberFormatter:NumberFormatter{
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }
    
    static var percentNumberFormatter:NumberFormatter{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        return numberFormatter
    }
    
    
    
    func convert(_ temp:Double)->Double{
        let celsius = temp - 273.15
        
        if system == 0{
            return celsius
        }else{
            return celsius * 9 / 5  + 32
        }
    }
    
    var day:String{
        return ("\(Self.dateFormatter.string(from: forecast.dt))")
    }
    
    var overview:String{
        return ("\(forecast.weather[0].description)")
    }
    
    
    var high:String{
        return ("最高溫:\(Self.numberFormatter.string(for: convert(forecast.temp.max )) ?? "0") °")
    }
    
    var low:String{
        return ("最低溫:\(Self.numberFormatter.string(for: convert(forecast.temp.min)) ?? "0") °")
    }
    var clouds:String{
        return("☁️ : \(forecast.clouds) %")
    }
    
    var humidity:String{
        return ("💧 :\(forecast.humidity) %")
    }
    
    var pop:String{
        return ("💦 :\(Self.percentNumberFormatter.string(for:forecast.pop) ?? "0")")
    }
    
    var weatherURL:URL{
        let url =  URL(string: "https://openweathermap.org/img/wn/\(forecast.weather[0].icon)@2x.png")!
        return url
    }
}

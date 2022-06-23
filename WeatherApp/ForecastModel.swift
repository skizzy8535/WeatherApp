//
//  Forecast.swift
//  WeatherApp
//
//  Created by 林祐辰 on 2022/5/24.
//

import Foundation


struct ForecastModel:Codable {
    
    struct Daily:Codable{
        let dt:Date
        
        struct Temp:Codable{
            let min:Double
            let max:Double
        }
        
        let temp:Temp
        let humidity :Int
        
        struct Weather :Codable{
            let id : Int
            let description :String
            let icon : String
        }
        
        let weather:[Weather]
        let clouds:Int
        let pop:Double
    }
    
    let daily:[Daily]
}
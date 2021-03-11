//
//  DashboardServiceLayer.swift
//  Climate
//
//  Created by apple on 11/03/21.
//

import Foundation
import Alamofire

protocol DashboardServiceLayerDelegate: class {
  var cityName: String { get }
  var appId: String { get }
  
  func responseFromDashboardService(_ weatherResponse: WeatherDataModel, error: String?)
}

class DashboardServiceLayer {
  
  weak var delegate: DashboardServiceLayerDelegate?
  
  func dasboardServiceRequest(cityName: String) {
    var headers:HTTPHeaders = [:]
    var params: [String: String] = [:]
    
    headers["Content-Type"] = "application/json"
    headers["q"] = delegate?.cityName 
    headers["appid"] = "65d00499677e59496ca2f318eb68c049" //Can be stored in constant file
    
    NetworkAdaptor.request(urlStr: API.dasboard(city: cityName, appid: "65d00499677e59496ca2f318eb68c049").url(), method: .get, parameters: params, headers: headers) { [weak self] data in
      let decoder = JSONDecoder()
      do {
        let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        if data["cod"] as? String == "200" {
          
          let weatherDataRequest = try decoder.decode(WeatherDataModel.self, from: jsonData)
          self?.delegate?.responseFromDashboardService(weatherDataRequest, error: nil)
          
          print(data)
        }
      } catch {
        print(error)
      }
      
    }
    
  }
  
}

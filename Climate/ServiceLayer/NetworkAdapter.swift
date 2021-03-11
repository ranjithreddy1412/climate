//
//  NetworkAdapter.swift
//  Climate
//
//  Created by apple on 11/03/21.
//

import Foundation
import Alamofire

class NetworkAdaptor {
    
    static func request(urlStr:String, method:HTTPMethod,
                        parameters: [String:Any],
                        headers: HTTPHeaders,
                        encoding: ParameterEncoding = URLEncoding.default,
                        completionHandler:@escaping (([String: Any])->Void)) {
        do{
          let headers = headers
            let parameters = parameters
            
          let request = AF.request(try urlStr.asURL(), method: method, parameters: parameters, encoding: encoding, headers: headers)
            
            request.responseJSON { (response) in
                do {
                    if let data = response.data {
                        let json = try JSONSerialization.jsonObject(with: data,
                                                                    options: .allowFragments)
                        if let json = json as? [String:Any] {
                            completionHandler(json)
                        }
                        else {
                            completionHandler([:])
                        }
                    }
                    else {
                        completionHandler([:])
                    }
                }
                catch {
                    completionHandler([:])
                }
            }
        }
        catch{
            
        }
    }
}

class BaseServiceLayer {
    var headers:[String:String] = [:]
}

enum API {
  case dasboard(city: String, appid: String)
  
  func url() -> String {
      switch self {
      case .dasboard(let city, let appid):
        return "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(appid)"
      }
  }
}

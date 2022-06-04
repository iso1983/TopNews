//
//  ApiService.swift
//  TopNews
//
//  Created by iso karo on 9.04.2022.
//

import UIKit

class ApiService: NSObject {
    //singleton style
    static let sharedInstance = ApiService()
    var news:[News]?
    
    func fetchVideos(completion:@escaping ([News])->()) async{
    
                
               // guard let url = URL(string: "http://192.168.0.246:3000/api/news")
                let url = URL(string: "http://192.168.0.246:3000/api/news")
                do {
                        let (data, _) = try await URLSession.shared.data(from: url!)
                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                        self.news = [News]()
                        for dictionary in json as! [[String:AnyObject]]{
                            let news = News()
                            news.title = dictionary["title"] as? String
                            news.image_url = dictionary["image_url"] as? String
                            self.news?.append(news)
                        }

                    DispatchQueue.main.async { [self] in
                        completion(self.news!)
                        }
                    
                   } catch {
                       print(error.localizedDescription)
                       //TODO: Handle Error
                   }
    }
}

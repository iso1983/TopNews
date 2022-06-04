//
//  extensions.swift
//  TopNews
//
//  Created by iso karo on 28.03.2022.
//

import UIKit

extension UIColor{
    static func rgb(red:CGFloat , green:CGFloat , blue:CGFloat)->UIColor{
        return UIColor(red:red/255 ,green:green/255 , blue:blue/255,alpha:1)
    }
}


extension UIView{
    func addConstraintsWithFormat(format: String, views:UIView...){
        //create a dictionary
        var viewsDictionary = [String:UIView]()
        for(index,view) in views.enumerated(){
            let key="v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options:NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
            
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView:UIImageView{
    //urlString never changes inside the load function.  We just call this function a lot of times with many different urlString parameter values.  As long as the final time it is called and the urlString matches self.imageUrlString(we check this at the bottom), we're sure we need to load the image into the UIImageView.In VideoCell when we do "thumbNailImageView.loadImageUsingUrlString", we call this class with "thumbNailImageView" instance and at that time the imageUrlString will be set only once after that when below we make a fetch request we compare if "imageUrlString" is equal to the urlString because inside the "shared.dataTask" the urls may change since it is async
    var imageUrlString:String?
    
    func loadImageUsingUrlString(urlString:String){
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        image = nil
        //cache holds image in our case so we cast cache as uiimage, The if statement below says if the imageCache exists then we get the image from the cache and return so that we do not continue fetching the image using the shared.dataTask below ,getting the image from the cache is faster and more accurate then fetching the image over and over
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = imageFromCache
            return
        }
        
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil{
                print(error!)
                return
            }
            
            let r = response as! HTTPURLResponse
//              print(r.statusCode)
            if r.statusCode == 200{
//above we are doing an async process using shared.dataTask which runs on the background and to set an image and update the UI we need to do that in the main queue so we used this main.async below
                 DispatchQueue.main.async {
//every time we load the image on UI we will store the image in the cache for the next time so we do not have to make a get request and fetch the same image again
                     let imageToCache = UIImage(data:data!)
                     //check if imageUrlString is still equal to urlString
                     if self.imageUrlString == urlString{
                         self.image = imageToCache
                     }
                     imageCache.setObject(imageToCache as AnyObject, forKey: urlString as AnyObject)
                 }
             }else{
                 DispatchQueue.main.async {
                     self.image = UIImage(named:"noimage")
                 }
             }
        }.resume()
    }
}


extension UIWindow{
    
    static func getMainWindow()->UIWindow{
        //we need to get the main window of the app first,note viewcontroller does not include the navbar so we want to get the full window
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        //below we could also do: windowScene?.keyWindow?.rootViewController
        let window = windowScene?.windows.first
            
        return window!
        
    }
}

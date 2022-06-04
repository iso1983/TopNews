//
//  SettingsLauncher.swift
//  TopNews
//
//  Created by iso karo on 31.03.2022.
//

//this file will launch the settings screen when the 3 dots is clicked
import UIKit

class Setting:NSObject{
    let name:SettingName
    let imageName:String
    
    init(name:SettingName,imageName:String){
        self.name = name
        self.imageName = imageName
    }
}

enum SettingName:String{
    case Cancel = "Cancel"
    case WorldNews="World News"
    case Business="Business"
    case Health="Health"
    case Sports="Sports"
    
}

//If you're creating a class that doesn’t inherit from anything, then make it an NSObject subclass, as you would in OBJC ,UICollectionViewFlowLayout
class SettingsLauncher:NSObject,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    let blackView = UIView()
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame:.zero,collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    let cellId = "cellId"
    let settings:[Setting] = {
        let worldNews=Setting(name: .WorldNews, imageName: "world")
        let cancelSetting = Setting(name:.Cancel,imageName: "cancel")
        
        
        return [worldNews,Setting(name:.Business,imageName:"business"),Setting(name:.Health,imageName:"health"),Setting(name:.Sports,imageName:"sports"),cancelSetting]
    }()
    
    var homeController:ViewController?
    
    //show the settings window when the 3 dots is clicked
    func showSettings(){
        //use the extension we created to get the main window,note ,this class is inheriting NSObject so we can not directly access to the main window of the app
        let window = UIWindow.getMainWindow()
        
                //add a transparency
                blackView.backgroundColor = UIColor(white:0,alpha:0.5)
    //this will run when we click on anywhere on the screen ,it is just a gesture set and will call the handleDismiss function
                blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
                //add the blackView to the main apps window
                window.addSubview(blackView)
                window.addSubview(collectionView)
//to place the settings window which will appear when pressing on the 2 dots,we want to put it at the bottom,settings view that is another collectionview at the bottom we need to calculate the total y so we minus window.frame.heigth from the height of the settings window
                let width:CGFloat = 200
                let x = -width
                //to animate the settings window, start from the bottom so window.frame.height
        collectionView.frame = CGRect(x: x, y: 0, width: width, height: window.frame.height)
                blackView.frame = window.frame
                blackView.alpha = 0
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
                    self.blackView.alpha = 1
                    self.collectionView.frame = CGRect(x: 0, y: 0, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                } completion: { Bool in
                   
                }

            
        }
        
    @objc func handleDismiss(setting:Setting){
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
                self.blackView.alpha = 0
                self.collectionView.frame = CGRect(x: -200, y:0, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            } completion: { Bool in
               
// show navigationviewcontroller if only cancel is not pressed and the setting is not kind of tapgesture so if we click on anywhere on the background means that it is not a tapgesture so do not navigate to a new viewcontroller but if we clicked on any of the settings items then open showcontrollerforsetting
                if !setting.isKind(of: UITapGestureRecognizer.self)  && setting.name != .Cancel{
                    self.homeController?.showControllerForSetting(setting:setting)
                }
                
            }
        }
    
    //this is a UICollectionViewDataSource function
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath ) as! SettingCell
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }
    
  //this function is coming from UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:self.collectionView.frame.width ,height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = self.settings[indexPath.item]
        handleDismiss(setting:setting)
        
 
    }
    
    override init(){
        super.init()
        //the data source must adopt the UICollectionViewDataSource protocol
        collectionView.dataSource = self
//The delegate must adopt the UICollectionViewDelegate protocol that we imported. The delegate object is responsible for managing selection behavior and interactions with individual items.
        collectionView.delegate = self
        
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)

        
    }
}


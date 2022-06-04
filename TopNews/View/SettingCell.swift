//
//  SettingCell.swift
//  TopNews
//
//  Created by iso karo on 1.04.2022.
//

import UIKit

class SettingCell:BaseCell{
    
    override var isHighlighted: Bool{
        didSet{
            backgroundColor = isHighlighted ? .black : .white
            nameLabel.textColor = isHighlighted ? .white : .black
        
            
        }
    }
    
    var setting:Setting?{
        didSet{
            nameLabel.text = setting?.name.rawValue
            if let imageName = setting?.imageName{
                iconImageView.image = UIImage(named: imageName)
              
            }
            
        }
    }
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Technology"
//        label.backgroundColor = .white
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let iconImageView:UIImageView={
        let imageView = UIImageView()
        imageView.image = UIImage(named: "world")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setupViews(){
        super.setupViews()
        addSubview(nameLabel)
        addSubview(iconImageView)
//        backgroundColor = .blue
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImageView,nameLabel)
//what ever inside SettingsLauncher in sizeForItemAt we set the height to, the maximum width and height size will be that size so if in sizeForItemAt function in SettingsLauncher the height is 50 pixels and we do below V:|[v0]| this will use 50 pixels
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
     
        addConstraintsWithFormat(format: "V:[v0(30)]", views: iconImageView)
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}

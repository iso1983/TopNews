//
//  VideoCell.swift
//  TopNews
//
//  Created by iso karo on 28.03.2022.
//

import UIKit

//This class is like a super class ,We have 2 classes that use UICollectionViewCell and each time we have a class like that we need to add the init like below so what we did is created this Baseclass below and defined 2 init and then whoever wants to use the UICollectionViewCell will just need to inherit this BaseClass ,for example the VideoCell class uses this BaseClass so VideoCell class does not have to define init in itself.
class BaseCell:UICollectionViewCell{
    override init(frame:CGRect){
        super.init(frame: frame)
        //we create this custom function
        setupViews()
       
    }
    
    
    func setupViews(){
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//create our custom cells,these are the cells that are on the main screen where the news images will be.We inherit the super class called BaseCell from above therefor we do no need to use init in the class below
class VideoCell:BaseCell{
    
    var news:News?{
        //from the ViewController ,we set the news property right above via the "cellForItemAt" function we did "cell.news = " and this didSet is called
        didSet{
            titleLabel.text = news?.title
           setupThumbnailImage()
//            subtitleTextView.text = image?.full_description
            
        }
    }
    
    func setupThumbnailImage(){
        if let thumbnailImageUrl = news?.image_url{
     
            thumbNailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)
        }


    }
    
    let thumbNailImageView:CustomImageView = {
        let imageView=CustomImageView()
        imageView.backgroundColor = .white
        imageView.image = UIImage()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView:CustomImageView={
        let imageView=CustomImageView()
        imageView.backgroundColor = .black
        return imageView
    }()
    
    let seperatorView:UIView={
        let view=UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    let titleLabel:UILabel={
        let label=UILabel()
//        label.backgroundColor = .purple
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Biden calls putin butcher"
        label.numberOfLines = 3
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    


    //since we inherited the BaseCell class and the BaseCell class has the same stupViews func in it ,we need to overwrite it ,if we need to add some functionality,notuce setupViews is called in the BaseCell class so below func will be used
 override  func setupViews(){
        addSubview(thumbNailImageView)
        addSubview(seperatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
//        addSubview(subtitleTextView)
        
        
        //16 pixels from left and 16 pixels from right extend fully
        addConstraintsWithFormat(format:"H:|-16-[v0]-16-|",views:thumbNailImageView)
        
        //16 pixels from left and the X axis size is 44 pixels
        addConstraintsWithFormat(format:"H:|-16-[v0(44)]",views:userProfileImageView)
        
        
//    VERTICAL CONSTRAINTS

//below v0 stands for the thumbnailImageView and we have the seperatorView ,we add 8 pixels from the thumbnailImageView and [v1(44)] means the vertical size of the userProfileImageView and add 16 pixels from the seperatorview
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-22-[v2(1)]|", views: thumbNailImageView,userProfileImageView,seperatorView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: seperatorView)
        
        //TOP Constraint
      addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbNailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        
        //Left constraint
       addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right constraint
       addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbNailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        //height constraint
     addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 60))
        
    }
    
   
}

//
//  NewsCell.swift
//  TopNews
//
//  Created by iso karo on 17.04.2022.
//

import UIKit

//This class is used to show news for each horizontal collectionview .Each cell represents a horizontal section in the app
class NewsCell: BaseCell,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
   
    
    
//    we create a collection view
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero , collectionViewLayout: layout)
//        cv.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        cv.backgroundColor = .black
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var news:[News]?
    let cellId = "cellId"
//    var viewController:ViewController?
    
    //this function will just set the news array right above and then that news array will be used from the numberOfItemsInSection function and cellForItemAt
    func fetchNews() async{
        await ApiService.sharedInstance.fetchVideos { (news:[News]) in
            self.news = news
            self.collectionView.reloadData()
        }
     
    }
    
    override func setupViews() {
        super.setupViews()
        //Task enables us to use async/await from everywhere inside our code, e.g., in a ViewController’s viewDidLoad()
                    Task{
                         await fetchNews()
                        }
        backgroundColor = .brown
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)

        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
    }
    
//    overwrite the default method of UICollectionViewController below to define the number of views
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//news is the array that has the News model in it so it represents the Model in each cell which has some properties like title and we want to display the amount of cells exist in the news array ,news is optional so we do this below ,it is same as "if let count = news?.count{}" so returnt the count number of news array if it exists else return 0
        return  news?.count ?? 0
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell

        cell.news = news?[indexPath.item]
//         let colors:[UIColor] = [.green,.darkGray,.black,.magenta,.orange]
//         cell.backgroundColor = colors[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 9 / 16 is the aspect ratio that is implemented widely on the internet , for example 1920 / 1080 and 1280 / 720 all give us 1.7 and if you divide  16 / 9 you also get 1.7 and we have 16 pixels padding on the left and right so we find the height doing the calculation below
        let height = (frame.width - 16 - 16) * 9 / 16
        //height has 16 pixels to the top of padding and we also need to add the spacing in the vertical constraints for the other views like thumbnailImageView,userProfileImageView and seperatorView ,check out the constraint below the code and add them up
        return CGSize(width: frame.width, height: height + 16 + 88)
    }

    //get rid of the additional cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    

}

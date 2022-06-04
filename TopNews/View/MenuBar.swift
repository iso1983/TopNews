//
//  MenuBar.swift
//  TopNews
//
//  Created by iso karo on 29.03.2022.
//

import UIKit

//Note that we use the UIView protocol , that means that we do not do things like view.frame in this class because we are already inside of the "view" so we omit the "view" so UIView is the view itself

//if you want full control you need to use your own UIViewController or UIView.. and add a UICollectionView as a subview.. so you can place that collection view wherever you want and resize it.. don't forget to implement UICollectionView protocols for delegation and datasource like below.So the point is that below we have a UIView and we add a UICollectionView to this main UIView so we can change this view like we want or add other subviews outside of the UICollectionView because UICollectionView is another subview of the UIView below.
class MenuBar:UIView,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

    
    //remember lazy var will prevent this block below not to run immediately,we used lazy below because the self key is not available immediately ,self key is only available after the constructor is called therefore we kind of prevent this closure below from running in the runtime
    lazy var collectionView:UICollectionView={
        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 790, height: 50)
//        layout.invalidateLayout()
        let cv = UICollectionView(frame: .zero,collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        cv.showsHorizontalScrollIndicator = false
        layout.minimumLineSpacing = 0
//        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        cv.isScrollEnabled = false
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    let cellId = "cellId"
    let menuLabelNames = ["Top news","World news","Technology","Health","Ukraine news","Bitcoin & investments","USA news ","gamers play"]
    var viewController:ViewController?
    var menuLabelTextSizes:[Double] = []

    override init(frame:CGRect){
        super.init(frame: frame)
        backgroundColor = .green
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        //This is to hide the scroll bar that comes with uicollectionview
        collectionView.showsHorizontalScrollIndicator = false
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:[v0(50)]", views: collectionView)

        for indx in 0...menuLabelNames.count-1{
  
            let fontAttribute = [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 17)]
            let size = menuLabelNames[indx].size(withAttributes: fontAttribute)
            menuLabelTextSizes.append(size.width.rounded())
           
        }
        setupHorizontalBar()
    }
    
    var horizontalBarLeftAnchorConstraint:NSLayoutConstraint?
    var horizontalBarWidthAnchorConstraint:NSLayoutConstraint?
    var horizontalBarView:UIView?
  
    
    func setupHorizontalBar(){
      
//boundingRect calculates the estimated size for the text.We do not know how much the width for the cell size should be therefore we calculate it and add an additional 10 pixels to the calculated cell width
//        let estimatedFrame = NSString(string: str).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        //*****************************
        
        horizontalBarView = UIView()
        horizontalBarView?.backgroundColor = .orange
        horizontalBarView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView.addSubview(horizontalBarView!)
        addConstraint(NSLayoutConstraint(item: horizontalBarView!, attribute: .top, relatedBy: .equal, toItem: collectionView, attribute: .bottom, multiplier: 1, constant: 40))
        horizontalBarView?.heightAnchor.constraint(equalToConstant: 4).isActive = true
        horizontalBarWidthAnchorConstraint = horizontalBarView?.widthAnchor.constraint(equalToConstant: menuLabelTextSizes[0])
        horizontalBarWidthAnchorConstraint?.isActive = true
        horizontalBarLeftAnchorConstraint = horizontalBarView?.leftAnchor.constraint(equalTo: collectionView.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true

    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        horizontalBarWidthAnchorConstraint?.constant = menuLabelTextSizes[indexPath.item]
        calculateScroll(indexPathItem: indexPath.item,indexPath:indexPath)
        viewController?.scrollToMenuIndex(indexPath:indexPath)
        
    }
    
    
    func calculateScroll(indexPathItem:Int,indexPath:IndexPath?){
    
        if indexPathItem == 0{
            horizontalBarWidthAnchorConstraint?.constant = menuLabelTextSizes[0]
            self.horizontalBarLeftAnchorConstraint?.constant = 0
        }
        if indexPathItem == 1{
            horizontalBarWidthAnchorConstraint?.constant = menuLabelTextSizes[2]
            horizontalBarLeftAnchorConstraint?.constant = menuLabelTextSizes[0] + 10
         
        }
        if indexPathItem == 2{
            horizontalBarWidthAnchorConstraint?.constant = menuLabelTextSizes[2]
            horizontalBarLeftAnchorConstraint?.constant = (menuLabelTextSizes[0] + menuLabelTextSizes[1]) + 20
            guard let indexPath = indexPath else {
                return
            }
            collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
        }
        if indexPathItem == 3{
            horizontalBarWidthAnchorConstraint?.constant = menuLabelTextSizes[3]
            horizontalBarLeftAnchorConstraint?.constant = (menuLabelTextSizes[0] + menuLabelTextSizes[1] + menuLabelTextSizes[2] ) + 30
            guard let indexPath = indexPath else {
                return
            }
            
            collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
        }
        if indexPathItem == 4{
        horizontalBarWidthAnchorConstraint?.constant = menuLabelTextSizes[4]
          
            horizontalBarLeftAnchorConstraint?.constant =  menuLabelTextSizes[0] + menuLabelTextSizes[1] + menuLabelTextSizes[2] + menuLabelTextSizes[3] + 40
            guard let indexPath = indexPath else {
                return
            }
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        if indexPathItem == 5{
            horizontalBarWidthAnchorConstraint?.constant = menuLabelTextSizes[5]
            horizontalBarLeftAnchorConstraint?.constant =  menuLabelTextSizes[0] + menuLabelTextSizes[1] + menuLabelTextSizes[2] + menuLabelTextSizes[3] + menuLabelTextSizes[4] + 50
            guard let indexPath = indexPath else {
                return
            }
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
        if indexPathItem == 6{
            horizontalBarWidthAnchorConstraint?.constant = menuLabelTextSizes[6]
            horizontalBarLeftAnchorConstraint?.constant =  menuLabelTextSizes[0] + menuLabelTextSizes[1] + menuLabelTextSizes[2] + menuLabelTextSizes[3] + menuLabelTextSizes[4] + menuLabelTextSizes[5] + 60
            guard let indexPath = indexPath else {
                return
            }
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        if indexPathItem == 7{
            horizontalBarWidthAnchorConstraint?.constant = menuLabelTextSizes[7]
            horizontalBarLeftAnchorConstraint?.constant =  menuLabelTextSizes[0] + menuLabelTextSizes[1] + menuLabelTextSizes[2] + menuLabelTextSizes[3] + menuLabelTextSizes[4] + menuLabelTextSizes[5] + menuLabelTextSizes[6] + 70 
            guard let indexPath = indexPath else {
                return
            }
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuLabelNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //cast the cell as MenuCell below so each cell can access MenuCell properties such as menuLabel ,we then assign menuLabel to menuLabelNames array
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        cell.menuLabel.text = menuLabelNames[indexPath.item]
        cell.backgroundColor = .gray
//        cell.tintColor = .green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: menuLabelTextSizes[indexPath.item] + 10, height : 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        //we want 0 padding and no additional space in between cells
        return 0
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//BaseCell is a super class that defines UICollectionViewCell and it has the initializars in it so when we inherit the BaseCell class we do not have to define the init below and just overwrite the func setupViews so the setupViews function is called below from the BaseCell
class MenuCell:BaseCell{
    
    let menuLabel:UILabel = {
    let label=UILabel(frame: .zero)
    label.font = UIFont.systemFont(ofSize: 17)
    label.text = "Top news"
    label.textColor = .black
    return label
    }()
    
    //anytime a cell is selected ,we execute this code
    override var isHighlighted: Bool{
        didSet{
            menuLabel.textColor = isHighlighted ? .red : .black
        }
    }
    
    override var isSelected: Bool{
        didSet{

        }
    }
    
     override func setupViews() {
         //If you want to call setupViews in the BaseCell, you need to so super.setupViews()
         super.setupViews()
         backgroundColor = .yellow
         addSubview(menuLabel)
         // we have allocated 200 pixels for each menu item so the label can have 200 pixels in width.
         addConstraintsWithFormat(format: "H:[v0(200)]", views: menuLabel)
         //the height of the MenuBar is 50 pixels ,defined in ViewController via constraints and we can use 50 pixels
         addConstraintsWithFormat(format: "V:[v0(50)]", views: menuLabel)

         
     }
    
}


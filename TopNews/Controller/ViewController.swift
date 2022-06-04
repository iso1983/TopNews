//
//  ViewController.swift
//  TopNews
//
//  Created by iso karo on 28.03.2022.
//

import UIKit

//UICollectionViewController inherits from UIViewController.. and it implements some protocols.. like UICollectionViewDelegate and UICollectionViewDataSource .. it means everything is already done for you.. and you just have to use it.. but as everything is already done for you.. you may not be able to do some stuff.. like resizing your collectionView because we are already inside the CollectionView .. if you want full control I recommend you to use your own UIViewController.. and add a UICollectionView as a subview.. so you cazn place it wherever you want and resize it.. don't forget to implement UICollectionView protocols for delegation and datasource :)

//We inherit UICollectionViewController which can consist of multiple cells and UICollectionViewController has default methods that we can overwrite below so we change the behaviour of those cells like , define the number of cells and more...  UICollectionViewDelegateFlowLayout protocol allows us to set the cell sizes for the UICollectionViewController so UICollectionViewDelegateFlowLayout allows us to overwrite the method called collectionView(...sizeForItemAtIndexPath) ,it is below overwritten
class ViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
 

    
    let cellId="cellId"
    let titles = ["Top News","World News","Technology","Health","Ukraine News","Bitcoin & Investments","USA News","Gamers Play"]
    var newsCell:NewsCell?
    let topNewsCellId = "topNewsCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        collectionView.backgroundColor = .black

        navigationController?.navigationBar.isTranslucent = false
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: 40))
        titleLabel.text = "Home"
        titleLabel.textColor = .white
        titleLabel.backgroundColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
            setupCollectionView()
            setupMenuBar()
            setupNavBarButtons()
       
    }
    
    
    
    func setupCollectionView(){
        //access the layout we created in the SceneDelegate file and change the layout style to horizontal so each collectionview is horizontally placed.
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
           
        }
            
        collectionView.backgroundColor = .white
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(TopNewsCell.self, forCellWithReuseIdentifier: topNewsCellId)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        This is to push the ViewController below 50 pixels ,why? because we have the MenuBar 50 pixels right above , in between navigationbar and the viewcontroller
        
//        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        //the scrollview on the right edge gets above the main view so horizontally not on the same level so we push the scrollview down as well
//        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        //this is to scroll each horizontal cell 1 by one
        collectionView.isPagingEnabled = true
    }
    
    func setupNavBarButtons(){
        //withRenderingMode shows the image in its original color
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        navigationItem.rightBarButtonItems = [searchBarButtonItem]
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreButton,searchBarButtonItem]
    }
    
//    override var preferredContentSize: CGSize{
//        didSet{
//            collectionView.invalidateIntrinsicContentSize()
//            collectionView.setNeedsLayout()
//            collectionView.layoutIfNeeded()
//        }
//    }
    
    lazy var settingsLauncher:SettingsLauncher={
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
  
    @objc func handleMore(){
        settingsLauncher.showSettings()

    }
    
    func showControllerForSetting(setting:Setting){
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.view.backgroundColor = .white
        dummySettingsViewController.navigationItem.title = setting.name.rawValue
        //Note we already set all the tintColor to white in SceneDelegate file
        navigationController?.navigationBar.tintColor = .white
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }
    
    @objc func handleSearch(){
      
    }
    
//MenuBar below causes the MenuBar init called 2 times so we made variable below as lazy property and this will prevent the MenuBar init not to be called 2 times.Note in the init of MenuBar.swift we have  setupHorizontalBar() function call so if MenuBar init is called 2 times  setupHorizontalBar() is also called 2 times and we do not want that
    lazy var menuBar:MenuBar={
        let mb = MenuBar()
        mb.viewController = self
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
    }()
    
    let menuCell:MenuCell={
        let mc = MenuCell()
        return mc
    }()
    
    private func setupMenuBar(){
//        //this is to hide the navbar
//        navigationController?.hidesBarsOnSwipe = true

        //to fill the hidden navbar space when we hide the navbar on scroll with black color we created this blackView and placed it 50 pixels vertically why 50 pixels? because the menuBar is 50 pixels from the status bar so this blackview must be minimum 50 pixels to fill the empty space when we hide the navigation bar
//        let blackView = UIView()
//        blackView.backgroundColor = .red
//
//        view.addSubview(blackView)
//        view.addConstraintsWithFormat(format: "H:|[v0]|", views: blackView)
//        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: blackView)
//
        view.addSubview(menuBar)
        
        //for each menu bar item we will have categories like health,world news .... we want to use the full width frame  for Horizontal
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
//        Height of the menubar will be 50 pixels but we set the height in sizeForItemAt method so if you do below V:|[v0]| this will use the height that you set in sizeForItemAt function
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        
//        view.addConstraint(NSLayoutConstraint(item: menuBar, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 60))
//        menuBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 35).isActive = true
//
//        view.addConstraint(NSLayoutConstraint(item: menuBar, attribute: .bottom, relatedBy: .equal, toItem: collectionView, attribute: .top, multiplier: 1, constant: 10))
//        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        menuBar.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
//
//        view.addConstraint(NSLayoutConstraint(item: collectionView!, attribute: .top, relatedBy: .equal, toItem: menuBar, attribute: .bottom, multiplier: 1, constant: 2))
////
////
//        view.addConstraint(NSLayoutConstraint(item: menuBar, attribute: .height, relatedBy: .equal, toItem: menuBar, attribute: .height, multiplier: 0, constant: 150))
////
//        view.addConstraint(NSLayoutConstraint(item: menuBar, attribute: .bottom, relatedBy: .equal, toItem: collectionView, attribute: .top, multiplier: 1, constant: 1))
//
//        view.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: menuBar, attribute: .bottom, multiplier: 1, constant: 3))
//

        
//        view.safeAreaLayoutGuide.topAnchor is the top place where the status bar is we create automatic layout for the menuBar's top Anchor,this is useful for example if you hide the navbar so it can calcuate the top part
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
//        collectionView.topAnchor.constraint(equalTo: menuBar.bottomAnchor).isActive = true
        

        
    }
    
    
    func scrollToMenuIndex(indexPath:IndexPath){
//        collectionView.collectionViewLayout.invalidateLayout()
//        view.layoutIfNeeded()
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//        view.layoutIfNeeded()
//        collectionView.layoutIfNeeded()
//view.invalidateIntrinsicContentSize()
//collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
//collectionView.contentInset = UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)
//        collectionView.frame = CGRect(x: 0, y: 90, width: view.frame.width, height: view.frame.height - 150 )
//
//        view.layoutIfNeeded()
//        collectionView.layoutIfNeeded()
//        collectionView.collectionViewLayout.invalidateLayout()
    }
    
  
   
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        view.layoutIfNeeded()
//        collectionView.collectionViewLayout.invalidateLayout()
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
//        for cell in collectionView.visibleCells {
//              let indexPath = collectionView.indexPath(for: cell)
//                menuBar.calculateScroll(indexPathItem: Int(page), indexPath: indexPath)
//          }
        
        let indexPath = IndexPath(item: Int(page), section: 0)
        self.menuBar.calculateScroll(indexPathItem: Int(page), indexPath: indexPath)
        
        if let titleLabel = navigationItem.titleView as? UILabel{
            //using string interpolation we added 2 spaces
            titleLabel.text = "  \(titles[Int(page)])"
        }
//        collectionView.layoutIfNeeded()
//        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
//            self.view.layoutIfNeeded()
//        } completion: { Bool in
//
//        }

    }
    
    
//    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
////        guard let visible = collectionView.visibleCells.first else { return }
////        guard let page = collectionView.indexPath(for: visible)?.row else {return}
////        menuBar.calculateScroll(indexPathItem: page, indexPath: indexPath)
//
//        guard let visible = collectionView.visibleCells.first else { return }
//                    let index = Int(collectionView.contentOffset.x / collectionView.frame.size.width)
//        print(index)
//        menuBar.calculateScroll(indexPathItem: index, indexPath: indexPath)
//    }
//
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if we scroll to the second cell then show the TopNewsCell
        if indexPath.item == 1{
            return collectionView.dequeueReusableCell(withReuseIdentifier: topNewsCellId, for: indexPath)
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        let colors:[UIColor] = [.brown,.red,.orange,.green,.purple,.blue,.yellow,.red]
        cell.backgroundColor = colors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    
 
//    override func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//       if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
//          navigationController?.setNavigationBarHidden(true, animated: true)
////           collectionView.frame = CGRect(x: 0, y: -110, width: view.frame.width, height: view.frame.height)
//           menuBar.frame = CGRect(x: 0, y: 35, width: view.frame.width, height: 50)
//           collectionView.contentInset = UIEdgeInsets(top: -120, left: 0, bottom: 0, right: 0)
////           view.layoutIfNeeded()
////           collectionView.collectionViewLayout.invalidateLayout()
////           collectionView.reloadData()
//       } else {
//          navigationController?.setNavigationBarHidden(false, animated: true)
//           menuBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
////           collectionView.frame = CGRect(x: 0, y: 50, width: view.frame.width, height: view.frame.height - 150)
////           collectionView.contentInset = UIEdgeInsets(top: -25, left: 0, bottom: 0, right: 0)
//       }
////        collectionView.collectionViewLayout.invalidateLayout()
////        collectionView.reloadData()
//    }
    
//    override func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
//            navigationController?.hidesBarsOnSwipe = true
//            collectionView.frame = CGRect(x: 0, y: 47, width: view.frame.width, height: view.frame.height  )
//        }else{
//            navigationController?.hidesBarsOnSwipe = false
////            collectionView.frame = CGRect(x: 0, y: 47, width: view.frame.width, height: view.frame.height )
//        }
//    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.hidesBarsOnSwipe = true
////        menuBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
////        collectionView.contentInset = UIEdgeInsets(top: -50, left: 0, bottom:0, right: 0)
//        collectionView.frame = CGRect(x: 0, y: 47, width: view.frame.width, height: view.frame.height )
//      }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.hidesBarsOnSwipe = false
////            menuBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
////        collectionView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom:0, right: 0)
//        
//        
////        collectionView.frame = CGRect(x: 0, y: -47, width: view.frame.width, height: view.frame.height )
//      }
    
    
    override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()

//         hidingNavBarManager?.viewDidLayoutSubviews()
     }
    
    
    //we have to override this function to support portrait and landscape mode correctly.
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    

    
}




//if you want to open a new viewcontroller
class SecondVC:UIViewController{
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .yellow
        navigationItem.title = "Scomn"
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor.green
        
        
    }
}



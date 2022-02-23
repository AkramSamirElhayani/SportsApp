//
//  SportViewController.swift
//  SportsApp
//
//  Created by Akram Elhayani on 23/02/2022.
//

import UIKit

class SportViewController: UIViewController , UICollectionViewDelegateFlowLayout ,
                           UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NetworkHelper.Sports.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SportCollectionViewCell;
        
        let sport = NetworkHelper.Sports[indexPath.row];
        cell.titleLable.text = sport.strSport;
        
        cell.thumbImageView.sd_setImage(with: URL(string:sport.strSportThumb), completed: nil);
        
        
        cell.backView.dropShadow = true;
      //  cell.titleLable.cornerRadius = 0;
       cell.thumbImageView.cornerRadius = 3;
        return cell
        
    }
    
    
    private let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkHelper.loadData(self.collectionView);
        
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = refreshControl // iOS 10+
        
    }
    
    @objc
    private func didPullToRefresh(_ sender: Any) {
        // Do you your api calls in here, and then asynchronously remember to stop the
        // refreshing when you've got a result (either positive or negative)\
        NetworkHelper.loadData(self.collectionView);
        refreshControl.endRefreshing()
    }
    
    
    
    @IBAction func reloadClicked(_ sender: Any) {
        NetworkHelper.loadData(self.collectionView);
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width =  self.collectionView.frame.width / 2 ;
        var height =    150;
        
        if width > 1100 {
            width = width / 4.0
        }else if width > 500 {
            width = width / 3.0
        }
        if self.collectionView.frame.height > 900 {
            height = height * (Int(self.collectionView.frame.height) / 800 )
        }
        return CGSize(width: Int(width)-8 ,height: height )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let view : LeaguesViewController = self.storyboard!.instantiateViewController(withIdentifier: "LeaguesView") as! LeaguesViewController
        //  view.movie = NetworkHelper.dataSource[indexPath.row];
        self.present(view, animated: true, completion: nil);
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.contentView.alpha = 0.0
        cell.layer.transform = CATransform3DMakeScale(0.25, 0.25, 0.25)
        UIView.animate(withDuration: 0.25) {
            cell.contentView.alpha = 1
            cell.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
        }
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc func rotated(){
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }
    
    
    
}


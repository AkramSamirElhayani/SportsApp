//
//  NetworkHelper.swift
//  SportsApp
//
//  Created by Akram Elhayani on 23/02/2022.
//

import Foundation
import Alamofire
import CoreData
import SDWebImage

public class NetworkHelper
{
    static var Sports :Array<SportElement> = [SportElement]()
    
    static  func loadData(_ table :UIScrollView? = nil) -> Void {
        
        
        AF.request("https://www.thesportsdb.com/api/v1/json/2/all_sports.php"
        )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    let data =     response.value
                    
                    do{
                        let  decoder:  JSONDecoder  = JSONDecoder();
                        let array = try decoder.decode(Sport.self, from: data!);
                        self.Sports.removeAll();
                        self.Sports.append(contentsOf: array.sports);
                        print("Sports count \(self.Sports.count)");
                        /// Reload Data into grid
                        DispatchQueue.main.async {
                            if let table = table as? UITableView{
                                print("Table")
                                table.reloadData()
                            }else if let table = table as? UICollectionView{
                                print("Collection")
                                table.reloadData()
                            }
                            
                        }
                    }
                    catch let error as NSError {
                       print("Could not fetch Data of sports from server  \(error), \(error.userInfo)")
                   }
                    
                case .failure(_): break
                }
            }
    }
}

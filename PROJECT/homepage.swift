//
//  homepage.swift
//  PROJECT
//
//  Created by MacBook on 11/07/24.
//

import UIKit

class homepage: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet weak var colview: UICollectionView!
    var jsondata = NSArray()
    var jsondict=NSDictionary()
    
    @IBOutlet weak var logout: UIButton!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        return jsondata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        self.jsondict=self.jsondata[indexPath.row] as! NSDictionary
        let ccell = collectionView.dequeueReusableCell(withReuseIdentifier: "colid", for: indexPath)as! homeCollectionViewCell
        let imgurl = String(describing: self.jsondict["download_url"]!)
        let urlimg = URL(string:imgurl)
        let dataimg = try? Data(contentsOf: urlimg!)
        ccell.imgview.image = UIImage(data: dataimg!)
        ccell.name.text=self.jsondict["author"] as? String
        return ccell
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
            let urli = URL(string: "https://picsum.photos/v2/list")
            let url_req = URLRequest(url: urli!)

            
        let task = URLSession.shared.dataTask(with: url_req){ [self](data,request,error)in
                let mydata = data
                do
                {
                    print("mydata__>>", mydata!)

                    self.jsondata = try JSONSerialization.jsonObject(with: mydata!, options: [])as! NSArray
        
                    print("jsondata__>>", self.jsondata)
 
                    DispatchQueue.main.async()
                    {
            
                        self.colview.reloadData()
                    }
                }
            
                catch
                {
                    print("error", error.localizedDescription)
                }
        }
                task.resume()
    }
    @IBAction func logout(_ sender: Any) {
        let next = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login")
        self.navigationController?.pushViewController(next, animated: true)
    }
}

//
//  ViewController.swift
//  JSONParsing
//
//  Created by Ekramul Hoque on 10/7/18.
//  Copyright © 2018 Ekramul Hoque. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tableArray = [String]()

    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        parsingData()
        
       
    }

    func parsingData() {
        
        let url = URL(string: "https://api.myjson.com/bins/vi56v")
    
        //creating Urlsession
        
        let task = URLSession.shared.dataTask(with: url!) { (data, responce, error) in
             // cheaking error
            guard error == nil else {
                print("There is Nill and its : \(error?.localizedDescription)")
                return
            }
            
            
            // cheaking response code
//            if let sucessCode = responce {
//                print(sucessCode)
//            }
            
            //cheaking the data
            guard let content = data else {
                print("There is no data")
                return
            }
            
            //serilising data from json to dictonaray
            guard let json = try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any] else {
                print("problem in serilising ")
                return
            }
            
            // adding data to json
            if let array = json!["companies"] as? [String] {
                self.tableArray = array
            }
            
            print(self.tableArray)
            
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
            
      }
        
        
        
        task.resume()
    
    }

}

extension ViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "Cell") as! MyTableViewCell
        cell.dataLabel.text = tableArray[indexPath.row]
        return cell
    }
    
    //Optional Data Source are
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.tableArray[indexPath.row])
        myTableView.deselectRow(at: indexPath, animated: true)
    }
    
    //edit action for row at index path
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
       // creating action
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
           self.tableArray.remove(at: indexPath.row)
           self.myTableView.deleteRows(at: [indexPath], with: .fade)
            print(self.tableArray)
        }
        
        let share = UITableViewRowAction(style: .default, title: "Share") { (action, indexPath) in
            print("I want to share : \(self.tableArray[indexPath.row])")
        }
        share.backgroundColor = UIColor.green
        return[delete,share]
    }

    
}


//
//  ViewController.swift
//  FestBandz2
//
//  Created by Derek Jacobs on 2017-04-04.
//  Copyright © 2017 Derek Jacobs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView! //link to table view
    
    var bands : [Band] = [] // empty array to start
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    // called each time view controller about to be shown, inside will be stuff to get things out of core data
    override func viewWillAppear(_ animated: Bool) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            bands = try context.fetch(Band.fetchRequest())
            tableView.reloadData()
        } catch {
            print("wtf")
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bands.count //rows is equal to number of things in array
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let band  = bands[indexPath.row]
        cell.textLabel?.text = band.title
        cell.imageView?.image = UIImage(data: band.image as! Data) //NS to reg data issue again, Xcode is hating this downcasting
        return cell
    }
}


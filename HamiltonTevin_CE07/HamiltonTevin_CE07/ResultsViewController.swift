//
//  ResultsViewController.swift
//  HamiltonTevin_CE07
//
//  Created by Tevin Hamilton on 9/21/19.
//  Copyright © 2019 Tevin Hamilton. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var tableView: UITableView!
    var selectedArray = [ZipCodes]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return selectedArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //reuse an existing cell or create a new one
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_id1", for: indexPath) as? ResultsTableViewCell
        
      cell?.labelCityState.text = selectedArray[indexPath.row].cityAndState
        cell?.labelPopulation.text = selectedArray[indexPath.row].populationString
        cell?.labelZipCode.text = selectedArray[indexPath.row].zipCodeString
        
        return (cell)!
    }
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func  prepare(for segue: UIStoryboardSegue, sender: Any?){
        let postToSend = selectedArray
        
        if let destination = segue.destination as? SearchTableViewController
        {
            //pass data to view controler
            destination.filteredArray = postToSend
        }
    }
    // pass data back from search table view to results view controller
    @IBAction func unwindToViewController(segue: UIStoryboardSegue)
    {
        if let updateArray = segue.source as? SearchTableViewController
        {
            
            selectedArray = updateArray.filteredArray
            tableView.reloadData()
        }
    }
    // clear array and reload data 
    @IBAction func ClearTableView(_ sender: UIBarButtonItem)
    {
        selectedArray.removeAll()
        tableView.reloadData()
    }
}

//
//  SearchTableViewController.swift
//  HamiltonTevin_CE07
//
//  Created by Tevin Hamilton on 9/21/19.
//  Copyright © 2019 Tevin Hamilton. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate  {
    
    //create UISearchControler
    var searchController = UISearchController(searchResultsController: nil)
    //for filtered data
    var filteredArray:[ZipCodes]! = nil
    //contains parse data
    var zipCodeArray = [ZipCodes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if filteredArray != nil {
         parse()
        
        //set up search controll
        searchController.dimsBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        
        //receive updates
        searchController.searchResultsUpdater = self
        
        //set up searchbar of the search controller
        searchController.searchBar.scopeButtonTitles = ["All","NY","FL"]
        searchController.searchBar.delegate = self
        
        //add the search bar as a nevgation item
        navigationItem.searchController = searchController
        //since we are moving thinggs aroung make sure it is size correctly
        searchController.searchBar.sizeToFit()
        self.filteredArray = zipCodeArray
        }
        //navigationController?.navigationItem.backb
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //reuse an existing cell or create a new one
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_ID2", for: indexPath) as? SearchTableViewCell
        
        //populate labels with data
        cell?.labelCityState.text = filteredArray[indexPath.row].cityAndState
        cell?.labelPopulation.text = filteredArray[indexPath.row].populationString
        cell?.labelZipCode.text = filteredArray[indexPath.row].zipCodeString
        
        return (cell)!
    }
    
    func updateSearchResults(for searchController: UISearchController)
    {
        
        //getting the text the user search for
        let searchText = searchController.searchBar.text
        
        //get the scope title that the user hase selected
        let selectedScope = searchController.searchBar.selectedScopeButtonIndex
        let allscopetitle = searchController.searchBar.scopeButtonTitles!
        let scopetitle = allscopetitle[selectedScope]
        
        //filter our content
        
        //dump our full data into the array we will use for filtering
        filteredArray = zipCodeArray
        
        if searchText != ""
        {
            //filitered search into array
            self.filteredArray = filteredArray.filter({ (contact) -> Bool in
                return contact.city.lowercased().range(of: searchText!.lowercased()) != nil
            })
        }
        // filter again based on scope
        if scopetitle != "All"
        {
            //take the current data into the scope
            self.filteredArray = filteredArray.filter({
                $0.state.range(of: scopetitle) != nil
            })
        }
        tableView.reloadData()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        updateSearchResults(for: searchController)
    }
    
    // MARK: - Table view data source
    
    
    //MARK:parse
    func parse()
    {
        //Get the path to employeeData.json file
        if let path = Bundle.main.path(forResource: "zips", ofType: ".json") {
            
            //Create the URL using path
            let url = URL(fileURLWithPath: path)
            
            do{
                let data = try Data.init(contentsOf: url)
                
                //create josn object
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]
                
                //use guard statment to parse json object
                guard let json = jsonObj
                    else {print("something went wrong with the json object");return}
                //reach first level json data.
                for firstLevel in json
                {
                    guard let object = firstLevel as? [String: Any],
                    let city = object ["city"] as? String,
                        let location = object ["loc"] as? [Double],
                    let population = object ["pop"] as? Int,
                    let state = object ["state"] as? String,
                    let zipCode = object ["_id"]  as? String
                        else{print("something went wrong");return}

                    zipCodeArray.append(ZipCodes(city: city, location: location, population: population, state: state, zipCode: zipCode))
                }
           
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
       //dismiss the keypad and lock in the search items
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}

//
//  ZipCodes.swift
//  HamiltonTevin_CE07
//
//  Created by Tevin Hamilton on 9/21/19.
//  Copyright © 2019 Tevin Hamilton. All rights reserved.
//

import Foundation
class ZipCodes
{
    //stored
    let city:String
    let location:[Double]
    let population:Int
    let state:String
    let zipCode:String
    
    //init
    init(city:String, location:[Double], population:Int, state:String, zipCode:String)
    {
        self.city = city
        self.location = location
        self.population  = population
        self.state = state
        self.zipCode = zipCode
    }
    
    //computed
    var cityAndState:String
    {
        return city+","+state
    }
    
    var populationString:String
    {
        return"population \(population.description)"
    }
    
    var zipCodeString:String
    {
        return "zip code: \(zipCode)"
    }
}

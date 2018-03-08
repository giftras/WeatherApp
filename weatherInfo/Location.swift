//
//  Location.swift
//  weatherInfo
//
//  Created by Macbook Pro on 1/24/2560 BE.
//  Copyright © 2560 Student. All rights reserved.
//

import Foundation
class Location{
    static var sharedInstance = Location()
    private init(){
        
    }
    var lattitude: Double!
    var longtitude: Double!
    
}

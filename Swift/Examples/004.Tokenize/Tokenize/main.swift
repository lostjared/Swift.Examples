//
//  main.swift
//  Tokenize
//
//  Created by Jared Bruni on 5/24/15.
//  Copyright (c) 2015 Jared Bruni. All rights reserved.
//

import Foundation


class Tokens {
    var tokens: Array<AnyObject> = Array<AnyObject>()
    
    init() {
        
    }
    
    func tokenizeString(value: String) {
        var str:NSString = NSString(string: value)
        var ar = str.componentsSeparatedByString(" ")
        tokens = ar
    }
    
    subscript(i: Int) -> String {
    
        var s: String = tokens[i].string
        return s
    }
    
}


var toke:Tokens = Tokens()

toke.tokenizeString("This is a test of the seperating by space")
for i in toke.tokens {
    println("Value is: \(i)")
}
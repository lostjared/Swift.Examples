//
//  main.swift
//  SwiftKarma
//
//  Created by Jared Bruni on 5/23/15.
//  Copyright (c) 2015 Jared Bruni. All rights reserved.
//

import Cocoa


// from Stack Overflow
func readln(max:Int = 8192) -> String? {
    assert(max > 0, "max must be between 1 and Int.max")
    
    var buf:Array<CChar> = []
    var c = getchar()
    while c != EOF && c != 10 && buf.count < max {
        buf.append(CChar(c))
        c = getchar()
    }
    //always null terminate
    buf.append(CChar(0))
    
    return buf.withUnsafeBufferPointer { String.fromCString($0.baseAddress) }
}


class Energy {
    var E:String = ""
    
    func setEnergy(e: String) {
        E = e
    }
    
    func getEnergy() -> String {
        return E
    }
}


protocol Soul {
    func get(value: Energy) -> Bool
    func give() -> Energy
}


class Atman:Soul {
    
    func get(value: Energy) -> Bool {
        if(value.getEnergy() == "quit") {
            return false
        }
        if(value.getEnergy() == "love") {
            println("Sent love..\n")
        }
        if(value.getEnergy() == "fear") {
            println("Sent fear..\n")
        }
        
        return true
    }
    
    func give() -> Energy {
        print("Thought: ")
        var input:Energy = Energy()
        var stringValue: String! = readln()
        input.setEnergy(stringValue)
        return input
    }
}

class Karma {
    
    var MySoul:Atman = Atman()

    func procKarma() {
        
        while MySoul.get(MySoul.give()) {
            println("Karma Cycle")
        }
    }
}

var karma:Karma = Karma()
karma.procKarma()




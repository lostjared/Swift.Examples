//
//  main.swift
//  FirstProgram
//
//  Created by Jared Bruni on 5/23/15.
//  Copyright (c) 2015 Jared Bruni. All rights reserved.
//

import Cocoa

print("Enter your name:")

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

var name:String! = readln()
println("Hello \(name)")

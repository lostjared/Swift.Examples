//
//  main.swift
//  BasicStuff
//
//  Created by Jared Bruni on 5/23/15.
//  Copyright (c) 2015 Jared Bruni. All rights reserved.
//

// just messing around with some concepts

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



class List<T> {
    var arr:Array<T> = Array<T>()
    
    func add(str: T) {
        arr.append(str)
    }
    
    func size() -> Int {
        return arr.count;
    }
}


var values:List<Int> = List<Int>()

for i in 1...100 {
    values.add(i)
}

for i in values.arr {
    println("Value is: \(i)")
}

var value = 0

while value != 1 {
    print("Enter a integer value, 1 to quit")
    var stringInput: String! = readln()
    
    var v: Int! = stringInput.toInt()
    if v == 1 { break; }
    else {
        values.add(v)
    }
}


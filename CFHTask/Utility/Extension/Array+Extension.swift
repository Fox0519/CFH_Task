//
//  Array+Extension.swift
//  CFHTask
//
//  Created by fox on 2021/7/29.
//

extension Array {
    public subscript(safe index: Int) -> Element? {
        return (0 <= index && index < count) ? self[index] : nil
    }
}

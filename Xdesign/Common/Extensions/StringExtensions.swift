//
//  StringExtensions.swift
//  Xdesign
//
//  Created by flexkid on 08/01/2019.
//  Copyright © 2019 DiegoCaridei. All rights reserved.
//

import Foundation

extension String {
    func urlEncode() -> String {
        guard let encode = self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else { fatalError("urlEncode extension") }
        return encode
    }
}

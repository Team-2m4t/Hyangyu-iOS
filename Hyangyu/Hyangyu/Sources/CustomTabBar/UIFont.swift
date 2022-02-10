//
//  UIFont.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/20.
//

import Foundation
import UIKit

extension UIFont {
    var weightValue: Float {
        guard let value = traits[.weight] as? NSNumber else {
            return 0
        }
        return value.floatValue
    }
    
    private var traits: [UIFontDescriptor.TraitKey: Any] {
        return fontDescriptor.object(forKey: .traits) as? [UIFontDescriptor.TraitKey: Any] ?? [:]
    }
}





extension UIView{
    
    func addSubs(_ views: UIView...){
        views.forEach(addSubview(_:))
    }


}

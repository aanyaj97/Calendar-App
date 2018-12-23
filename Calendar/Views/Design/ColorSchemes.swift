//
//  ColorSchemes.swift
//  Calendar
//
//  Created by Aanya Jhaveri on 12/19/18.
//  Copyright © 2018 Aanya Jhaveri. All rights reserved.
//

import Foundation
import UIKit

struct ColorScheme {
    var background: UIColor
    var foreground: UIColor
    var titleText: UIColor
    var subtitleText: UIColor
    var mainText: UIColor
    var doneText: UIColor
}

let darkBackground = UIColor(red: 31/255, green: 29/255, blue: 28/255, alpha: 1.0)
let darkForeground = UIColor(red: 41/255, green: 42/255, blue: 44/255, alpha: 0.75)
let darkTitleText = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
let darkSubtitleText = UIColor(red: 234/255, green: 167/255, blue: 167/255, alpha: 1.0)
let darkMainText = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
let darkDoneText = UIColor(red: 42/255, green: 37/255, blue: 43/255, alpha: 0.85)

let lightBackground = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
let lightForeground = UIColor(red: 191/255, green: 191/255, blue: 191/255, alpha: 0.75)
let lightTitleText = UIColor(red: 31/255, green: 29/255, blue: 28/255, alpha: 1.0)
let lightSubtitleText = UIColor(red: 234/255, green: 167/255, blue: 167/255, alpha: 1.0)
let lightMainText = UIColor(red: 31/255, green: 29/255, blue: 28/255, alpha: 1.0)
let lightDoneText = UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.85)


let darkTheme = ColorScheme(background: darkBackground, foreground: darkForeground, titleText: darkTitleText, subtitleText: darkSubtitleText, mainText: darkMainText, doneText: darkDoneText)

let lightTheme = ColorScheme(background: lightBackground, foreground: lightForeground, titleText: lightTitleText, subtitleText: lightSubtitleText, mainText: lightMainText, doneText: lightDoneText)



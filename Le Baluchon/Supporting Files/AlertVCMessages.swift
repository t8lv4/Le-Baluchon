//
//  AlertVCMessages.swift
//  Le Baluchon
//
//  Created by Morgan on 08/11/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/// List strings to display as an alert pop-up title
enum alertTitle: String {
    case requestFailure = "😕"

    case convertInputValidity = "🤓"
    case translateInputValidity = "😉"
    case weatherRequest = "🙃"
    case locationAuth = "✅"
}

/// List strings to display as an alert pop-up message
enum alertMessage: String {
    case convertInputValidity = "Ceci n'est pas convertible en $..."
    case convertRequest = "Les données ne sont pas disponibles."

    case translateInputValidity = "Le traducteur demande un texte !"
    case translateRequest = "La traduction n'est pas disponible"

    case weatherRequest = "Un problème est survenu..."
    case locationAuth = """
                        Autorisez le Baluchon à vous localiser :
                        vous recevrez les prévisions météo pour votre ville !
                        """
}

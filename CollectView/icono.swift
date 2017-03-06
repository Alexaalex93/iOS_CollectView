//
//  icono.swift
//  CollectView
//
//  Created by cice on 6/3/17.
//  Copyright © 2017 alex. All rights reserved.
//

import Foundation

struct Icono {

    var nombre: String = ""
    var precio: Double = 0.0
    var destacado: Bool = false
    
    init (nombre: String, precio: Double, destacado: Bool){
        
    self.nombre = nombre
    self.precio = precio
    self.destacado = destacado
    
    }
}

//
//  BlackJackManager.swift
//  JackBlackApp
//
//  Created by Alssiad on 5/8/18.
//  Copyright © 2018 ULIMA. All rights reserved.
//

import Foundation

class Nodo<T>{
    var elemento: T?
    var siguiente: Nodo<T>?
    
    init(elemento: T?) {
        self.elemento = elemento
    }
}

class Pila<T>{
    var head: Nodo<T>?
    var tamaño = 0
    
    func push(elemento: T?){
        let penultimoNodo = head
        let nodo = Nodo(elemento: elemento)
        head = nodo
        head?.siguiente = penultimoNodo
        tamaño += 1
    }
    
    func pop()->T?{
        if let obj = head?.elemento{
            head = head?.siguiente
            tamaño -= 1
            return obj
        }
        return nil
    }
}

class BlackJackManager{
    
    var numPalo: Int
    var sumaMesa: Int
    var sumaJugador: Int
    var barajaCartas1 = Pila<Int>()
    var barajaCartas2: [String]
    let barajaAux = Pila<Int>()
    
    init() {
        numPalo = 0
        sumaMesa = 0
        sumaJugador = 0
        barajaCartas2 = []
        inicializarBarajas()
    }
    
    func inicializarBarajas(){
        barajaCartas1 = Pila<Int>()
        for _ in 0..<4{
            for i in 0..<13{
                barajaCartas1.push(elemento: i+1)
            }
        }
        barajaCartas2.append("♠️")
        barajaCartas2.append("♣️")
        barajaCartas2.append("♥️")
        barajaCartas2.append("♦️")
    }
    
    func comprobarQuedar() -> Int{
        if sumaMesa>21{
            return 1
        }
        else{
            if sumaMesa>sumaJugador{
                return -1
            }
            else if sumaJugador>sumaMesa{
                return 1
            }
            else if sumaJugador==sumaMesa{
                return 0
            }
        }
        return 0
    }
    
    func comprobarVoloBJ() -> Int{
        if sumaMesa>21, sumaJugador>21{
            return 0
        }else if sumaJugador==21, sumaMesa==21{
            return 0
        }
        else if sumaJugador>21{
            return -1
        }else if sumaJugador==21{
            return 1
        }
        return 2
    }
    
}

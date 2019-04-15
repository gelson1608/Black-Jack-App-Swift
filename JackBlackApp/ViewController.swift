//
//  ViewController.swift
//  JackBlackApp
//
//  Created by Alssiad on 5/8/18.
//  Copyright © 2018 ULIMA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, OnTapDelegate {
    func onTapDelegate() {
        print("Se hizo flip")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    var bjManager: BlackJackManager = BlackJackManager()
    var random: Int = 0
    var contadorM: Int = 0
    var contadorJ: Int = 0
    
    @IBOutlet weak var textoInfo: UILabel!
    @IBOutlet var cartasMesa: [CartaView]!{
        didSet{
            for cartita in cartasMesa{
                random = Int(arc4random_uniform(UInt32(bjManager.barajaCartas1.tamaño - 1)) + 1)
                bjManager.numPalo = random/13
                cartita.palo = bjManager.barajaCartas2[bjManager.numPalo]
                for i in 0..<random{
                    let value: Int? = bjManager.barajaCartas1.pop()
                    if i != random - 1{
                        bjManager.barajaAux.push(elemento: value)
                    }
                    else if i == random - 1{
                        cartita.numero = value
                    }
                }
                for _ in 0..<random - 1{
                    let returValue: Int? = bjManager.barajaAux.pop()
                    bjManager.barajaCartas1.push(elemento: returValue)
                }
                if contadorM < 2{
                    cartita.isCaraArriba = true
                    contadorM += 1
                }
            }
        }
    }
    
    @IBOutlet var cartasJugador: [CartaView]!{
        didSet{
            for cartitaJug in cartasJugador{
                random = Int(arc4random_uniform(UInt32(bjManager.barajaCartas1.tamaño - 1)) + 1)
                bjManager.numPalo = random/13
                cartitaJug.palo = bjManager.barajaCartas2[bjManager.numPalo]
                for i in 0..<random{
                    let value: Int? = bjManager.barajaCartas1.pop()
                    if i != random - 1{
                        bjManager.barajaAux.push(elemento: value)
                    }
                    else if i == random - 1{
                        cartitaJug.numero = value
                    }
                }
                for _ in 0..<random - 1{
                    let returValue: Int? = bjManager.barajaAux.pop()
                    bjManager.barajaCartas1.push(elemento: returValue)
                }
                if contadorJ < 2{
                    cartitaJug.isCaraArriba = true
                    contadorJ += 1
                }
            }
        }
    }
    
    @IBAction func quedarCartas(_ sender: UIButton) {
        bjManager.sumaMesa = 0
        bjManager.sumaJugador = 0
        for carta in cartasMesa{
            carta.isCaraArriba = true
            if carta.isCaraArriba == true{
                bjManager.sumaMesa += carta.numero!
            }
        }
        for cartaJ in cartasJugador{
            if cartaJ.isCaraArriba == true{
                bjManager.sumaJugador += cartaJ.numero!
            }
        }
        let comprobacion : Int = bjManager.comprobarQuedar()
        if comprobacion == -1{
            textoInfo.text = "La mesa gana"
        }
        else if comprobacion == 1{
            textoInfo.text = "Usted gana"
        }
        else if comprobacion == 0{
            textoInfo.text = "Empate!"
        }
    }
    
    @IBAction func reiniciarPartida(_ sender: UIButton) {
        
        textoInfo.text = "BlackJack"
        contadorM = 0
        contadorJ = 0
        bjManager.numPalo = 0
        bjManager.sumaMesa = 0
        bjManager.sumaJugador = 0
        bjManager.barajaCartas2 = []
        bjManager.inicializarBarajas()
        self.loadView()
        self.viewDidAppear(true)
    }
    
}


//
//  CartaView.swift
//  JackBlackApp
//
//  Created by Alssiad on 5/8/18.
//  Copyright © 2018 ULIMA. All rights reserved.
//

import Foundation
import UIKit

protocol OnTapDelegate {
    func onTapDelegate()
}

class CartaView: UIView {
    var numero: Int?{
        didSet{
            setNeedsDisplay()
        }
    }
    var palo: String?{
        didSet{
            setNeedsDisplay()
        }
    }
    var onTapDelegate: OnTapDelegate?
    var isCaraArriba: Bool = false{
        didSet{
            for view in self.subviews{
                view.removeFromSuperview()
            }
            setNeedsDisplay()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let tapRecognizer: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        addGestureRecognizer(tapRecognizer)
    }
    
    override func draw(_ rect: CGRect) {
        if isCaraArriba{
            dibujarCarta()
        }else{
            dibujarEspalda()
        }
    }
    
    func dibujarCarta(){
        // Dibujamos el circulo
        let radioCirculo = self.bounds.width / 3
        let circulo = UIBezierPath(arcCenter: CGPoint(x:self.bounds.midX, y:self.bounds.midY), radius: radioCirculo, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        circulo.stroke()
        
        // Dibujamos el numero y palo
        let altoNumero = CGFloat(30)
        let labNumero = UILabel(frame: CGRect(x: self.bounds.midX - radioCirculo, y: self.bounds.midY - altoNumero / 2, width: 2 * radioCirculo, height: altoNumero))
        labNumero.textAlignment = NSTextAlignment.center
        if let num = numero, let pal = palo{
            labNumero.text = String(num) + pal
        }
        addSubview(labNumero)
    }
    
    
    func dibujarEspalda(){
        if let imagenAtras = UIImage(named: "cartatrasera"){
            let alto = imagenAtras.cgImage!.height
            let ancho = imagenAtras.cgImage!.width
            
            let cartaTView = UIImageView(frame: CGRect(x: Int(frame.width)/2 - ancho/2, y: 0, width: ancho, height: alto))
            cartaTView.frame.origin.x = 0
            cartaTView.frame.origin.y = 0
            
            let aspectRatio = cartaTView.frame.width / cartaTView.frame.height
            cartaTView.frame.size.width = frame.size.width
            cartaTView.frame.size.height = frame.size.width / aspectRatio
            cartaTView.image = imagenAtras
            addSubview(cartaTView)
            
            // Igualamos el alto de la imageview al alto de figuritaview
            self.frame.size.height = cartaTView.frame.size.height
        }
    }
    
    @objc private func onTap(_ gestureRecognizer : UIGestureRecognizer){
        if isCaraArriba == false{
            isCaraArriba = !isCaraArriba
        }
    }
}

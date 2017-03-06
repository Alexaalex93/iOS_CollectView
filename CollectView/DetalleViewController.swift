//
//  DetalleViewController.swift
//  CollectView
//
//  Created by cice on 6/3/17.
//  Copyright © 2017 alex. All rights reserved.
//

import UIKit

class DetalleViewController: UIViewController {
    
    var icono: Icono?
    
    @IBOutlet weak var iconoImageView: UIImageView!{
        didSet {
            iconoImageView.image = UIImage(named: icono?.nombre ?? "")//Como el ternari operator, si tiene nombre lo usa, si no string vacio
        }}
    
    @IBOutlet weak var precioLabel: UILabel!{
        didSet{
        precioLabel.text = "\(icono?.precio)€"}
    }
    @IBOutlet weak var nombreLabel: UILabel!{
        didSet{
            nombreLabel.text = icono?.nombre
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

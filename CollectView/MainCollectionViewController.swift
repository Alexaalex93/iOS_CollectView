//
//  MainCollectionViewController.swift
//  CollectView
//
//  Created by cice on 6/3/17.
//  Copyright © 2017 alex. All rights reserved.
//

import UIKit
import Social

private let reuseIdentifier = "Cell"

class MainCollectionViewController: UICollectionViewController {
    
        @IBOutlet weak var compartirBoton: UIBarButtonItem!
    
    var multiSeleccion = false
    var imagenesSeleccionadas:[Icono] = []
    
    var iconosSet: [Icono] = [Icono(nombre: "candle", precio: 4.0, destacado: false),
                              Icono(nombre: "cat", precio: 150.0, destacado: true),
                              Icono(nombre: "dribbble", precio: 40.0, destacado: false),
                              Icono(nombre: "hat", precio: 32.0, destacado: false),
                              Icono(nombre: "ghost", precio: 4.0, destacado: false),
                              Icono(nombre: "ic_backpack", precio: 454.0, destacado: false),
                              Icono(nombre: "ic_book", precio: 141.0, destacado: true),
                              Icono(nombre: "ic_camera", precio: 78.0, destacado: false),
                              Icono(nombre: "ic_coffee", precio: 98.0, destacado: true),
                              Icono(nombre: "ic_glasses", precio: 6545.0, destacado: false),
                              Icono(nombre: "ic_ice_cream", precio: 65.0, destacado: false),
                              Icono(nombre: "ic_smoking_pipe", precio: 85.0, destacado: false),
                              Icono(nombre: "ic_vespa", precio: 36.0, destacado: false),
                              Icono(nombre: "owl", precio: 45.0, destacado: true),
                              Icono(nombre: "pot", precio: 774.0, destacado: false),
                              Icono(nombre: "pumkin", precio: 789.0, destacado: false),
                              Icono(nombre: "rip", precio: 12345.0, destacado: true),
                              Icono(nombre: "skull", precio: 698.0, destacado: false),
                              Icono(nombre: "sky", precio: 785.0, destacado: false),
                              Icono(nombre: "toxic", precio: 3654785.0, destacado: true)]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //COMENTAR ESTA LINEA PARA QUE NO COJA LA DE POR DEFECTO
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return iconosSet.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! IconoCollectionViewCell
    
        let icono = iconosSet[indexPath.row]
        cell.iconoImageView.image = UIImage(named: icono.nombre)
        cell.iconoPrecioLabel.text = "\(icono.precio)€"
        
        cell.selectedBackgroundView = UIImageView(image: UIImage(named: "selected-bg"))
        
        cell.backgroundView = (icono.destacado) ? UIImageView(image: UIImage(named: "feature-bg")) : nil
        
        return cell
    }

    @IBAction func unwindToHomew( segue: UIStoryboardSegue){}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //Un collection view puede tener varias selecciones
        if segue.identifier == "mostrarDetalle"{
            
                
                if let indexPaths = collectionView?.indexPathsForSelectedItems {
                    let destinationController = segue.destination as! DetalleViewController
                    destinationController.icono = iconosSet[indexPaths[0].row]
                    collectionView?.deselectItem(at: indexPaths[0], animated: true)
                    
                }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "mostrarDetalle" {
            if multiSeleccion {
            return false }
            
        }
        return true
    }
    
    //TE DETECTA AUTOMATICAMENTE LA PRESION LARGA Y AQUI ACTIVAS LA FUNCION
    @IBAction func presionLarga(_ sender: AnyObject) {
       print("Presion larga en ...")
   }
    
    //En este caso utiliza la cuenta que el usuario tiene configurada en la cuenta de su telefono
    @IBAction func botonCompartirApretado(_ sender: AnyObject) {
        if multiSeleccion {
            if imagenesSeleccionadas.count > 0 {
                if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter){
                    let tweetComposer = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                    tweetComposer?.setInitialText("Me gustan estas imagenes")
                    for icon in imagenesSeleccionadas {
                        tweetComposer?.add(UIImage(named: icon.nombre))
                    }
                    present(tweetComposer!, animated:true, completion: nil)
                }
            }
            //Deseleccionamos las celdas
            if let indexPaths = collectionView?.indexPathsForSelectedItems {
                for index in indexPaths {
                    collectionView?.deselectItem(at: index, animated: false)
                }
            }
            //Borrar nuestro array imagenesSeleccionadas
            imagenesSeleccionadas.removeAll(keepingCapacity: true)
            
            //Modo compartir a false
            multiSeleccion = false
            collectionView?.allowsMultipleSelection = false
            compartirBoton.title = "Compartir"
            compartirBoton.style = .plain
            
        } else {
            multiSeleccion = true
            collectionView?.allowsMultipleSelection = true
            compartirBoton.title = "Hecho"
            compartirBoton.style = .done
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard multiSeleccion else { return }
        
        let iconoSeleccionado = iconosSet[indexPath.row]
        imagenesSeleccionadas.append(iconoSeleccionado)
    }

    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard multiSeleccion else { return }
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

//
//  ProductosViewController.swift
//  AppConsorcio
//
//  Created by DAMII on 12/11/23.
//

import UIKit
import Alamofire
import Kingfisher

class ProductosViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    

    @IBOutlet weak var cvProductos: UICollectionView!
    
    var listaProductos:[Products]=[]
    var cod = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cargarProductos()
        
        cvProductos.dataSource=self
        //
        cvProductos.delegate=self

    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listaProductos.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let fila = collectionView.dequeueReusableCell(withReuseIdentifier: "row", for: indexPath) as! ItemProductoCollectionViewCell
        
        fila.lblTitle.text = listaProductos[indexPath.row].title
        let url = URL(string: listaProductos[indexPath.row].image)
        fila.imgFoto.kf.setImage(with: url)
        return fila
    }

    func cargarProductos(){
        AF.request("https://fakestoreapi.com/products").responseDecodable(of:[Products].self){ response in
            
            guard let data = response.value else {return}
            self.listaProductos=data
            self.cvProductos.reloadData()
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width-20)/2
        return CGSize(width: width, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cod=listaProductos[indexPath.row].id
        print("ID : ", cod)
        //performSegue(withIdentifier: "editar2", sender: self)

    }
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //crear objeto de la clase EditarViewController
       // if segue.identifier=="editar2"{
         //   let pantalla2=segue.destination as! ConsultaProductoViewController
            //acceder
            //pantalla2.data=listaProductos[cod]
        //}
     
    //}
}

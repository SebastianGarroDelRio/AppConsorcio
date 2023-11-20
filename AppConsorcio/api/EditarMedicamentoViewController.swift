//
//  EditarMedicamentoViewController.swift
//  AppConsorcio
//
//  Created by DAMII on 5/11/23.
//

import UIKit
import Alamofire
class EditarMedicamentoViewController: UIViewController {

    @IBOutlet weak var txtFecha: UITextField!
    @IBOutlet weak var txtPrecio: UITextField!
    @IBOutlet weak var txtStock: UITextField!
    @IBOutlet weak var txtDescripcion: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtCodigo: UITextField!
    
    var data:Medicamento!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtCodigo.text=String(data.codigo)
        txtNombre.text=data.nombre
        txtDescripcion.text=data.descripcion
        txtStock.text=String(data.stock)
        txtPrecio.text=String(data.precio)
        txtFecha.text=data.fecha

        // Do any additional setup after loading the view.
    }
    

    
    
    func editarMedicamento(obj:Medicamento){
        AF.request("https://puedeser.onrender.com/medicamento/actualizar",method: .put, parameters: obj,encoder: JSONParameterEncoder.default)
        .response(completionHandler: { data in
            //validar data
            switch data.result{
                
            case.success(let info):
                do{
                    let result = try JSONDecoder().decode(Medicamento.self,from : info!)
                }catch{
                    print("error en el JSON")
                }
                case.failure(let error):
                    print(error.localizedDescription)
            }
        
            
            
        })
        
        
        
    }
    
    func eliminarMedicamento(cod:Int){
        AF.request("https://puedeser.onrender.com/medicamento/eliminar/"+String(cod),method: .delete)
        .response(completionHandler: { data in
            //validar data
            switch data.result{
                
            case.success(_):
                
                    print("correcto")
                
                case.failure(let error):
                    print(error)
            }
        
            
            
        })
        
        
        
    }
    
    @IBAction func txtActualizar(_ sender: Any) {
        let codigo=Int(txtCodigo.text ?? "0") ?? 0
        let nom=txtNombre.text ?? ""
        let des=txtDescripcion.text ?? ""
        let stock=Int(txtStock.text ?? "0") ?? 0
        let pre=Double(txtPrecio.text ?? "0") ?? 0
        let fec=txtFecha.text ?? ""
        
        data.nombre=nom
        data.descripcion=des
        data.precio=pre
        data.stock=stock
        data.fecha=fec

        editarMedicamento(obj:data)
    }

    @IBAction func btnEliminar(_ sender: UIButton) {
        let codigo=Int(txtCodigo.text ?? "0") ?? 0

        //crear ventana
         let ventana=UIAlertController(title: "Sistema", message: "Seguro de eliminar?", preferredStyle: .alert)
        //boton aceptar
         let botonAceptar=UIAlertAction(title: "Si", style: .default,handler: {action in
             self.eliminarMedicamento(cod: codigo)
         })
        //adicionar boton aceptar
         ventana.addAction(botonAceptar)
        //adicionar boton cancelar
         ventana.addAction(UIAlertAction(title: "No", style: .cancel))
        //mostrar venta
        present(ventana, animated: true)
     }
}

//
//  EditarEmpleadoViewController.swift
//  AppConsorcio
//
//  Created by DAMII on 19/11/23.
//

import UIKit
import FirebaseFirestore

class EditarEmpleadoViewController: UIViewController {

    var bean:Empleado!
    
    @IBOutlet weak var txtEdad: UITextField!
    @IBOutlet weak var txtApellido: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtEdad.text=String(bean.edad)
        txtNombre.text=bean.nombres
        txtApellido.text=bean.apellidos

    }
    

    func actualizarEmpleado(x:Empleado){
        let BD = Firestore.firestore()
        //let id = UUID().uuidString
        BD.collection("empleado").document(bean.id).setData([
            "nombres":x.nombres,
            "apellidos":x.apellidos,
            "edad":x.edad

        ]){error in
            if let e=error{
                print(e.localizedDescription)
            }
            else{
                print("Registro OK")
            }
        }
        
    }

    @IBAction func btnActualizar(_ sender: UIButton) {
        let nom=txtNombre.text ?? ""
        let ape=txtApellido.text ?? ""
        let edad=Int(txtEdad.text ?? "0") ?? 0
        
        
        bean.nombres=nom
        bean.apellidos=ape
        bean.edad=edad

        actualizarEmpleado(x:bean)
    }
    
    @IBAction func btnEliminar(_ sender: UIButton) {
        
        let BD = Firestore.firestore()
            
            BD.collection("empleado").document(bean.id).delete { error in
                if let e = error {
                    print("Error al eliminar el documento: \(e.localizedDescription)")
                } else {
                    print("Documento eliminado correctamente.")
                }
            }
        
    }
}

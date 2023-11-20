//
//  NuevoEmpleadoViewController.swift
//  AppConsorcio
//
//  Created by DAMII on 19/11/23.
//

import UIKit
import FirebaseFirestore

class NuevoEmpleadoViewController: UIViewController {

    
    @IBOutlet weak var txtEdad: UITextField!
    @IBOutlet weak var txtApellido: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func grabarEmpleado(bean:Empleado){
        let BD = Firestore.firestore()
        let id = UUID().uuidString
        BD.collection("empleado").document(id).setData([
            "nombres":bean.nombres,
            "apellidos":bean.apellidos,
            "edad":bean.edad

        ]){error in
            if let e=error{
                print(e.localizedDescription)
            }
            else{
                print("Registro OK")
            }
        }
        
    }

    
    @IBAction func btnGrabar(_ sender: UIButton) {
        
        let nom=txtNombre.text ?? ""
        let ape=txtApellido.text ?? ""
        let edad=Int(txtEdad.text ?? "0") ?? 0
        let obj=Empleado(nombres: nom, apellidos: ape, edad: edad, id: "")
        grabarEmpleado(bean:obj)
    }
    
}

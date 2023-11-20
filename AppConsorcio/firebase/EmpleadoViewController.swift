//
//  EmpleadoViewController.swift
//  AppConsorcio
//
//  Created by DAMII on 19/11/23.
//

import UIKit
import FirebaseFirestore

class EmpleadoViewController: UIViewController,UITableViewDataSource,
                              UITableViewDelegate {
    
    @IBOutlet weak var tvEmpleado: UITableView!
    var listaEmpleado:[Empleado]=[]
    var pos = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvEmpleado.dataSource=self
              tvEmpleado.delegate=self
              tvEmpleado.rowHeight=100
        listado()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return listaEmpleado.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let fila=tvEmpleado.dequeueReusableCell(withIdentifier: "celda3") as! TableViewCell
            
            fila.lblApellido.text=String(listaEmpleado[indexPath.row].apellidos)
            fila.lblNombre.text=String(listaEmpleado[indexPath.row].nombres)

            return fila
        }
    
    func listado(){
        let BD = Firestore.firestore()
        
        BD.collection("empleado").addSnapshotListener{(data,error) in
            
            guard let info = data?.documents else {
                return
            }
            self.listaEmpleado=info.map{(e)->Empleado in
                let row = e.data()
                let nom = row["nombres"] as! String
                let ape = row["apellidos"] as! String
                let edad = row["edad"] as! Int
                return Empleado(nombres: nom, apellidos: ape, edad: edad,id:e.documentID)

            }
            self.tvEmpleado.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pos=indexPath.row
        performSegue(withIdentifier: "editar2", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //crear objeto de la clase EditarViewController
        if segue.identifier=="editar2"{
            let pantalla2=segue.destination as! EditarEmpleadoViewController
            //acceder
            pantalla2.bean=listaEmpleado[pos]
        }
       
    }
    

   

}

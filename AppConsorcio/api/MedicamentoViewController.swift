//
//  MedicamentoViewController.swift
//  AppConsorcio
//
//  Created by DAMII on 5/11/23.
//

import UIKit
import Alamofire

class MedicamentoViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var tvMedicamento: UITableView!
    //tvMedicamento
    var listaMedicamentos:[Medicamento]=[]
    var pos = -1

    override func viewDidLoad() {
        super.viewDidLoad()

        
        cargarMedicamentos()
        
        tvMedicamento.dataSource=self
        //
        tvMedicamento.delegate=self
        //
        tvMedicamento.rowHeight=120
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaMedicamentos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //crear objeto de la clase ItemTableViewCell invocando
        //a "celda"
        let row=tvMedicamento.dequeueReusableCell(withIdentifier: "celda2")
              as! ITableViewCell
        //imprimir datos
        row.lblCodigo.text=String(listaMedicamentos[indexPath.row].codigo)
        row.lblNombre.text=listaMedicamentos[indexPath.row].nombre
        return row
    }
    func cargarMedicamentos(){
        AF.request("https://puedeser.onrender.com/medicamento/lista").responseDecodable(of:[Medicamento].self){ response in
            
            guard let data = response.value else {return}
            self.listaMedicamentos=data
            self.tvMedicamento.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pos=indexPath.row
        performSegue(withIdentifier: "editar2", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //crear objeto de la clase EditarViewController
        if segue.identifier=="editar2"{
            let pantalla2=segue.destination as! EditarMedicamentoViewController
            //acceder
            pantalla2.data=listaMedicamentos[pos]
        }
       
    }
    
    
    

}

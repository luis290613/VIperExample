//
//  NetworkError.swift
//  VIperExample
//
//  Created by Diego on 8/10/24.
//

enum NetworkError : Error {
    case invalidURL           // Error cuando la URL es inválida o malformada
    case noData               // Error cuando no se recibe ningún dato de la petición
    case decodingError        // Error al tratar de decodificar los datos recibidos
    case serverError          // Error en el servidor (500, 503, etc.)
    case unauthorized         // Error por autorización (401, 403)
    case timeout              // Error por tiempo de espera agotado
    case unknown              // Error desconocido
}

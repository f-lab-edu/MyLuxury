//
//  ExampleDTO.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/3/24.
//

struct ExampleRespDTO: Decodable {
    
    let value: String
}

extension ExampleRespDTO {
    
    func toExampleEntity() -> ExampleEntity {
        return ExampleEntity(value: value)
    }
}

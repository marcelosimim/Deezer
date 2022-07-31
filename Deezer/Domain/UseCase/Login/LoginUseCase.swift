//
//  LoginUseCase.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/31/22.
//

protocol LoginUseCase {
    func execute(email: String, password:String, completion: @escaping(Error?) -> Void)
}

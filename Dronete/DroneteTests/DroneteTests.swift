//
//  DroneteTests.swift
//  DroneteTests
//
//  Created by Daniel Cazorro Frías on 30/1/24.
//

import XCTest
@testable import Dronete

final class DroneteTests: XCTestCase {

    // MARK: - Properties
    var apiClient: MainViewApiClient!

    // MARK: - Lifecycle
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testPerformanceExample() throws {
        self.measure {
        }
    }

    // Models
    func testItemInitialization() {
        let imageName = "test_image"
        let title = "Test Item"
        
        let item = Item(imageName: imageName, title: title)
        
        XCTAssertEqual(item.imageName, imageName, "Image name should match")
        XCTAssertEqual(item.title, title, "Title should match")
    }

    func testItemEquality() {
        let item1 = Item(imageName: "image1", title: "Item 1")
        let item2 = Item(imageName: "image1", title: "Item 1")
        let item3 = Item(imageName: "image2", title: "Item 2")
        
        XCTAssertEqual(item1, item2, "Items with same properties should be equal")
        XCTAssertNotEqual(item1, item3, "Items with different properties should not be equal")
    }
    
    // StringExtension
    func testEmptyString() {
        XCTAssertEqual(String.empty, "", "String.empty should return an empty string")
    }
    
    // MainCollectionViewCell
    func testPrepareForReuse() {
        // Cargar la celda desde el Nib
        let nib = UINib(nibName: "MainCollectionViewCell", bundle: nil)
        let objects = nib.instantiate(withOwner: nil, options: nil)
        
        // Asegurarse de que estamos obteniendo la celda correcta
        guard let cell = objects.first as? MainCollectionViewCell else {
            XCTFail("No se pudo cargar la celda desde el Nib")
            return
        }
        
        // Asignar valores iniciales a las propiedades
        cell.ivImage.image = UIImage(systemName: "paperplane.fill")
        cell.lbTitle.text = "Test Title"
        
        // Verificar que las propiedades se hayan asignado correctamente
        XCTAssertNotNil(cell.ivImage.image, "La imagen debería estar establecida.")
        XCTAssertEqual(cell.lbTitle.text, "Test Title", "El título debería estar establecido.")
        
        // Llamar a prepareForReuse
        cell.prepareForReuse()
        
        // Verificar que las propiedades se hayan reiniciado
        XCTAssertNil(cell.ivImage.image, "La imagen debería ser nil después de prepareForReuse.")
        XCTAssertEqual(cell.lbTitle.text, String.empty, "El texto debería ser .empty después de prepareForReuse.")
    }
}

//
//  DroneteTests.swift
//  DroneteTests
//
//  Created by Daniel Cazorro Frías on 30/1/24.
//

import XCTest
@testable import Dronete

final class MainViewModelTests: XCTestCase {

    // MARK: - Properties
    var apiClient: DroneAPIClient!

    // MARK: - Lifecycle
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testPerformanceExample() throws {
        self.measure {
        }
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

    // MainViewModel Tests
    func testMainViewModelGrouping() {
        let mockDrones = [
            Drone(manufacturer: "DJI", name: "Mini 2", uasClass: .c1, weight: "250", maxTakeoff: "250", endurance: "30", hasCamera: true, isToy: false),
            Drone(manufacturer: "DJI", name: "Mavic 3", uasClass: .c2, weight: "895", maxTakeoff: "895", endurance: "46", hasCamera: true, isToy: false),
            Drone(manufacturer: "Parrot", name: "Anafi", uasClass: .none, weight: "320", maxTakeoff: "320", endurance: "25", hasCamera: true, isToy: false)
        ]

        let repository = DroneRepositoryMock(drones: mockDrones)
        let viewModel = MainViewModel(repository: repository)
        
        let expectation = XCTestExpectation(description: "Should call didUpdateData")
        viewModel.didUpdateData = {
            expectation.fulfill()
        }

        viewModel.fetchData()

        wait(for: [expectation], timeout: 1.0)

        XCTAssertEqual(viewModel.numberOfManufacturers(), 2)
        XCTAssertEqual(viewModel.droneCount(forManufacturer: "DJI"), 2)
        XCTAssertEqual(viewModel.droneCount(forManufacturer: "Parrot"), 1)
    }
}

// MARK: - Additional Tests

extension MainViewModelTests {
    // ApiError Tests
    func testApiErrorDescriptions() {
        XCTAssertEqual(ApiError.invalidURL.localizedDescription, "La URL de la API no es válida.")
        XCTAssertEqual(ApiError.invalidResponse(statusCode: 404).localizedDescription, "Respuesta inválida del servidor (código 404).")
        XCTAssertEqual(ApiError.invalidResponse(statusCode: nil).localizedDescription, "Respuesta inválida del servidor.")
        XCTAssertEqual(ApiError.noData.localizedDescription, "No se recibió ningún dato de la API.")
        XCTAssertEqual(ApiError.decodingFailed.localizedDescription, "No se pudieron interpretar los datos recibidos.")
        XCTAssertEqual(ApiError.network(NSError(domain: "test", code: 0)).localizedDescription, "Error de red: The operation couldn’t be completed. (test error 0.)")
    }
    
    // AppDelegate Core Data
    func testAppDelegateCoreDataStack() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        XCTAssertNotNil(context)
        appDelegate.saveContext()
    }
    
    // SceneDelegate background call
    func testSceneDelegateMethods() {
        let sceneDelegate = SceneDelegate()
        let scene = UIApplication.shared.connectedScenes.first!
        sceneDelegate.sceneDidDisconnect(scene)
        sceneDelegate.sceneWillResignActive(scene)
        sceneDelegate.sceneDidEnterBackground(scene)
    }
    
    // Extensions
    func testStringIsBlank() {
        XCTAssertTrue("    ".isBlank)
        XCTAssertFalse("Text".isBlank)
    }
    
    func testOptionalOr() {
        let value: String? = nil
        XCTAssertEqual(value.or("fallback"), "fallback")
    }
    
    func testDispatchQueueMainAsyncIfNeeded() {
        let expectation = self.expectation(description: "Should execute on main thread")
        DispatchQueue.mainAsyncIfNeeded {
            XCTAssertTrue(Thread.isMainThread)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testUIColorHexInit() {
        let color = UIColor(hex: "#FF0000")
        XCTAssertNotNil(color)
    }
    
    // MainCollectionViewCell.configure
    func testMainCollectionViewCellConfigure() {
        let nib = UINib(nibName: "MainCollectionViewCell", bundle: nil)
        let objects = nib.instantiate(withOwner: nil, options: nil)
        guard let cell = objects.first as? MainCollectionViewCell else {
            XCTFail("No se pudo cargar la celda desde el Nib")
            return
        }
        cell.configure(with: "DJI")
        XCTAssertEqual(cell.lbTitle.text, "DJI")
        XCTAssertNotNil(cell.ivImage.image)
    }
    
    // MainViewModel.fetchData failure
    func testMainViewModelFetchDataFailure() {
        final class FailingRepo: DroneRepositoryProtocol {
            func fetchDrones(completion: @escaping (Result<[Drone], Error>) -> Void) {
                completion(.failure(ApiError.noData))
            }
        }
        let viewModel = MainViewModel(repository: FailingRepo())
        let expectation = XCTestExpectation(description: "Failure handled")
        viewModel.didUpdateData = {
            XCTFail("No debería llamarse en caso de error")
        }
        viewModel.fetchData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    final class DroneRepositoryMock: DroneRepositoryProtocol {
        private let testDrones: [Drone]
        
        init(drones: [Drone]) {
            self.testDrones = drones
        }
        
        func fetchDrones(completion: @escaping (Result<[Drone], Error>) -> Void) {
            completion(.success(testDrones))
        }
    }
}

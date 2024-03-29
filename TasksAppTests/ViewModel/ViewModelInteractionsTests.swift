//
//  ViewModelInteractions.swift
//  TasksAppTests
//
//  Created by David Zarate-Lopez on 22.03.23.
//

import XCTest
@testable import TasksApp

final class ViewModelInteractions: XCTestCase {

    var viewModel: ViewModel = ViewModel(
        listRepository: WebListRepository(network: mock(NetworkProtocol.self)),
        userRepository: WebUserRepository(network: mock(NetworkProtocol.self))
    )
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }
    
    func test_ViewModel_createUser() {
        //Given
        let newUser = MockData.singleUserData
        
        //When
        for _ in 0..<100 {
            viewModel.createUser(
                id: newUser.id,
                username: newUser.username,
                password: newUser.password
            )
        }
        
        //Then
        XCTAssertEqual(viewModel.users.count, 100)
    }
    
    func test_ViewModel_addList() {
        //Given
        let newList = MockData.singleListData
        
        //When
        for _ in 0..<100 {
            viewModel.addList(newListName: newList.title, selectedColor: newList.color.title)
        }
        
        //Then
        XCTAssertEqual(viewModel.lists.count, 100)
    }
    
    func test_ViewModel_deleteList_success() {
        //Given
        let newList = MockData.singleListData
        for _ in 0..<100 {
            viewModel.addList(newListName: newList.title, selectedColor: newList.color.title)
        }
        
        //When
        for _ in 0..<50 {
            let random = Int.random(in: 0..<viewModel.lists.count)
            let indexSet = IndexSet(integer: random)
            viewModel.deleteList(indexSet: indexSet)
        }
        
        //Then
        XCTAssertEqual(viewModel.lists.count, 50)
    }
    
    func test_ViewModel_deleteList_emptyList_success() {
        //Given
        let indexSet = IndexSet(integer: 0)
        
        //When
        for _ in 0..<100 {
            viewModel.deleteList(indexSet: indexSet)
        }
        
        //Then
        XCTAssertEqual(viewModel.lists.count, 0)
    }
    
    func test_ViewModel_moveListOrder() {
        //Given
        let newList = MockData.singleListData
        for _ in 0..<100 {
            viewModel.addList(newListName: newList.title, selectedColor: newList.color.title)
        }
        
        //When
        for _ in 0..<200 {
            let randomNumber1 = Int.random(in: 0..<100)
            var randomNumber2 = Int.random(in: 1..<100)
            while randomNumber1 == randomNumber2 {
                randomNumber2 = Int.random(in: 1..<100)
            }
            let indexSet = IndexSet(integer: randomNumber1)
            let newIndex = randomNumber2
            
            let firstIndexSetValue = viewModel.lists[randomNumber1]
            viewModel.moveListOrder(indices: indexSet, newOffset: newIndex)
            let mappedIndex = viewModel.lists.firstIndex { $0 == firstIndexSetValue}
            guard let mappedIndex = mappedIndex else { return }
        //Then
            XCTAssertEqual(firstIndexSetValue, viewModel.lists[mappedIndex])
            if randomNumber2 > randomNumber1 {
                XCTAssertEqual(newIndex-1, mappedIndex)
            } else {
                XCTAssertEqual(newIndex, mappedIndex)
            }
        }
    }
    
    func test_ViewModel_addTasks() {
        //Given
        let newList = MockData.singleListData
        let newTask = MockData.singleTask
        viewModel.addList(newListName: newList.title, selectedColor: newList.color.title)
        viewModel.addList(newListName: newList.title, selectedColor: newList.color.title)
        
        //When
        for _ in 0..<100 {
            viewModel.addTasks(newTaskName: newTask.title, index: 0)
        }
        
        for _ in 0..<200 {
            viewModel.addTasks(newTaskName: newTask.title, index: 1)
        }
        
        //Then
        XCTAssertEqual(viewModel.lists[0].tasks.count, 100)
        XCTAssertEqual(viewModel.lists[1].tasks.count, 200)
    }
    
    
    func test_ViewModel_addTasks_IndexOutsideOfLimits() {
        //Given
        let newList = MockData.singleListData
        let newTask = MockData.singleTask
        viewModel.addList(newListName: newList.title, selectedColor: newList.color.title)
        
        //When
        for _ in 0..<100 {
            viewModel.addTasks(newTaskName: newTask.title, index: -1)
        }
        
        for _ in 0..<200 {
            viewModel.addTasks(newTaskName: newTask.title, index: 2)
        }
        
        //Then
        XCTAssertEqual(viewModel.lists[0].tasks.count, 0)
    }
    
    
    func test_ViewModel_deleteTasks() {
        //Given
        let newList = MockData.singleListData
        let newTask = MockData.singleTask
        let indexSet = IndexSet(integer: 0)
        viewModel.addList(newListName: newList.title, selectedColor: newList.color.title)
        for _ in 0..<100 {
            viewModel.addTasks(newTaskName: newTask.title, index: 0)
        }
        
        //When
        for _ in 0..<50 {
            viewModel.deleteTasks(indexSet: indexSet, index: 0)
        }
        
        //Then
        XCTAssertEqual(viewModel.lists[0].tasks.count, 50)
    }
    
    func test_ViewModel_deleteTasks_IndexOutsideOfLimits() {
        //Given
        let newList = MockData.singleListData
        let newTask = MockData.singleTask
        let indexSet = IndexSet(integer: 0)
        viewModel.addList(newListName: newList.title, selectedColor: newList.color.title)
        for _ in 0..<100 {
            viewModel.addTasks(newTaskName: newTask.title, index: 0)
        }
        
        //When
        for _ in 0..<50 {
            viewModel.deleteTasks(indexSet: indexSet, index: -1)
        }
        
        //Then
        XCTAssertEqual(viewModel.lists[0].tasks.count, 50)
    }
    
    func test_ViewModel_moveTaskOrder() {
        //Given
        let newList = MockData.singleListData
        let newTask = MockData.singleTask
        viewModel.addList(newListName: newList.title, selectedColor: newList.color.title)
        for _ in 0..<100 {
            viewModel.addTasks(newTaskName: newTask.title, index: 0)
        }
        
        //When
        for _ in 0..<200 {
            let randomNumber1 = Int.random(in: 0..<100)
            var randomNumber2 = Int.random(in: 1..<100)
            while randomNumber1 == randomNumber2 {
                randomNumber2 = Int.random(in: 1..<100)
            }
            let indexSet = IndexSet(integer: randomNumber1)
            let newIndex = randomNumber2
            let firstIndexSetValue = viewModel.lists[0].tasks[randomNumber1]
            viewModel.moveTaskOrder(indices: indexSet, newOffset: newIndex, index: 0)
            let mappedIndex = viewModel.lists[0].tasks.firstIndex {
                $0 == firstIndexSetValue }
        //Then
            if randomNumber2 > randomNumber1 {
                XCTAssertEqual(newIndex-1, mappedIndex)
            } else {
                XCTAssertEqual(newIndex, mappedIndex)
            }
        }

    }


}

//
//  TimeSlotsCVC.swift
//  Appt
//
//  Created by Agustin Mendoza Romo on 8/8/17.
//  Copyright © 2017 AgustinMendoza. All rights reserved.
//

import UIKit


class TimeSlotsCVC: UICollectionViewController {
  
  private let reuseIdentifier = "TimeSlotCell"
  
  
  var timeSlotter = TimeSlotter()
  var appointmentDate: Date!
  var timeSlots = [Date]()
  let currentDate = Date()
  var currentAppointments: [Appointment]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print(appointmentDate)
    setupTimeSlotter()
  }
  
  func setupTimeSlotter() {
    timeSlotter.configureTimeSlotter(openTimeHour: 9, openTimeMinutes: 0, closeTimeHour: 17, closeTimeMinutes: 0, appointmentLength: 30, appointmentInterval: 15)
    if let appointmentsArray = currentAppointments {
      timeSlotter.currentAppointments = appointmentsArray.map { $0.date! }
    }
    guard let timeSlots = timeSlotter.getTimeSlotsforDate(date: appointmentDate) else { return }
    
    timeSlots.map { print("\($0.hour()):\($0.minute())") }
    self.timeSlots = timeSlots
  }
  

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of items
    return timeSlots.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TimeSlotCell
    
    let timeSlot = timeSlots[indexPath.row]
    if timeSlot.minute() == 0 {
      cell.timeLabel.text = "\(timeSlot.hour()):\(timeSlot.minute())" + "0"
    } else {
      cell.timeLabel.text = "\(timeSlot.hour()):\(timeSlot.minute())"
    }
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if let destinationVC = self.navigationController?.viewControllers[0] as?  NewApptTableViewController {
      destinationVC.selectedTimeSlot = timeSlots[indexPath.row]
      self.navigationController?.popViewController(animated: true)
    } else {
      print("Unable to select timeSlot")
    }
  }
  
}




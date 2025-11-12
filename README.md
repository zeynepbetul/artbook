## ArtBook

**ArtBook** is an iOS application that allows users to document and save the artworks or places they have visited. You can store an image of the artwork along with its details such as artist, title, and year. This project demonstrates practical iOS development skills with **Swift** and **UIKit**, focusing on **data persistence** and **media handling**.

---

### App Overview

- Users can **add artworks** with:
  - An image (selected from the photo library)
  - Artist name
  - Artwork title
  - Year  
- All data is **saved locally** using **Core Data**.  
- Users can **view** previously saved artworks, **delete** entries, and **retrieve** them later.  
- Notifications are sent using **NotificationCenter** when new data is added or updated, allowing real-time updates across the app.

---

### Technologies and Concepts Used

This project showcases core iOS concepts and frameworks:

- **UIKit** – For building and managing the user interface.  
- **Core Data** – For storing, fetching, and deleting artwork data (image, artist, title, year).  
- **UIImagePickerController** – To allow users to pick images from their photo library.  
- **NotificationCenter** – To communicate between view controllers when data changes.

---

### Features

- Add and save artworks with details and images.  
- Persist data locally with Core Data.  
- Edit or delete previously saved artworks.  
- Real-time updates using NotificationCenter.  
- Clean and simple interface for organizing your art collection.

---

### Installation & Running

1. Clone the project to your local machine:
   ```bash
   git clone https://github.com/zeynepbetul/ArtBook.git

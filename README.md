# **README**

## **Instructions for Building and Running the Application**

### **Prerequisites**
- **Xcode**: Ensure you have the latest version of Xcode installed on your system.
- **Swift Version**: The project uses Swift 5, so your development environment must support this version.

---

### **Steps to Build and Run**
1. **Clone the Repository**:
   Clone the repository to your local machine using the following command:
   ```bash
   git clone https://github.com/angiemugo/CoinRepo.git
   ```
2. **Open the Project**:
   Open the project in Xcode by running:
   ```bash
   open CoinApp.xcodeproj
   ```
3. **Build and Run**:
   - Launch the app by clicking the `Run` button in Xcode or pressing `Cmd + R`.

---

### **Assumptions and Design Decisions**

- **Error Handling**:
  - Implemented a custom error view to enhance the user experience during failures.
  - Assumed that user-facing error messages should support localization for potential internationalization.

- **State Management**:
  - Leveraged `UIView` composition for managing loading and error states, ensuring modularity and reusability throughout the app.

- **Reactive Programming**:
  - Combined `async/await` with **Combine** to handle reactive workflows effectively.
  - Explicitly defined failure types in functions like `static func just(_ output: Output)` for better compatibility with Combine's type system.

- **Image Loading**:
  - Integrated a third-party package to handle mixed formats (SVG and PNG) in API responses, prioritizing efficiency over custom implementation.

- **Accessibility**:
  - Accessibility checks were not performed due to time constraints. Assumed default accommodations provided by Apple would suffice.

---

### **Challenges Encountered and Solutions**

1. **Integrating Async/Await with Combine**:
   - Started with `async/await` but transitioned to a hybrid approach, blending it with Combine to align with SwiftUI’s architecture.

2. **Learning Diffable Data Source**:
   - Faced a steep learning curve with `DiffableDataSource` due to limited prior experience. Addressed this by consulting Apple’s documentation and practical experimentation.

---

### **Screenshots**

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/73802092-1a77-46d4-ac69-25f5185ee43f" alt="IMG_0775" width="300"></td>
    <td><img src="https://github.com/user-attachments/assets/2224fa32-0d9e-4cdd-a970-e168554c304d" alt="IMG_0774" width="300"></td>
    <td><img src="https://github.com/user-attachments/assets/bcfaaa72-2a75-43bd-8193-810bd198c337" alt="IMG_0773" width="300"></td>
    <td><img src="https://github.com/user-attachments/assets/d0afcb22-afa5-494b-8a39-a80c380cc0e7" alt="IMG_0772" width="300"></td>
  </tr>
</table>


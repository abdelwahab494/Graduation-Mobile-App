
# **GlucoMate**

**GlucoMate** is a comprehensive mobile application designed to assist diabetes patients in monitoring and managing their blood glucose levels in real-time. The app connects seamlessly with a custom-designed non-invasive hardware device to receive glucose readings, visualize data, predict conditions using machine learning, and provide AI-driven support and reminders.

---

## App Features

- **Non-invasive Glucose Monitoring**  
  Receives real-time glucose data from a custom hardware device that estimates blood sugar levels using infrared signals passed through the patient’s finger and processed via a trained ML model.

- **Data Visualization & History**  
  Stores and displays historical glucose readings using interactive charts.

- **ML-based Diabetes Prediction**  
  Users can fill a medical form and get a prediction about their diabetic status based on a trained classification model via a secure API.

- **24/7 AI Chatbot Support**  
  Powered by **Gemini API**, the chatbot provides instant answers to medical inquiries.

- **Daily Medical Tips**  
  Personalized medical advice and lifestyle tips based on user history.

- **Medication Reminder System**  
  Track medications and receive scheduled reminders to ensure timely doses.

---

## Tech Stack

- **Framework**: Flutter  
- **Language**: Dart  
- **Backend**: Supabase (Cloud Database)  
- **APIs**: Gemini API, HTTPS Requests  
- **Bluetooth Communication**: flutter_bluetooth_serial  
- **Machine Learning**: Integrated ML models (TFLite & external APIs)

---

## Getting Started

```bash
git clone https://github.com/abdelwahab494/GlucoMate
cd GlucoMate
flutter pub get
flutter run
```

> 💡 Make sure you have Flutter installed and configured.  
> [Get Flutter SDK](https://flutter.dev/docs/get-started/install)

---

##  System Architecture

###  Hardware
- Emits infrared signal to the patient’s finger.
- Estimates voltage response and transmits it via Bluetooth.
- Voltage data passed to a trained model to predict glucose level.

###  Mobile App
- Receives and displays real-time glucose data.
- Sends user data to prediction API for diabetes classification.
- Stores all results in Supabase and visualizes them in the UI.
- Provides chatbot + tips + medication tracking features.

---

## 🖼️ Screenshots

You can add screenshots side-by-side using the following Markdown format:
### Sign Up Pages
> The signup screen supports two user types: Patients and Partners. Patients enter their personal info, while partners are required to provide the Patient ID of the person they’re supporting. Before creating an account, users can agree to our Privacy & Security Policy. With their consent, we may use anonymized health data to train our machine learning model, improving prediction accuracy while ensuring full data privacy.

<p float="left">
  <img src="assets\screenshots\auth (2).PNG" width="30%" />
  <img src="assets\screenshots\auth (3).PNG" width="30%" />
  <img src="assets\screenshots\auth (4).PNG" width="30%" />
</p>

### Login Pages
> In our application, we designed a user-friendly login screen that allows users to sign in using their email and password. In case a user forgets their password, they can easily use the "Forgot Password" feature. By entering their email address, a reset token is sent to their inbox. This token is then used to verify their identity and allow them to securely create a new password. This process ensures both ease of use and enhanced security for account recovery.

<p float="left">
  <img src="assets\screenshots\auth (1).PNG" width="30%" />
  <img src="assets\screenshots\auth (5).PNG" width="30%" />
  <img src="assets\screenshots\auth (6).PNG" width="30%" />
</p>

### Home Page & ChatBot
> The home screen provides an easy-to-use interface for the non-invasive glucose monitoring device. It offers quick glucose measurement, health tracking, and personalized daily health tips based on patient data, such as activity levels and glucose readings. A smart chatbot is available 24/7 to answer medical questions and inquiries in both Arabic and English, enhancing patient support.

<p float="left">
  <img src="assets\screenshots\patient (1).PNG" width="30%" />
  <img src="assets\screenshots\patient (2).PNG" width="30%" />
</p>

### Measurement Process
>Upon starting a measurement, a loading screen appears, giving the user time to use the device and begin the process, with data sent via Bluetooth to the mobile application. The next screen displays the glucose reading, such as 122 mg/dL, with options to measure again or save the data and provide feedback. A graph also helps the patient track glucose value changes over the past 7 days.

<p float="left">
  <img src="assets\screenshots\patient (4).PNG" width="30%" />
  <img src="assets\screenshots\patient (5).PNG" width="30%" />
</p>

### Glucose Dashboard
> The glucose history dashboard displays the patient’s glucose data, showing the average glucose level over the last 7 days and the number of readings taken in that period. It features a graph illustrating changes in glucose reading values and lists all measured glucose levels, such as 136.0 mg/dL, with recent readings highlighted.

<p float="left">
  <img src="assets\screenshots\patient (15).PNG" width="30%" />
  <img src="assets\screenshots\patient (16).PNG" width="30%" />
</p>

### Diabetes Prediction Screen
> The prediction feature evaluates a patient’s glucose condition, whether diabetic or not, through a questionnaire with questions on personal info and medical history answered by the user. The data is sent via API to a machine learning model for prediction, and the result—such as a 48% diabetes detection rate—is displayed on the screen with a confidence level and a feedback section to collect the patient’s opinion.

<p float="left">
  <img src="assets\screenshots\patient (6).PNG" width="30%" />
  <img src="assets\screenshots\patient (7).PNG" width="30%" />
  <img src="assets\screenshots\patient (8).PNG" width="30%" />
</p>

### Diabetes Prediction History
> This is the diabetes prediction history for the patient, displaying the latest data entered by the user, including age, BMI, and medical conditions like high blood pressure and high cholesterol, with recent assessments such as a 48% diabetes prediction. It also shows a detailed overview of past evaluations, such as diabetes status updates from July 7, 2025, at 10:09 AM, and allows users to view trends over time, including physical activity levels and general health ratings, all stored for easy reference.


<p float="left">
  <img src="assets\screenshots\patient (3).PNG" width="30%" />
  <img src="assets\screenshots\patient (4).PNG" width="30%" />
  <img src="assets\screenshots\patient (23).PNG" width="30%" />
</p>

### Medicine Tracker
> This system tracks the patient’s medication schedules to improve health and ensure timely intake, providing notifications for each medication’s timing to remind the patient to take their doses. It allows users to add new medicines with details like dosage, meal timing, and frequency, and set a start and end date for each treatment period. The interface also displays a list of current medications, such as PANADOL with a 150mg dose, and sends timely alerts to help patients stay consistent with their treatment plans.

<p float="left">
  <img src="assets\screenshots\patient (8).PNG" width="30%" />
  <img src="assets\screenshots\patient (4).PNG" width="30%" />
  <img src="assets\screenshots\patient (23).PNG" width="30%" />
</p>
---

## 👨‍💻 Development Team

Meet the amazing team behind **GlucoMate**:

- **Abdelwahab Mohamed** – *Flutter Developer & Backend Developer (API & Database)*  
  [LinkedIn](https://www.linkedin.com/in/abd-el-wahab-mohamed/) | [GitHub](https://github.com/abdelwahab494)

- **Abdelrahman Khaled** – *Hardware Engineer*  
  [LinkedIn](https://www.linkedin.com/in/abdelrahman-khaled-0133112b6?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app) 

- **Ahmed Abdelmonem** – *Hardware Engineer*  
  [LinkedIn](https://www.linkedin.com/in/ahmed-abd-el-moneim-b752262b0/) 

- **Mahmoud Hamoda** – *ML Engineer*  
  [LinkedIn](#) | [GitHub](#)

- **Abdelazeem Rashwan** – *ML Engineer*  
  [LinkedIn](#) | [GitHub](#)

- **Ahmed Wael** – *ML Engineer*  
  [LinkedIn](#) | [GitHub](#)

- **Aya Mohamed** – *Hardware Engineer*  
  [LinkedIn](#) | [GitHub](#)

- **Nouran Ahmed** – *Flutter Developer*  
  [LinkedIn](#) | [GitHub](#)

- **Ayatallah Kaled** – *ML Engineer*  
  [LinkedIn](#) | [GitHub](#)


---

## License

This project is under the MIT License.  
Feel free to use, modify, and share with proper attribution.

---

## Contributions

We welcome contributions from the community!  
If you’d like to fix bugs, add features, or improve the UI, feel free to open a pull request or contact us.

---

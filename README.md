**📊 Digital Literacy Rate – A Flutter + ML Typing Speed Classifier**

# 🧠 Digital Literacy Rate

An AI-powered Flutter application that analyzes a user's **typing speed** and **accuracy** to determine their **digital literacy level** using a trained machine learning model.

<img src="https://img.shields.io/badge/Flutter-UI-blue.svg" />
<img src="https://img.shields.io/badge/Machine%20Learning-Python-yellow.svg" />
<img src="https://img.shields.io/badge/FastAPI-Backend-green.svg" />
<img src="https://img.shields.io/badge/License-MIT-lightgrey.svg" />

---

## 🚀 Features

- ⌨️ Real-time typing test interface
- 📊 Calculates **WPM** (Words Per Minute) and **accuracy**
- 🤖 ML model predicts digital literacy level
- 🔁 FastAPI backend for prediction API
- 📈 Optional history and feedback

---

## 🧰 Tech Stack

| Layer     | Technology           |
|-----------|----------------------|
| Frontend  | Flutter              |
| Backend   | FastAPI (Python)     |
| ML Model  | scikit-learn         |
| Data      | Simulated CSV (or manual input) |
| Storage   | (Optional) Firebase or SQLite  |

---

## 🧪 Sample Typing Metrics

| WPM | Accuracy (%) | Predicted Literacy |
|-----|--------------|--------------------|
| 20  | 60           | Beginner           |
| 45  | 90           | Intermediate       |
| 70  | 98           | Advanced           |

---

## 🖥️ Backend Setup (FastAPI + ML)

### 1. Create and activate a Python virtual environment
```bash
python -m venv venv
source venv/bin/activate 
````

### 2. Install dependencies

```bash
pip install fastapi uvicorn scikit-learn joblib pydantic
```

### 3. Train & save the model (optional)

```bash
python backend/train_model.py
```

### 4. Run the FastAPI server

```bash
uvicorn backend.main:app --reload
```

---

## 📲 Flutter Setup

### 1. Navigate to frontend directory

```bash
cd frontend
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Run the app

```bash
flutter run
```

---

## 📡 API Endpoint

### POST `/predict`

**Input:**

```json
{
  "wpm": 45.0,
  "accuracy": 89.0
}
```

**Output:**

```json
{
  "literacy_level": "Intermediate"
}
```

---

## 🔒 License

This project is licensed under the [MIT License](LICENSE).

---

## 🙌 Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

---

## 💡 Future Enhancements

* Add **keystroke dynamics** analysis
* Track **user typing history**
* Add **auth system** using Firebase
* Use **deep learning** models for better accuracy

---

## 🤝 Authors

* [Your Name](https://github.com/your-username)
* Project inspired by digital inclusion efforts worldwide

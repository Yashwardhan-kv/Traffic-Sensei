import os
import joblib
import pandas as pd
from flask import Flask, request, jsonify

# Get the absolute path of the current file
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# Construct the correct path to models
MODEL_PATH = os.path.join(BASE_DIR, "..", "models", "traffic_prediction_model.pkl")
ENCODER_PATH = os.path.join(BASE_DIR, "..", "models", "label_encoders.pkl")

# Ensure files exist
if not os.path.exists(MODEL_PATH):
    raise FileNotFoundError(f"Model file not found at {MODEL_PATH}")

if not os.path.exists(ENCODER_PATH):
    raise FileNotFoundError(f"Encoder file not found at {ENCODER_PATH}")

# Load model and encoders
model = joblib.load(MODEL_PATH)
label_encoders = joblib.load(ENCODER_PATH)

app = Flask(__name__)

@app.route('/')
def home():
    return "Traffic Prediction API is Running!"

@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json()
    
    try:
        # Extract data from request
        hour = int(data["Hour"])
        day = label_encoders["Day of Week"].transform([data["Day of Week"]])[0]
        weather = label_encoders["Weather"].transform([data["Weather"]])[0]
        zone = label_encoders["Zone"].transform([data["Zone"]])[0]
        
        # Create dataframe for prediction
        input_data = pd.DataFrame([[hour, day, weather, zone]],
                                  columns=["Hour", "Day of Week", "Weather", "Zone"])
        
        # Make prediction
        prediction = model.predict(input_data)[0]
        traffic_labels = {0: "Low", 1: "Medium", 2: "High"}
        result = traffic_labels[prediction]
        
        return jsonify({"Traffic Prediction": result})
    
    except Exception as e:
        return jsonify({"error": str(e)})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)

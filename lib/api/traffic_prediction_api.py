from flask import Flask, request, jsonify
import joblib
import pandas as pd

# Load trained model and encoders
model = joblib.load("\models\traffic_prediction_model.pkl")
label_encoders = joblib.load("models\label_encoders.pkl")

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

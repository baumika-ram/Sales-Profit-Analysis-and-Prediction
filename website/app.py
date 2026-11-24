from flask import Flask, render_template, request
import pandas as pd
import joblib

app = Flask(__name__)

model = joblib.load("profit_prediction_model.pkl")
model_columns = joblib.load("model_columns.pkl")


@app.route("/")
def home():
    return render_template("index.html")


@app.route("/predict", methods=["POST"])
def predict():
    try:
        sales = float(request.form["sales"])
        quantity = int(request.form["quantity"])
        discount = float(request.form["discount"])

        category = request.form["category"]
        sub_category = request.form["sub_category"]
        region = request.form["region"]
        segment = request.form["segment"]
        ship_mode = request.form["ship_mode"]

        if sales < 0 or quantity <= 0 or not 0 <= discount <= 1:
            raise ValueError("Invalid input")

        input_data = pd.DataFrame(
            0, index=[0], columns=model_columns
        )

        input_data["Sales"] = sales
        input_data["Quantity"] = quantity
        input_data["Discount"] = discount
        input_data["Sales_Discount"] = sales * discount
        input_data["Sales_Quantity"] = sales * quantity

        categories = {
            "Category": category,
            "Sub-Category": sub_category,
            "Region": region,
            "Segment": segment,
            "Ship Mode": ship_mode
        }

        for column, value in categories.items():
            dummy_column = f"{column}_{value}"

            if dummy_column in input_data.columns:
                input_data.loc[0, dummy_column] = 1

        prediction = model.predict(input_data)[0]

        return render_template(
            "index.html",
            prediction=round(float(prediction), 2)
        )

    except (ValueError, KeyError):
        return render_template(
            "index.html",
            error="Please enter valid input values."
        )


if __name__ == "__main__":
    app.run(debug=True)
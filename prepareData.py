import turicreate as tc

data = tc.image_analysis.load_images("TrainingData", with_path=True)

data["label"] = data["path"].apply(lambda path: "dog" if "dog" in path else "cat")

data.save("cats-dogs.sframe")

data.explore()

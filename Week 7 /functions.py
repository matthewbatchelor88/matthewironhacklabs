from sklearn.linear_model import LinearRegression, Lasso, Ridge, ElasticNet
from sklearn.model_selection import train_test_split

def apply_regression_models(X, y):
    # Split data into train and test sets
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    
    # Initialize models
    models = [LinearRegression(), Lasso(), Ridge(), ElasticNet()]
    model_names = ['Linear Regression', 'Lasso Regression', 'Ridge Regression', 'ElasticNet Regression']
    
    # Dictionary to store results
    results = {}
    
    # Iterate over models
    for model, name in zip(models, model_names):
        # Fit model
        model.fit(X_train, y_train)
        
        # Calculate train and test scores
        train_score = model.score(X_train, y_train)
        test_score = model.score(X_test, y_test)
        
        # Store results
        results[name] = {'Train Score': train_score, 'Test Score': test_score}
        
        # Print results
        print(f"{name}: Train -> {train_score}, Test -> {test_score}")
    
    return results
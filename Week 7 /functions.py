from sklearn.linear_model import LinearRegression, Lasso, Ridge, ElasticNet
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score, precision_score, recall_score

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

def train_test_decision_tree(X, y):
    """
    Train and test a Decision Tree Classifier with different max_depth values.
    
    Parameters:
        X (array-like): Input features.
        y (array-like): Target variable.
        
    Returns:
        dict: A dictionary containing max_depth values as keys and corresponding error metrics
              (accuracy, precision, recall) on both train and test data as values.
    """
    results = {}
    
    # Split the data into training and testing sets
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    
    max_depth_values = range(1, 21)  # Max depth values from 1 to 20
    
    for max_depth in max_depth_values:
        # Initialize and train the Decision Tree Classifier
        clf = DecisionTreeClassifier(max_depth=max_depth, random_state=42)
        clf.fit(X_train, y_train)
        
        # Make predictions on the training set
        y_train_pred = clf.predict(X_train)
        # Make predictions on the testing set
        y_test_pred = clf.predict(X_test)
        
        # Calculate error metrics for training data
        train_accuracy = accuracy_score(y_train, y_train_pred)
        train_precision = precision_score(y_train, y_train_pred)
        train_recall = recall_score(y_train, y_train_pred)
        
        # Calculate error metrics for testing data
        test_accuracy = accuracy_score(y_test, y_test_pred)
        test_precision = precision_score(y_test, y_test_pred)
        test_recall = recall_score(y_test, y_test_pred)
        
        # Store the results
        results[max_depth] = {
            'Train Accuracy': train_accuracy,
            'Train Precision': train_precision,
            'Train Recall': train_recall,
            'Test Accuracy': test_accuracy,
            'Test Precision': test_precision,
            'Test Recall': test_recall
        }
    
    # Print the results in tabular format
    print("Max Depth\tTrain Accuracy\tTrain Precision\tTrain Recall\tTest Accuracy\tTest Precision\tTest Recall")
    for max_depth, metrics in results.items():
        print(f"{max_depth}\t\t{metrics['Train Accuracy']:.4f}\t\t{metrics['Train Precision']:.4f}\t\t{metrics['Train Recall']:.4f}\t\t"
              f"{metrics['Test Accuracy']:.4f}\t\t{metrics['Test Precision']:.4f}\t\t{metrics['Test Recall']:.4f}")
    
    # Recommend the best performing max depth based on test accuracy
    best_accuracy_depth = max(results, key=lambda x: results[x]['Test Accuracy'])
    print(f"\nBest performing max depth based on Test Accuracy: \033[1m{best_accuracy_depth}\033[0m")
    
    # Recommend the best performing max depth based on precision
    best_precision_depth = max(results, key=lambda x: results[x]['Test Precision'])
    print(f"Best performing max depth based on Precision: \033[1m{best_precision_depth}\033[0m")
    
    # Recommend the best performing max depth based on recall
    best_recall_depth = max(results, key=lambda x: results[x]['Test Recall'])
    print(f"Best performing max depth based on Recall: \033[1m{best_recall_depth}\033[0m")
    
    return results
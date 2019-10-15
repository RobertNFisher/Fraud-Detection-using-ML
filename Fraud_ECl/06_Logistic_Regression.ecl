IMPORT STD;
IMPORT Fraud_ECL;
IMPORT ECL_ML;

			
			dataSpliter := RECORD(Fraud_ECL.Files.transactions_enriched_layout)
							UNSIGNED4 rnd; //a Random Number
			END;
			
			// Give each record a random number to tag for splitting		
			taggedDataSet := PROJECT(Fraud_ECL.Files.transactions_enriched_ds, TRANSFORM(dataSpliter, SELF.rnd := RANDOM(), SELF := LEFT));
			
			// Data is shuffled when sorted by random numbers
			taggedDataSetSorted := SORT(taggedDataSet, rnd);
				
			// Split data into training data and testing data
			transactionTrainData := taggedDataSetSorted[1..413700];	// Treat first 70% of data as training data
			transactionTestData := taggedDataSetSorted[413700..590540]; // Treat last 30% of data as testing data
				
			// Convert datasets into numeric fields for the learning models
			// NOTE: We can control which features we consider in our model at this point by concatinating in the parameters ",,'feature_1, feature_3, feature_x, etc'"
			
			//ERROR: WHILE EXPANDING MACRO TOFIELD ******************************************
			ECL_ML.ML.ToField(transactionTrainData, transactionTrainDataNF);
				
			ECL_ML.ML.ToField(transactionTestData, transactionTestDataNF);
			// ******************************************************************************
				
			// Seperate label from train data and test_data
			IndependentTrainData := transactionTrainDataNF(number > 1);	//Train Features
				
			DependentTrainData := transactionTrainDataNF(number = 1), TRANSFORM(RECORDOF(LEFT), SELF.number := 1, SELF := LEFT)); //Train Labels
				
			IndependentTestData := transactionTestDataNF(number > 1);	// Test Features
				
			DependentTestData := transactionTestDataNF(number = 1), TRANSFORM(RECORDOF(LEFT), SELF.number := 1, SELF := LEFT)); // Test Labels
				
			// Using labels and Features, Create a logistic regression Model
			LogReference := ECL_ML.ML.Classify.Logistic();
			LogModel := LogReference.LearnC(IndependentTrainData, DependentTrainData);
			
			// Pass Test features with the model to create a predictions chart for given inputs
			predictions := LogReference.ClassifyC(IndependentTestData, LogModel);
				
			// Pass the predictions to a comparator to check for accuracy
			comparison := LogReference.TestD(DependentTestData, predictions);

OUTPUT(comparison[1..10])
//EXPORT Logistic_Regression := 'todo';
IMPORT STD;
IMPORT Fraud_ECL;
IMPORT ML_Core AS ML;
IMPORT LogisticRegression AS LR;

			
			dataSpliter := RECORD(Fraud_ECL.Files.transactions_enriched_layout)
							UNSIGNED4 rnd; //a Random Number
			END;
			
			
			// Give each record a random number to tag for splitting		
			taggedDataSet := PROJECT(Fraud_ECL.Files.transactions_enriched_ds, TRANSFORM(dataSpliter, SELF.rnd := RANDOM(), SELF := LEFT));
			
			
			// Data is shuffled when sorted by random numbers
			taggedDataSetSorted := SORT(taggedDataSet, rnd);
			
			//enrichedLimited[{taggedDataSetSorted(transactionID != 0 AND transactionAMT != 0.0) AND NOT [TransactionDT, ProductCD, cInfo1, cInfo2, cInfo3, cInfo4, cInfo5, cInfo6, addr1, addr2, dist1, dist2, P_emaildomain, R_emaildomain, associated_addr1, associated_addr2, associated_addr3, associated_addr4, associated_addr5, associated_addr6, associated_addr7, associated_addr8, associated_addr9, associated_addr10, associated_addr11, associated_addr12, associated_addr13, associated_addr14, time_delta1, time_delta2, time_delta3, time_delta4, time_delta5, time_delta6, time_delta7, time_delta8, time_delta9, time_delta10, time_delta11, time_delta12, time_delta13, time_delta14, time_delta15, match1, match2, match3, match4, match5, match6, match7, match8, match9, id_01, id_02, id_03, id_04, id_05, id_06, id_07, id_08, id_09, id_10, id_11, id_12, id_13, id_14, id_15, id_16, id_17, id_18, id_19, id_20, id_21, id_22, id_23, id_24, id_25, id_26, id_27, id_28, id_29, id_30, id_31, id_32, id_33, id_34, id_35, id_36, id_37, id_38, DeviceType, DeviceInfo]}];			
			// Split data into training data and testing data
			transactionTrainData := taggedDataSetSorted[1..100000];	// Treat first 70% of data as training data
			transactionTestData := taggedDataSetSorted[100001..200000]; // Treat last 30% of data as testing data
				
			// Convert datasets into numeric fields for the learning models
			// NOTE: We can control which features we consider in our model at this point by concatinating in the parameters ",,'feature_1, feature_3, feature_x, etc'"
			
			//ERROR: WHILE EXPANDING MACRO TOFIELD ******************************************
			ML.ToField(transactionTrainData, transactionTrainDataNF,,,,'isFraud,TransactionAmnt,TransactionDT,cInfo1,cInfo2,cInfo3');
				
			ML.ToField(transactionTestData, transactionTestDataNF,,,,'isFraud,TransactionAmnt,TransactionDT,cInfo1,cInfo2,cInfo3');
			// ******************************************************************************
				
			// Seperate label from train data and test_data
			IndependentTrainData := transactionTrainDataNF(number > 1);	//Train Features
			OUTPUT(IndependentTrainData, NAMED('IndependentTrainData'));
			
				
			DependentTrainData := PROJECT(transactionTrainDataNF(number = 1), TRANSFORM(RECORDOF(LEFT), SELF.number := 1, SELF := LEFT)); //Train Labels
			OUTPUT(DependentTrainData, NAMED('DependentTrainData'));
			
			DepTrainDiscrete := ML.Discretize.ByRounding(DependentTrainData); //Descrete train data
			OUTPUT(DepTrainDiscrete, NAMED('DepTrainDiscrete'));
				
			IndependentTestData := transactionTestDataNF(number > 1);	// Test Features
			OUTPUT(IndependentTestData, NAMED('IndependentTestData'));
				
			DependentTestData := PROJECT(transactionTestDataNF(number = 1), TRANSFORM(RECORDOF(LEFT), SELF.number := 1, SELF := LEFT)); // Test Labels
			OUTPUT(DependentTestData, NAMED('DependentTestData'));
			
			DepTestDiscrete := ML.Discretize.ByRounding(DependentTestData); //Descrete test data
			OUTPUT(DepTestDiscrete, NAMED('DepTestDiscrete'));	
			
			// Using labels and Features, Create a logistic regression Model
			LogReference := LR.BinomialLogisticRegression();
			LogModel := LogReference.getModel(IndependentTrainData, DepTrainDiscrete);
			
			// Pass Test features with the model to create a predictions chart for given inputs
			predictions := LogReference.Classify(LogModel, IndependentTestData);
			OUTPUT(predictions, NAMED('predictions'));
				
			// Pass the predictions to a comparator to check for accuracy
			comparison := LogReference.Report(LogModel, IndependentTestData, DepTestDiscrete);
			OUTPUT(comparison, NAMED('comparison'));
			
			// Pass the details of the comparison to construct a Confusion Matrix
			results := LR.BinomialConfusion(comparison);
			OUTPUT(results, NAMED('results'));

//EXPORT Logistic_Regression := 'todo';
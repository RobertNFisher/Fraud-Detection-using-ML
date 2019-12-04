IMPORT STD;
IMPORT ReducedData.Fraud_ECL;
IMPORT ML_Core AS ML;
IMPORT LogisticRegression AS LR;

			/*
					Seperates fraud cases from non-fraud cases
			*/

			// Organizes Dataset into fraud cases
			organizedDataSet := SORT(Fraud_ECL.Files.transactions_clean_ds, isFraud); 
			Output(organizedDataSet, NAMED('organizedDataSet'));
			
			// Counts total size of record
			Integer8 size := COUNT(organizedDataSet(organizedDataSet.isFraud IN [1,0])); 
			Output(size, NAMED('size'));
			
			// Counts fraud cases
			Integer8 fraudCases := COUNT(organizedDataSet(organizedDataSet.isFraud IN [1])); 
			Output(fraudCases, NAMED('fraudCases'));
			
			// Determines breakpoint for where fraudCases should start
			INTEGER8 breakPoint := size - fraudCases;	
			
			// Create a set of data that only consists of fraud cases
			fraudCaseDataSet := organizedDataSet[breakPoint+1..size]; 
			OUTPUT(fraudCaseDataSet, NAMED('fraudCaseDataSet')); 
			
			// Create a set of data that only consists of non-fraud cases 
			// NOTE: Selects only 10000 as this is the limit for a WorkUnit, any repeats with fraud cases should be handled wit JOIN
			largeNonFraudCaseDataSet := organizedDataSet[0..10000];  
			OUTPUT(largeNonFraudCaseDataSet, NAMED('largeNonFraudCaseDataSet')); 
			
			
			/*
					Randomly selects an amount of nonFraud cases equal to the total number of given fraud cases
			*/
			dataSpliter := RECORD(Fraud_ECL.Files.transactions_clean_layout)
							UNSIGNED4 rnd; //a Random Number
			END;

			// Give each record a random number to tag for splitting		
			taggedDataSet := PROJECT(largeNonFraudCaseDataSet, TRANSFORM(dataSpliter, SELF.rnd := RANDOM(), SELF := LEFT));
			
			
			// Data is shuffled when sorted by random numbers
			taggedDataSetSorted := SORT(taggedDataSet, rnd);
			
			// Select an equal amount of fraud cases to be used for ML models
			nonFraudCaseDataSet := taggedDataSetSorted[0..fraudCases-1];
			
			/*
					Combines the selected fraud cases and nonfraud cases into an equally split 50/50 dataset
			*/
			
			// Creates a new data set consisting of all 
			evenDataSet := JOIN(fraudCaseDataSet,nonFraudCaseDataSet, LEFT.transactionId = RIGHT.transactionId, FULL OUTER);
			OUTPUT(evenDataSet, NAMED('evenDataSet'));
			
			/*
					Randomly orders cases of fraud and non-fraud cases
			*/
			
			// Give each record a random number to tag for splitting		
			randomDataSet := PROJECT(evenDataSet, TRANSFORM(dataSpliter, SELF.rnd := RANDOM(), SELF := LEFT));
			
			
			// Data is shuffled when sorted by random numbers
			transactions := SORT(randomDataSet, rnd);
			OUTPUT(transactions, NAMED('transactions'));

			reducedLayout := record
					UNSIGNED4 TransactionID := transactions.TransactionID;		
					UNSIGNED1 isFraud := transactions.isFraud;
					UNSIGNED4 TransactionDT := transactions.TransactionDT;
					REAL8 TransactionAmt := transactions.TransactionAmt;
					//STRING1 ProductCD := transactions.ProductCD;
					UNSIGNED3 cInfo1 := transactions.cInfo1;
					REAL4 cInfo2 := transactions.cInfo2;
					REAL4 cInfo3 := transactions.cInfo3;
					//STRING16 cInfo4 := transactions.cInfo4;
					REAL4 cInfo5 := transactions.cInfo5;
					//STRING15 cInfo6 := transactions.cInfo6;
					REAL4 addr1 := transactions.addr1;
					REAL4 dist1 := transactions.dist1;
					REAL4 dist2 := transactions.dist2;
					//STRING16 P_emaildomain := transactions.P_emaildomain;
					//STRING16 R_emaildomain := transactions.R_emaildomain;
					REAL4 associated_addr3 := transactions.associated_addr3;
					REAL4 associated_addr9 := transactions.associated_addr9;
					REAL4 associated_addr13 := transactions.associated_addr13;
					REAL4 time_delta2 := transactions.time_delta2;
					REAL4 time_delta3 := transactions.time_delta3;
					REAL4 time_delta4 := transactions.time_delta4;
					REAL4 time_delta7 := transactions.time_delta7;
					//STRING19 time_delta8 := transactions.time_delta8;
					//STRING19 time_delta9 := transactions.time_delta9;
					REAL4 time_delta10 := transactions.time_delta10;
					REAL4 time_delta11 := transactions.time_delta11;
					REAL4 time_delta12 := transactions.time_delta12;
					REAL4 time_delta13 := transactions.time_delta13;
					REAL4 time_delta14 := transactions.time_delta14;
					REAL4 time_delta15 := transactions.time_delta15;
					//STRING1 match1 := transactions.match1;
					//STRING1 match2 := transactions.match2;
					//STRING1 match3 := transactions.match3;
					//STRING2 match4 := transactions.match4;
					//STRING1 match5 := transactions.match5;
					//STRING1 match6 := transactions.match6;
					//STRING1 match7 := transactions.match7;
					//STRING1 match8 := transactions.match8;
					//STRING1 match9 := transactions.match9;
					REAL4 V1 := transactions.V1;
					REAL4 V2 := transactions.V2;
					REAL4 V5 := transactions.V5;
					REAL4 V7 := transactions.V7;
					REAL4 V8 := transactions.V8;
					REAL4 V12 := transactions.V12;
					REAL4 V14 := transactions.V14;
					REAL4 V19 := transactions.V19;
					REAL4 V24 := transactions.V24;
					REAL4 V25 := transactions.V25;
					REAL4 V27 := transactions.V27;
					REAL4 V28 := transactions.V28;
					REAL4 V36 := transactions.V36;
					REAL4 V38 := transactions.V38;
					REAL4 V44 := transactions.V44;
					REAL4 V46 := transactions.V46;
					REAL4 V47 := transactions.V47;
					REAL4 V54 := transactions.V54;
					REAL4 V55 := transactions.V55;
					REAL4 V56 := transactions.V56;
					REAL4 V61 := transactions.V61;
					REAL4 V67 := transactions.V67;
					REAL4 V75 := transactions.V75;
					REAL4 V77 := transactions.V77;
					REAL4 V78 := transactions.V78;
					REAL4 V83 := transactions.V83;
					REAL4 V86 := transactions.V86;
					REAL4 V88 := transactions.V88;
					REAL4 V89 := transactions.V89;
					REAL4 V107 := transactions.V107;
					REAL4 V108 := transactions.V108;
					REAL4 V109 := transactions.V109;
					REAL4 V110 := transactions.V110;
					REAL4 V112 := transactions.V112;
					REAL4 V113 := transactions.V113;
					REAL4 V114 := transactions.V114;
					REAL4 V115 := transactions.V115;
					REAL4 V116 := transactions.V116;
					REAL4 V118 := transactions.V118;
					REAL4 V119 := transactions.V119;
					REAL4 V121 := transactions.V121;
					REAL4 V122 := transactions.V122;
					REAL4 V124 := transactions.V124;
					UNSIGNED DECIMAL15 V130 := transactions.V130;
					REAL4 V138 := transactions.V138;
					REAL4 V140 := transactions.V140;
					REAL4 V142 := transactions.V142;
					REAL4 V144 := transactions.V144;
					REAL4 V146 := transactions.V146;
					REAL4 V169 := transactions.V169;
					REAL4 V173 := transactions.V173;
					REAL4 V174 := transactions.V174;
					REAL4 V184 := transactions.V184;
					REAL4 V185 := transactions.V185;
					REAL4 V188 := transactions.V188;
					REAL4 V194 := transactions.V194;
					REAL4 V200 := transactions.V200;
					UNSIGNED DECIMAL15 V206 := transactions.V206;
					UNSIGNED DECIMAL15 V209 := transactions.V209;
					UNSIGNED DECIMAL15 V210 := transactions.V210;
					REAL4 V220 := transactions.V220;
					REAL4 V223 := transactions.V223;
					REAL4 V239 := transactions.V239;
					REAL4 V240 := transactions.V240;
					REAL4 V250 := transactions.V250;
					REAL4 V258 := transactions.V258;
					REAL4 V260 := transactions.V260;
					REAL4 V262 := transactions.V262;
					UNSIGNED DECIMAL9 V269 := transactions.V269;
					UNSIGNED DECIMAL15 V270 := transactions.V270;
					REAL4 V281 := transactions.V281;
					REAL4 V282 := transactions.V282;
					REAL4 V283 := transactions.V283;
					REAL4 V284 := transactions.V284;
					REAL4 V286 := transactions.V286;
					REAL4 V289 := transactions.V289;
					REAL4 V290 := transactions.V290;
					REAL4 V300 := transactions.V300;
					REAL4 V305 := transactions.V305;
					UNSIGNED DECIMAL15 V311 := transactions.V311;
					UNSIGNED DECIMAL15 V313 := transactions.V313;
			end;
		

			placeHolder := TABLE(transactions, reducedLayout);
			testSet := placeHolder();
			OUTPUT(testSet,NAMED('Test_Set'));
			
			INTEGER8 totalRecords := COUNT(testSet);
			
			//enrichedLimited[{taggedDataSetSorted(transactionID != 0 AND transactionAMT != 0.0) AND NOT [TransactionDT, ProductCD, cInfo1, cInfo2, cInfo3, cInfo4, cInfo5, cInfo6, addr1, addr2, dist1, dist2, P_emaildomain, R_emaildomain, associated_addr1, associated_addr2, associated_addr3, associated_addr4, associated_addr5, associated_addr6, associated_addr7, associated_addr8, associated_addr9, associated_addr10, associated_addr11, associated_addr12, associated_addr13, associated_addr14, time_delta1, time_delta2, time_delta3, time_delta4, time_delta5, time_delta6, time_delta7, time_delta8, time_delta9, time_delta10, time_delta11, time_delta12, time_delta13, time_delta14, time_delta15, match1, match2, match3, match4, match5, match6, match7, match8, match9, id_01, id_02, id_03, id_04, id_05, id_06, id_07, id_08, id_09, id_10, id_11, id_12, id_13, id_14, id_15, id_16, id_17, id_18, id_19, id_20, id_21, id_22, id_23, id_24, id_25, id_26, id_27, id_28, id_29, id_30, id_31, id_32, id_33, id_34, id_35, id_36, id_37, id_38, DeviceType, DeviceInfo]}];			
			
			// Split data into training data and testing data & project back to reduced layout since we don't need rnd anymore
			transactionTrainData := PROJECT(testSet[1..totalRecords*7/10], reducedLayout);	// Treat first 70% of data as training data
			transactionTestData := PROJECT(testSet[totalRecords*7/10..totalRecords], reducedLayout); // Treat last 30% of data as testing data
				
			// Convert datasets into numeric fields for the learning models
			// NOTE: We can control which features we consider in our model at this point by concatinating in the parameters ",,'feature_1, feature_3, feature_x, etc'"
			
			ML.ToField(transactionTrainData, transactionTrainDataNF,,,,'isFraud,TransactionAmt,cInfo2,associated_addr13,cInfo1,V258,addr1,V283,time_delta7,cInfo5');
				
			ML.ToField(transactionTestData, transactionTestDataNF,,,,'isFraud,TransactionAmt,cInfo2,associated_addr13,cInfo1,V258,addr1,V283,time_delta7,cInfo5');
				
			// Seperate label from train data and test_data
			IndependentTrainData := transactionTrainDataNF(number > 1);	//Train Features
			OUTPUT(IndependentTrainData, NAMED('IndependentTrainData'));
			
			FatIndependentTrainData := ML.Utils.Fat(IndependentTrainData);
				
			DependentTrainData := PROJECT(transactionTrainDataNF(number = 1), TRANSFORM(RECORDOF(LEFT), SELF.number := 1, SELF := LEFT)); //Train Labels
			OUTPUT(DependentTrainData, NAMED('DependentTrainData'));
			
			DepTrainDiscrete := ML.Discretize.ByRounding(DependentTrainData); //Descrete train data
			OUTPUT(DepTrainDiscrete, NAMED('DepTrainDiscrete'));
				
			IndependentTestData := transactionTestDataNF(number > 1);	// Test Features
			OUTPUT(IndependentTestData, NAMED('IndependentTestData'));
			
			FatIndependentTestData := ML.Utils.Fat(IndependentTestData);
				
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
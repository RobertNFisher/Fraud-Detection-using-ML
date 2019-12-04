IMPORT STD;
IMPORT ReducedData.Fraud_ECL;

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
			randomDataSetSorted := SORT(randomDataSet, rnd);
			OUTPUT(randomDataSetSorted, NAMED('randomDataSetSorted'));

			
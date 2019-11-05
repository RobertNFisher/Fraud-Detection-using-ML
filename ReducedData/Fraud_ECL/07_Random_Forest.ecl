IMPORT STD;
IMPORT Fraud_ECL;
//EXPORT movies := 'todo';
import LearningTrees as LT;
import ML_Core;
import ML_Core.Discretize;


transactions := Fraud_ECL.Files.transactions_clean_ds;

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




temp := TABLE(transactions, reducedLayout);
startData := temp();
OUTPUT(startData,NAMED('startData'));

formatRand := record(reducedLayout)
	UNSIGNED4 rnd;
END;


myData := PROJECT(startData, TRANSFORM(formatRand, SELF.rnd := RANDOM() , SELF := LEFT)); //Assign random number to each record
shuffledData := SORT(myData, rnd);		//Shuffle data by sorting on random field
		OUTPUT(myData,NAMED('My_Data'));
		OUTPUT(shuffledData,NAMED('Shuffled_Data'));

//Cut data set into testing and training
//Remove random value as it is no longer needed

trainData := PROJECT(shuffledData[1..20668], reducedLayout); //Treat first 70% as training data
testData := PROJECT(shuffledData[20668..29527], reducedLayout);	//Treat rest as testing data
		OUTPUT(trainData,NAMED('Train_Data'));
		OUTPUT(testData,NAMED('Test_Data'));

//Convert data into cell-oriented matrix: NumericField
ML_Core.ToField(trainData, trainingDataNF);
ML_Core.ToField(testData, testDataNF);
		OUTPUT(trainingDataNF,NAMED('trainingDataNF'));
		OUTPUT(testDataNF,NAMED('testDataNF'));

indTestData := testDataNF(number > 1);	//Number is the field number; excludes record ID & dependent field

//Dependent record is isFraud, which is feature 1 (number 1) [ignoring ID field]
//using the PROJECT to set the number field = 1 is not strictly necessary, but is good practice.  
//This indicates that it is the first field of the dependent data.  Since there is only one Dependent 
//field, we number it accordingly.
depTestData := PROJECT(testDataNF(number = 1), TRANSFORM(RECORDOF(left), self.number := 1, self := left));

indTrainData := trainingDataNF(number > 1);
depTrainData := PROJECT(trainingDataNF(number = 1), TRANSFORM(RECORDOF(left), self.number := 1, self := left));
		OUTPUT(indTestData,NAMED('indTestData'));
		OUTPUT(depTestData,NAMED('depTestData'));
		OUTPUT(indTrainData,NAMED('indTrainData'));
		OUTPUT(depTrainData,NAMED('depTrainData'));

//Convert the NumericField records for the dependent data containing class labels into DiscreteField records
depTrainDataDF := Discretize.ByRounding(depTrainData);
depTestDataDF := Discretize.ByRounding(depTestData);
		OUTPUT(depTrainDataDF,NAMED('depTrainDataDF'));
		OUTPUT(depTestDataDF,NAMED('depTestDataDF'));

learner := LT.ClassificationForest();
modelC := learner.GetModel(indTrainData, depTrainDataDF); // *second param uses the DiscreteField dataset
predictedClasses := learner.Classify(modelC, indTestData);
assesmentC := ML_Core.Analysis.Classification.Accuracy(predictedClasses, depTestDataDF); // Both params are DF dataset
		OUTPUT(assesmentC,NAMED('assesmentC'));

fi := learner.FeatureImportance(modelC);
		OUTPUT(fi,NAMED('Feature_Importance'));
confusion := learner.ConfusionMatrix(modelC, depTestDataDF, indTestData);
		OUTPUT(confusion,NAMED('Confusion_matrix'));
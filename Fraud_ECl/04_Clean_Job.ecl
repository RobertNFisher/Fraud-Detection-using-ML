IMPORT STD;
IMPORT Fraud_ECL;

//Fraud_ECL.Files.transactions_raw_layout clean(Fraud_ECL.Files.transactions_raw_layout raw) := TRANSFORM
Fraud_ECL.Files.transactions_clean_layout clean(Fraud_ECL.Files.transactions_raw_layout raw) := TRANSFORM
		SELF.TransactionID := (UNSIGNED4) raw.TransactionID;
		SELF.isFraud := (UNSIGNED1) raw.isFraud;
		SELF.TransactionDT := (UNSIGNED4) raw.TransactionDT;
		SELF.TransactionAMT := (REAL8) raw.TransactionAMT;
		SELF.ProductCD := (STRING1) raw.ProductCD;
		SELF.cInfo1 := (UNSIGNED3) raw.card1;
		SELF.cInfo2 := (REAL4) raw.card2;
		SELF.cInfo3 := (REAL4) raw.card3;
		SELF.cInfo4 := (STRING16) raw.card4;
		SELF.cInfo5 := (REAL4) raw.card5;
		SELF.cInfo6 := (STRING6) raw.card6;
		SELF.addr1 := (REAL4) raw.addr1;
		SELF.addr2 := (REAL4) raw.addr2;
		SELF.dist1 := (REAL4) raw.dist1;
		SELF.dist2 := (REAL4) raw.dist2;
		SELF.p_emaildomain := (STRING16) raw.P_emaildomain;
		SELF.r_emaildomain := (STRING16) raw.R_emaildomain;
		SELF.associated_addr1 := (REAL4) raw.c1;
		SELF.associated_addr2 := (REAL4) raw.c2;
		SELF.associated_addr3 := (REAL4) raw.c3;
		SELF.associated_addr4 := (REAL4) raw.c4;
		SELF.associated_addr5 := (REAL4) raw.c5;
		SELF.associated_addr6 := (REAL4) raw.c6;
		SELF.associated_addr7 := (REAL4) raw.c7;
		SELF.associated_addr8 := (REAL4) raw.c8;
		SELF.associated_addr9 := (REAL4) raw.c9;
		SELF.associated_addr10 := (REAL4) raw.c10;
		SELF.associated_addr11 := (REAL4) raw.c11;
		SELF.associated_addr12 := (REAL4) raw.c12;
		SELF.associated_addr13 := (REAL4) raw.c13;
		SELF.associated_addr14 := (REAL4) raw.c14;
		SELF.time_delta1 := (REAL4) raw.d1;
		SELF.time_delta2 := (REAL4) raw.d2;
		SELF.time_delta3 := (REAL4) raw.d3;
		SELF.time_delta4 := (REAL4) raw.d4;
		SELF.time_delta5 := (REAL4) raw.d5;
		SELF.time_delta6 := (REAL4) raw.d6;
		SELF.time_delta7 := (REAL4) raw.d7;
		SELF.time_delta8 := (STRING19) raw.d8;
		SELF.time_delta9 := (STRING19) raw.d9;
		SELF.time_delta10 := (REAL4) raw.d10;
		SELF.time_delta11 := (REAL4) raw.d11;
		SELF.time_delta12 := (REAL4) raw.d12;
		SELF.time_delta13 := (REAL4) raw.d13;
		SELF.time_delta14 := (REAL4) raw.d14;
		SELF.time_delta15 := (REAL4) raw.d15;
		SELF.match1 := (STRING1) raw.m1;
		SELF.match2 := (STRING1) raw.m2;
		SELF.match3 := (STRING1) raw.m3;
		SELF.match4 := (STRING2) raw.m4;
		SELF.match5 := (STRING1) raw.m5;
		SELF.match6 := (STRING1) raw.m6;
		SELF.match7 := (STRING1) raw.m7;
		SELF.match8 := (STRING1) raw.m8;
		SELF.match9 := (STRING1) raw.m9;
END;

cleanedStart := PROJECT(Fraud_ECL.Files.transactions_raw_ds, clean(LEFT));  

sortedClean := SORT(cleanedStart, TransactionID);

dedupedClean := DEDUP(sortedClean, LEFT.TransactionID=RIGHT.TransactionID);

cleaned := dedupedClean(TransactionID > 0);

OUTPUT(cleaned,,Fraud_ECL.Files.transactions_clean_file_path, THOR, COMPRESSED, OVERWRITE);

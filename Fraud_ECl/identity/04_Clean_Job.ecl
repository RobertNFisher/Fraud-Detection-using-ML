IMPORT STD;
IMPORT Fraud_ECL;

Fraud_ECL.identity.Files.identity_clean_layout clean(Fraud_ECL.identity.Files.identity_raw_layout raw) := TRANSFORM
		SELF.TransactionID := (UNSIGNED4) raw.TransactionID;
		SELF.id_01 := (REAL4) raw.id_01;
		SELF.id_02 := (REAL8) raw.id_02;
		SELF.id_03 := (REAL4) raw.id_03;
		SELF.id_04 := (REAL4) raw.id_04;
		SELF.id_05 := (REAL4) raw.id_05;
		SELF.id_06 := (REAL4) raw.id_06;
		SELF.id_07 := (REAL4) raw.id_07;
		SELF.id_08 := (REAL4) raw.id_08;
		SELF.id_09 := (REAL4) raw.id_09;
		SELF.id_10 := (REAL4) raw.id_10;
		SELF.id_11 := (REAL4) raw.id_11;
		SELF.id_12 := (REAL8) raw.id_12;
		SELF.id_13 := (REAL4) raw.id_13;
		SELF.id_14 := (REAL4) raw.id_14;
		SELF.id_15 := (STRING7) raw.id_15;
		SELF.id_16 := (STRING8) raw.id_16;
		SELF.id_17 := (REAL4) raw.id_17;
		SELF.id_18 := (REAL4) raw.id_18;
		SELF.id_19 := (REAL4) raw.id_19;
		SELF.id_20 := (REAL4) raw.id_20;
		SELF.id_21 := (REAL4) raw.id_21;
		SELF.id_22 := (REAL4) raw.id_22;
		SELF.id_23 := (STRING20) raw.id_23;
		SELF.id_24 := (REAL4) raw.id_24;
		SELF.id_25 := (REAL4) raw.id_25;
		SELF.id_26 := (REAL4) raw.id_26;
		SELF.id_27 := (STRING8) raw.id_27;
		SELF.id_28 := (STRING5) raw.id_28;
		SELF.id_29 := (STRING8) raw.id_29;
		SELF.id_30 := (STRING16) raw.id_30;
		SELF.id_31 := (STRING30) raw.id_31;
		SELF.id_32 := (REAL4) raw.id_32;
		SELF.id_33 := (STRING9) raw.id_33;
		SELF.id_34 := (STRING15) raw.id_34;
		SELF.id_35 := (STRING1) raw.id_35;
		SELF.id_36 := (STRING1) raw.id_36;
		SELF.id_37 := (STRING1) raw.id_37;
		SELF.id_38 := (STRING1) raw.id_38;
		SELF.DeviceType := (STRING7) raw.DeviceType;
		SELF.DeviceInfo := (STRING43) raw.DeviceInfo;
END;

cleanedStart := PROJECT(Fraud_ECL.identity.Files.identity_raw_ds, clean(LEFT));  

sortedClean := SORT(cleanedStart, TransactionID);

dedupedClean := DEDUP(sortedClean, LEFT.TransactionID=RIGHT.TransactionID);

cleaned := dedupedClean(TransactionID > 0);

OUTPUT(cleaned,,Fraud_ECL.identity.Files.identity_clean_file_path, THOR, COMPRESSED, OVERWRITE);

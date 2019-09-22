IMPORT  Fraud_ECL;
IMPORT DataPatterns;

rawIdentityData := Fraud_ECL.identity.Files.identity_raw_ds;
OUTPUT(rawIdentityData, NAMED('rawIdentityDataSample'));

rawIdentityProfileResults := DataPatterns.Profile(rawIdentityData, features := 'fill_rate,cardinality,best_ecl_types,lengths,patterns,modes');
OUTPUT(rawIdentityProfileResults,,Fraud_ECL.identity.Files.identity_data_patterns_raw_file_path, OVERWRITE);
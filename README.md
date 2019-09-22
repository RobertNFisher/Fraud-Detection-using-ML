# Fraud Detection Using Machine Learning
### Senior Capstone Project with LexisNexis's HPCC Systems @Kennesaw State University
This project uses LexisNexis's HPCC Systems and ECL to analyze databases of credit card transactional data to detect fraud and anomalies. The project will first conduct data preprocessing and deterministic modeling using a static ruleset to mark the most obvious anomalous factors. Two different Machine Learning models will then be implemented, one with supervised learning using Logic Regression and one with unsupervised learning using an Agglomerative Hierarchical Clustering technique. These results will be compared to determine which is the better method, and will then use Python data visualization libraries to visualize and interpret the output into a “Client Report”.

***Technologies Used:** ECL with ECL-ML library, HPCC Systems, SQL, Python* 

### File Run Order: 
**First import transactions & identity** (doesn't matter which you import first, but this HAS to be complete before running job 05)

For transactions:
  
    1. 01_Data_Import
    2. 02_Data_Import_Validate_Job
    3. OPTIONAL: 03_Data_Patterns_Job
    4. 04_Clean_Job
For identity:
  
    1. identity/01_Data_Import
    2. identity/02 Import_Validate_Job
    3. OPTIONAL: identity/03_Data_Patterns_Job
    4. identity/04_Clean_Job

**Then you can run 05_Enrich_Data**.

This is the run order when you're running from scratch. If you have already imported, validated, and cleaned both transactions and identity data using the current code version, then you can ignore this somewhat. 

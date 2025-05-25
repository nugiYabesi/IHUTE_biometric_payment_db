# ✋🏽 IHUTE – Intelligent Handling and Utilization of Ticketing Efficiency

## 👤 Author  
**Iyukuri Nugi Yabesi**  
**Student ID: 27327**  
**DATABASE MANAGEMENT WITH PL/SQL**

---

## 🧾 Project Description
**IHUTE (Intelligent Handling and Utilization of Ticketing Efficiency)** is a biometric palm-payment system built with Oracle SQL & PL/SQL. It enables secure, seamless, and rapid payments through biometric scanners at high-volume venues like stadiums and transport terminals. The system incorporates advanced auditing, restrictions, and modular PL/SQL logic to ensure integrity and real-time processing.

---

## ✅ Project Objectives

- ✅ Build a relational Oracle DB to model a biometric payment system.
- 🔒 Implement secure DML restrictions using triggers and holidays logic.
- 💾 Store, retrieve, and analyze transaction records.
- 🧠 Automate core logic using functions, procedures, and packages.
- 📜 Audit user actions and DML operations for accountability.

---

## 📌 Table of Contents

| Phase | Title                                               |
|-------|-----------------------------------------------------|
| Phase I   | [Problem Statement](#phase-i--problem-statement)               |
| Phase II  | [Business Process Modeling (BPMN)](#phase-ii--business-process-modeling-bpmn)  |
| Phase III | [Logical Model Design (ERD)](#phase-iii--logical-model-design-erd)          |
| Phase IV  | [PDB Creation & OEM Monitoring](#phase-iv--pdb-creation--oem-monitoring)      |
| Phase V   | [Table Implementation & Data Insertion](#phase-v--table-implementation--data-insertion) |
| Phase VI  | [Database Interaction & PL/SQL Packages](#phase-vi--database-interaction--plsql-packages)  |
| Phase VII | [Advanced Programming & Auditing](#phase-vii--advanced-programming--auditing) |
| Summary   | [Project Summary & Recommendations](#summary--recommendations)             |

---

## 🔹 Phase I – Problem Statement

Manual ticketing and payment systems are prone to fraud, delay, and inefficiencies. IHUTE solves this by allowing customers to use palm or face biometrics for secure, fast, and trackable payments.

🎯 **Goals**:
- Reduce transaction wait time and fraud
- Secure sensitive data via PL/SQL triggers and audit logs
- Automate analysis using packages and analytics functions

---

## 🔹 Phase II – Business Process Modeling (BPMN)

The system includes:
- **User** (initiates payment),
- **Scanner** (captures biometric),
- **Authentication Server** (validates),
- **Payment Gateway** (processes funds),
- **Merchant System** (issues access)

📸 ![PALM_PAYMENT_BPMN](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/ce93f97da23ac081051ca0bb3d5b293c8783331d/PHASE%202/PALM_PAYMENT_BPMN.png)

🧠 **MIS Integration**:
- Logs real-time payment
- Tracks authentication
- Triggers alerts on failed validation


---

## 🔹 Phase III – Logical Model Design (ERD)

Entities:  
- `Client`  
- `Account`  
- `Merchant`  
- `Transaction`  
- `Scanner`  
- `Payment_Gateway`  

📸 ![Entity-Relationship (ER) Model](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/6267d3f4207c6fcc546da5f41ff99bcf71701cc6/PHASE%203/phase%203%20ERD.png)
   

---

## 🔹 Phase IV – PDB Creation & OEM Monitoring

### Oracle Pluggable Database (PDB)
- ✅ Name: `THU_27327_YABESI_PALMPAYMENT`
- 👤 Admin User: `palm_payment`
- 🔐 Password: `YABESI`

📸 ![MAKING OF PDB](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/c34756e8cee14b9131ac4a310702c8a174753cfa/PHASE%204/MAKING%20OF%20DB.png)

### Oracle Enterprise Manager (OEM)
- Configured at `https://localhost:5501/em`
- Shows session stats, DB usage, and schema status

📸 ![OBSERVATION IN OEM](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/c34756e8cee14b9131ac4a310702c8a174753cfa/PHASE%204/ORACLE%20EXPRESS%20MANAGER.png)

---

## 🔹 Phase V – Table Implementation & Data Insertion

### Sample Tables & Constraints
- `Client`, `Account`, `Transaction`, `Payment_Gateway`, `Merchant`, `Scanner`

🔐 Constraints: `NOT NULL`, `CHECK`, `UNIQUE`, `FOREIGN KEY`

📎 [SYNTAX FOR TABLE CREATION AND DATA INSERTION](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/67207fb54f0dbee25d8bb8d726f155df33f01594/PHASE%205/SYSNTAX%20FOR%20creating%20table%20%2C%20adding%20data%20and%20Setting%20constraints%20such%20as%20NOT%20NULL%2C%20UNIQUE%2C%20and%20CHECK%20to%20ensure%20data%20.sql)

📸 ![TABLE CREATION AND DATA INSERTION](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/67207fb54f0dbee25d8bb8d726f155df33f01594/PHASE%205/3.data%20being%20inserted%20into%20the%20tables.png)
  
📸 ![SYS USER CONNECTED TO OEM](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/67207fb54f0dbee25d8bb8d726f155df33f01594/PHASE%205/2.%20user%20SYS%20connected%20to%20OEM.png)

---

## 🔹 Phase VI – Database Interaction & PL/SQL Packages

### Problem: Analyze spending behavior per user

### ✅ DDL: Create `Transaction_Analysis` Table  
📎 [DDL OPERATIONS](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/92ebf07c46a098ddb93cf32a5a447b9880622201/PHASE%206/DDL%20OPERATIONS.sql)

📸 ![DDL OPERATIONS](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/92ebf07c46a098ddb93cf32a5a447b9880622201/PHASE%206/DDL%20LANGUAGE.png)


### ✅ DML: Insert, Update, Delete  
📎 [DML INSERT](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/5c42983f18023d1bb87524fa4f8198ac80fa19d2/PHASE%206/DML%20INSERT.sql)

📸 ![DML INSERT](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/5c42983f18023d1bb87524fa4f8198ac80fa19d2/PHASE%206/INSERT.png)

### ✅ Function: Get Cumulative Spending  
📎 [Implement a Simple Function Using Window Functions AND TEST](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/24e01d837a75f25521f3ffaa4412de7ed8663d75/PHASE%206/Implement%20a%20Simple%20Function%20UsING%20WINDOW%20FUNCTION.sql)

📸 ![Implement a Simple Function Using Window Functions AND TEST](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/24e01d837a75f25521f3ffaa4412de7ed8663d75/PHASE%206/window%20functions.png)

### ✅ Procedure: Analyze_Spending  
📎[Procedure for Data Analysis](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/fd5e1ed111beab60055f87a08c8b258874cd6344/PHASE%206/Procedure%20for%20Data%20Analysis.sql) 

📸 ![Procedure for Data Analysis](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/fd5e1ed111beab60055f87a08c8b258874cd6344/PHASE%206/procudure%20.png)


### ✅ Package: `Data_Analysis_Pkg`  
- Includes both procedure and function for reuse  
📎 [package](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/a13e3b19607a3e1fa5cac8fc63abb6fd04afc5ac/PHASE%206/Package%20Specification%20%26%20package%20BODY%20AND%20TEST.sql)

📸 ![package](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/a13e3b19607a3e1fa5cac8fc63abb6fd04afc5ac/PHASE%206/procudure%20.png)


---

## 🔹 Phase VII – Advanced Programming & Auditing

### 🔐 Objective:
Prevent DML on weekdays and holidays, and log attempts.

### Step 1: Holidays Table  
[Holidays table syntax](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/9bb859fe5ce873c6c4605442184da21349cffca4/PHASE%207/HOLIDAYS%20TABLE%20SYNTAX.sql)
 
---

### 🔁 Trigger 1: Simple Restriction Trigger  
📎 [SIMPLE TRIGGER](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/9bb859fe5ce873c6c4605442184da21349cffca4/PHASE%207/simpler%20trigger%20syntax.sql)
 
[TEST:TRYING BLOCKED OPERATION (INSERT) ON SIMPLE TRIGGER](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/9bb859fe5ce873c6c4605442184da21349cffca4/PHASE%207/trying%20a%20blocked%20operation%20ON%20SIMPLE%20TRIGGER.sql)

![TEST:TRYING BLOCKED OPERATION (INSERT) ON SIMPLE TRIGGER](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/9bb859fe5ce873c6c4605442184da21349cffca4/PHASE%207/TRYING%20BLOCKED%20OPERATION%20INSERT%20on%20simple%20trigger.png)


---

### 🔁 Trigger 2: Compound Trigger with Logging  
📎 [COMPOUND TRIGGER SYNTAX](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/842438c9634b03f24b8502985f28b0a0e91c228e/PHASE%207/COMPOUND%20TRIGGER%20SYNTAX.sql) 

[TESTING BLOCKED OPERATION ON COMPOUND TRIGGER](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/12837c72fd686f96ea5bb88dc2b04d87f3130be9/PHASE%207/test%20trying%20blocked%20operation%20on%20compound%20trigger.sql)

📸 ![TESTING BLOCKED OPERATION ON COMPOUND TRIGGER](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/12837c72fd686f96ea5bb88dc2b04d87f3130be9/PHASE%207/trying%20insert%20on%20compound%20trigger%20.png)  

---

### 📝 Step 2: Create `Audit_Log` Table  
- Logs: `UserID`, `Action`, `Status`, `DateTime`, `Table`  
📎 [CREATION OF AUDIT TABLE](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/c215fb426ae8d2c66c39aac72bfaf2077c493bd8/PHASE%207/CREATION%20OF%20AUDIT%20TABLE.sql) 

---

### 📦 Step 3: Create `Audit_Pkg`
- `Log_Audit()` logs attempts
- `Is_Authorized()` blocks unauthorized users

📎 [audit package and package body](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/c215fb426ae8d2c66c39aac72bfaf2077c493bd8/PHASE%207/audit%20package%20and%20package%20body.sql)


---

### 🔁 Final Trigger: `trg_secure_transaction_dml`
- Uses both the `Audit_Pkg` and restrictions  
📎 [Triggers to block unauthorized access or manipulation and Functions and packages to automate audit tracking](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/c215fb426ae8d2c66c39aac72bfaf2077c493bd8/PHASE%207/Triggers%20to%20block%20unauthorized.sql)
  
[TEST : CAN THE TRIGGER BLOCK UNAUTHORIZED USERS FROM MANIPULATING DATA?](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/c215fb426ae8d2c66c39aac72bfaf2077c493bd8/PHASE%207/test%20UNAUTHORIZED%20USER.sql) 


## 🧪 Testing RESULTS

[audit logs](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/c215fb426ae8d2c66c39aac72bfaf2077c493bd8/PHASE%207/audit%20logs%20results.sql)


![TEST OF UNATHOURIZED USER](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/da2c51d0fc827e355150c308849b74d65a2f56e2/PHASE%207/UNAUTHORIZED%20USER.png)

![AUDIT LOGS](https://github.com/nugiYabesi/IHUTE_biometric_payment_db/blob/da2c51d0fc827e355150c308849b74d65a2f56e2/PHASE%207/audit%20log%20results.png)

---

## ✅ Summary

| Phase     | Description                             | Status   |
|-----------|-----------------------------------------|----------|
| Phase I   | Problem Statement                        | ✅ Done  |
| Phase II  | BPMN Diagram & MIS Process Modeling      | ✅ Done  |
| Phase III | Logical Design and ERD                   | ✅ Done  |
| Phase IV  | PDB Creation + OEM Monitoring            | ✅ Done  |
| Phase V   | Table Structure and Data Insertion       | ✅ Done  |
| Phase VI  | Packages, Procedures, DDL/DML Analytics  | ✅ Done  |
| Phase VII | Triggers + Auditing with Restrictions    | ✅ Done  |

---

## 💡 Recommendations

- 🔁 Keep the `Holidays` table updated each month to maintain accurate restrictions.
- 🔒 Enhance the security model by integrating user roles with RBAC (Role-Based Access Control).
- 📊 Automate monthly audit reports using scheduled PL/SQL jobs.
- 🧠 Extend the solution by creating a front-end biometric reader using Python, Java, or Flutter.
- 📱 Integrate SMS/email notifications for high-value or blocked transactions.

---

## 📬 Contact

- 👨‍💻 **Author:** Iyukuri Nugi Yabesi  
- 🆔 **Student ID:** 27327  
- 🏫 **Degree:** Bachelor of Technology in Software Engineering  
- 📧 **Email:** nugiybes@gmail.com  
- 📱 **Phone:** +250 790 052 578

---

## 🧠 Brain Teaser

> “If the palm can be used to pay,  
> Then one day, what might your heartbeat say?  
> When data meets biology and rules obey,  
> What can **PL/SQL** help secure or automate today?”  
>  
> 🔍 _Think about the future of biometrics, security, and intelligent systems._

---
